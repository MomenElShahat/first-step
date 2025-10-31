import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_step/firebase_options.dart';
import 'package:first_step/notification/global_notification.dart';
import 'package:first_step/pages/lifecycle/data/lifecycle_api_provider.dart';
import 'package:first_step/pages/lifecycle/data/lifecycle_repository.dart';
import 'package:first_step/pages/lifecycle/presentation/controller/lifecycle_controller.dart';
import 'package:first_step/pages/no_internet_page.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/services/internet_service.dart';
import 'package:first_step/services/pusher_service.dart';
import 'package:first_step/shared/logger/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'config/ConfigReader.dart';
import 'consts/colors.dart';
import 'consts/storage.dart';
import 'consts/themes.dart';
import 'lang/translation_service.dart';
import 'package:app_links/app_links.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/foundation.dart';

// ✅ Top-level function is already in GlobalNotification.dart

class NativeBridge {
  static const _channel = MethodChannel('com.firststep.firststepapp/native');

  static Future<void> sendTokenToNative(String token) async {
    try {
      await _channel.invokeMethod('setAuthToken', {'token': token});
    } catch (e) {
      print('Error sending token to native: $e');
    }
  }
}

void main() {
  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      await GetStorage.init('userData');
      await GetStorage.init('appLanguage');
      await GetStorage.init(StorageKeys.boarding);
      await GetStorage.init(StorageKeys.splashImages);

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorCode.primary600,
      ));

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      GlobalNotification().setupNotification();

      await Get.putAsync(() => PusherService().init());

      final authService = Get.put(AuthService(), permanent: true);
      await authService.onInit();
      Get.put(InternetService(), permanent: true);

      Get.put<ILifecycleProvider>(LifecycleProvider(), permanent: true);
      Get.put<ILifecycleRepository>(
        LifecycleRepository(provider: Get.find()),
        permanent: true,
      );
      Get.put<LifecycleController>(
        LifecycleController(lifecycleRepository: Get.find()),
        permanent: true,
      );

      await ConfigReader.initialize();

      timeago.setLocaleMessages('ar', timeago.ArMessages());
      timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

      SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );

      // Disable prints in DEBUG MODE
      if (kDebugMode) {
        debugPrint = (String? message, {int? wrapWidth}) {};
      }

      runApp(const MyApp());
    },
        (error, stack) {
      if (!kReleaseMode) {
        debugPrint('Uncaught zone error: $error');
        debugPrint(stack.toString());
      }
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        // Suppress print() in RELEASE mode
        if (!kReleaseMode) {
          parent.print(zone, line);
        }
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.mobile;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  StreamSubscription? _linkSub;
  AppLinks? _appLinks;

  void initDeepLinks() async {
    _appLinks = AppLinks();
    final initialUri = await _appLinks?.getInitialLink();
    if (initialUri != null) {
      _handleUri(initialUri);
    }
    _linkSub = _appLinks?.uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });
  }

  void _handleUri(Uri uri) {
    print('Received deep link: $uri');
    Get.toNamed(Routes.BOTTOM_NAVIGATION);
  }

  @override
  void initState() {
    initConnectivity();
    initDeepLinks();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _linkSub?.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    if (!mounted) return;
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    print(result.first.name);
    setState(() {
      _connectionStatus = result.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.name == "none") {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return const NoInternetScreen();
        },
      );
    } else {
      return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            enableLog: true,
            logWriterCallback: Logger.write,
            theme: Themes.light,
            themeMode: ThemeMode.light,
            getPages: AppPages.routes,
            initialRoute: Routes.SPLASH,
            locale: Locale(AuthService.to.language ?? 'ar'),
            fallbackLocale: TranslationService.fallbackLocale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            translations: TranslationService(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
          );
        },
      );
    }
  }
}
