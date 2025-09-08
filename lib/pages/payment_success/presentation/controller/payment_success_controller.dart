import 'package:get/get.dart';
import 'package:first_step/pages/payment_success/data/payment_success_repository.dart';
import 'package:first_step/pages/payment_success/model/model.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';

import '../../../../consts/colors.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../center/home/model/plans_model.dart';

class PaymentSuccessController extends SuperController<bool> {
  PaymentSuccessController({required this.paymentSuccessRepository});

  final IPaymentSuccessRepository paymentSuccessRepository;

  PlansModel? plansModel;

  Future<void> getPlans() async {
    change(false, status: RxStatus.loading());
    paymentSuccessRepository.getPlans().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          plansModel = value.body;
          AuthService.to.subscriptionType = plansModel?.data
              ?.firstWhereOrNull((element) =>
          element.authUserStatus == "active",)
              ?.name;
          int duration = AuthService.to.subscriptionType == "3 months"
              ? 3
              : AuthService.to.subscriptionType == "6 Months"
              ? 6
              : 12;
          AuthService.to.startOfSubscription = DateTime.now().toString();
          DateTime startDate = DateTime.parse(AuthService.to.startOfSubscription ?? "${DateTime.now()}");
          AuthService.to.endOfSubscription =
              DateTime(
                startDate.year,
                startDate.month + duration,
                startDate.day,
                startDate.hour,
                startDate.minute,
                startDate.second,
                startDate.millisecond,
                startDate.microsecond,
              ).toString();
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  @override
  void onInit() async{
    await getPlans();
    AuthService.to.isAgreed = false;
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
