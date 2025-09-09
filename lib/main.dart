import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_step/pages/lifecycle/bindings/lifecycle_binding.dart';
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
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'lang/translation_service.dart';
import 'package:app_links/app_links.dart';
import 'package:timeago/timeago.dart' as timeago;

class NativeBridge {
  static const _channel = MethodChannel('com.qader.firststep/native');

  static Future<void> sendTokenToNative(String token) async {
    try {
      await _channel.invokeMethod('setAuthToken', {'token': token});
    } catch (e) {
      print('Error sending token to native: $e');
    }
  }
}

void main() async {
  await GetStorage.init('userData');
  await GetStorage.init('appLanguage');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:
        ColorCode.primary600, // Change this to whatever color you want
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => PusherService().init());
  await GetStorage.init(StorageKeys.boarding);
  await GetStorage.init(StorageKeys.splashImages);
  await ConfigReader.initialize();
  // GlobalNotification().setupNotification();
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

  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
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
    // App started with a deep link
    final initialUri = await _appLinks?.getInitialLink();
    if (initialUri != null) {
      _handleUri(initialUri);
    }
    // Listen for link changes while app is running
    _linkSub = _appLinks?.uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });
  }

  void _handleUri(Uri uri) {
    // Example: https://firststep-app.com/profile/123
    print('Received deep link: $uri');

    // if (uri.pathSegments.contains('profile')) {
    //   final id = uri.pathSegments.last;
    //   // Navigate to profile screen
    //   Navigator.pushNamed(context, '/profile/$id');
    // }
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
    super.dispose();
    _connectivitySubscription.cancel();
    _linkSub?.cancel();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
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
            // initialBinding: SplashBinding(),
            // unknownRoute: GetPage(name: '/splash', page: (){
            //   return SplashView();
            // }),
            initialRoute: Routes.SPLASH,
            locale: Locale(AuthService.to.language != null
                ? AuthService.to.language ?? "en"
                : 'ar'),
            fallbackLocale: TranslationService.fallbackLocale,
            supportedLocales: const [Locale('en'), Locale('ar')],
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
