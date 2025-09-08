import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import '../../data/parent_payment_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ParentPaymentController extends SuperController<bool> {
  ParentPaymentController({required this.parentPaymentRepository});

  final IParentPaymentRepository parentPaymentRepository;

  String? paymentUrl;
  WebViewController? controller;
  RxBool isLoading = true.obs;
  final successUrl = "https://firststep-app/payment/success/enrollment";
  final failureUrl = "https://firststep-app/payment/failure/enrollment";

  getPaymentUrl(String enrollmentId) async {
    change(false, status: RxStatus.loading());
    parentPaymentRepository.getPaymentUrl(enrollmentId).then(
      (value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          paymentUrl = value.body?.paymentUrl;
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (url) {
                  isLoading.value = true;
                },
                onPageFinished: (url) {
                  isLoading.value = false;
                },
                onNavigationRequest: (NavigationRequest request) {
                  final uri = Uri.parse(request.url);

                  // Check if we're on Moyasar redirect domain and payment is done
                  if (uri.host.contains("firststep-app.com") && uri.queryParameters.containsKey('payment')) {
                    final paymentStatus = uri.queryParameters['payment'];

                    // Send to your backend to verify status
                    _verifyPayment(paymentStatus!);

                    return NavigationDecision.prevent;
                  }

                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(paymentUrl ?? ""));
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      Get.back();
      change(true, status: RxStatus.success());
    });
  }

  void _verifyPayment(String paymentStatus) async {
    // Call your backend API
    // final response = await http.get(Uri.parse("https://your-backend.com/verify-payment/$paymentId"));
    //
    // final status = jsonDecode(response.body)['status'];

    if (paymentStatus == 'success') {
      // customSnackBar(AppStrings.paidSuccessfully, ColorCode.success600);
      Get.offAllNamed(Routes.PAYMENT_SUCCESS_SCREEN);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaymentSuccessScreen()));
    } else {
      customSnackBar(AppStrings.thereWasAProblemDuringPaymentPleaseTryAgainLater, ColorCode.danger600);
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaymentFailedScreen()));
    }
  }

  String? enrollmentId;
  @override
  void onInit() async {
    var args = Get.arguments;
    enrollmentId = args;
    await getPaymentUrl(enrollmentId ?? "");
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
