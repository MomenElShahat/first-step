import 'package:first_step/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../home/model/plans_model.dart';
import '../../data/billing_history_repository.dart';
import '../../model/billing_history_model.dart';

class BillingHistoryController extends SuperController<bool> {
  BillingHistoryController({required this.billingHistoryRepository});

  final IBillingHistoryRepository billingHistoryRepository;

  int currentPage = 1;
  int rowsPerPage = 10;

  String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    final formatted = DateFormat('d / M / y').format(dateTime);
    return formatted;
  }

  String formatDateFull(String inputDate) {
    try {
      // Parse the given string date (e.g., "2025-08-20")
      DateTime date = DateTime.parse(inputDate);

      // Use intl DateFormat with locale
      // 'EEEE' = full weekday name, 'd' = day, 'M' = month, 'y' = year
      DateFormat formatter = DateFormat('EEEE d / M / y', AuthService.to.language);

      return formatter.format(date);
    } catch (e) {
      return inputDate; // fallback in case of parsing error
    }
  }

  List<Bill>? billingHistory;

  Future<void> getHistoryPayment() async {
    change(false, status: RxStatus.loading());
    billingHistoryRepository.getHistoryPayment().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          billingHistory = null;
          billingHistory = value.body?.data ?? [];
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
  void onInit() async {
    change(true, status: RxStatus.success());
    await getHistoryPayment();
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
