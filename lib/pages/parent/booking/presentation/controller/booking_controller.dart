import 'package:first_step/consts/themes.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_month_year_picker.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/control_panel/models/child_model.dart';
import '../../../../center/control_panel/models/portfolio_prices_model.dart';
import '../../../home_parent/models/centers_model.dart';
import '../../data/booking_repository.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../model/parent_enrollment_request_model.dart';
import '../../model/parent_enrollment_response_model.dart';

class BookingController extends SuperController<bool> {
  BookingController({required this.bookingRepository});

  final IBookingRepository bookingRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> daysList = [
    AppStrings.selectADay,
    AppStrings.saturday,
    AppStrings.sunday,
    AppStrings.monday,
    AppStrings.tuesday,
    AppStrings.wednesday,
    AppStrings.thursday,
    AppStrings.friday,
  ];

  RxString selectedStartDay = AppStrings.selectADay.obs;

  TextEditingController fromHour = TextEditingController();
  TextEditingController untilHour = TextEditingController();

  RxBool isStartDayError = false.obs;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String getTimeDifference(TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) return "--";

    // Convert TimeOfDay to minutes since midnight
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    int diffMinutes = endMinutes - startMinutes;

    // Handle negative difference (endTime before startTime)
    if (diffMinutes < 0) {
      diffMinutes += 24 * 60; // assume it's the next day
    }

    int hours = diffMinutes ~/ 60;
    int minutes = diffMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return "$hours ${AppStrings.hr} $minutes ${AppStrings.min}";
    } else if (hours > 0) {
      return "$hours ${AppStrings.hr}";
    } else {
      return "$minutes ${AppStrings.hr}";
    }
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  RxList<int> selectedChildrenIds = <int>[].obs;

  bool isChildSelected(int id) {
    return selectedChildrenIds.contains(id);
  }

  void toggleChildSelection(int id) {
    if (selectedChildrenIds.contains(id)) {
      selectedChildrenIds.remove(id);
    } else {
      selectedChildrenIds.add(id);
    }
  }

  RxBool isSelected = false.obs;
  List<ChildModel>? children;

  List<String> getDays() {
    final List<String> days = [];
    for (int i = 0; i < selectedDays.length; i++) {
      days.add(DateFormat("yyyy-MM-dd").format(selectedDays[i]));
    }
    return days;
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // RxBool isChildrenLoading = false.obs;
  getChildren() async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    bookingRepository.getChildren().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          children = null;
          children = value.body;
          update();
        }
        // isChildrenLoading.value = false;
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
      // isChildrenLoading.value = false;
    });
  }

  ParentEnrollmentResponseModel? parentEnrollmentResponseModel;

  RxBool isEnrollLoading = false.obs;

  enroll() async {
    isEnrollLoading.value = true;
    // change(false, status: RxStatus.loading());
    ParentEnrollmentRequestModel? parentEnrollmentRequestModel;
    if(selectedPrice?.enrollmentType == "hour"){
      parentEnrollmentRequestModel = ParentEnrollmentRequestModel(
          children: selectedChildrenIds.value,
          centerBranchId: selectedPrice?.branchId ?? 0,
          // startingDate: day.text.trim(),
          dayString: day.text.trim(),
          startingTime: formatTime(startTime ?? TimeOfDay.now()),
          parentPhone: AuthService.to.userInfo?.user?.phone ?? "+1234567890",
          branchPriceId: selectedPrice?.id ?? 0);
    }else {
      parentEnrollmentRequestModel = ParentEnrollmentRequestModel(
          children: selectedChildrenIds.value,
          centerBranchId: selectedPrice?.branchId ?? 0,
          startingDate: day.text.trim(),
          // dayString: day.text.trim(),
          // startingTime: formatTime(startTime ?? TimeOfDay.now()),
          parentPhone: AuthService.to.userInfo?.user?.phone ?? "+1234567890",
          branchPriceId: selectedPrice?.id ?? 0);
    }
    bookingRepository.enroll(parentEnrollmentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          parentEnrollmentResponseModel = null;
          parentEnrollmentResponseModel = value.body;
          customSnackBar(
              AppStrings.yourReservationRequestHasBeenSentSuccessfully,
              ColorCode.success600);
          update();
          Get.back();
        }
        isEnrollLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isEnrollLoading.value = false;
    });
  }

  TextEditingController day = TextEditingController();
  TextEditingController month = TextEditingController();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  final List<DateTime> selectedDays = [];

  Future<String?> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set a minimum date
      lastDate: DateTime(2100), // Set a maximum date
    );

    if (selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    return null; // If no date is selected
  }

  DateTime? selectedMonth;

  Future<void> showMonthPicker(
      BuildContext context, Function(DateTime) onMonthSelected) async {
    final now = DateTime.now();

    final picked = await showCustomMonthYearPicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month),
        lastDate: DateTime(2030),
        onMonthSelected: (DateTime selected) {
          if (selected != null) {
            onMonthSelected(DateTime(selected.year, selected.month));
          }
        });
  }

  // Branches? selectedBranch;
  PortfolioPrice? selectedPrice;
  List<PortfolioPrice>? pricingList;
  String? centerName;
  String? branchName;

  @override
  void onInit() async {
    var args = Get.arguments;
    branchName = args["branchName"];
    selectedPrice = args["selectedPricing"];
    centerName = args["centerName"];
    pricingList = args["pricingList"];
    await getChildren();
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
