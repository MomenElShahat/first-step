import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../center/control_panel/models/branch_model.dart';
import '../../../center/control_panel/models/center_enrollment_model.dart';
import '../../../center/control_panel/models/child_model.dart';
import '../../data/booking_details_repository.dart';
import '../../model/enrollment_details_model.dart';

class BookingDetailsController extends SuperController<bool> {
  BookingDetailsController({required this.bookingDetailsRepository});

  final IBookingDetailsRepository bookingDetailsRepository;

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
  // List<Children>? children;

  // List<String> getDays() {
  //   final List<String> days = [];
  //   for (int i = 0; i < selectedDays.length; i++) {
  //     days.add(DateFormat("yyyy-MM-dd").format(selectedDays[i]));
  //   }
  //   return days;
  // }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case 'accepted':
        return ColorCode.success600;
      case 'pending':
        return ColorCode.warning600;
      case 'cancelled':
        return ColorCode.danger600;
      default:
        return ColorCode.neutral400;
    }
  }

  String getStatusText(String? status) {
    switch (status) {
      case 'accepted':
        return 'مقبول';
      case 'pending':
        return 'في انتظار الدفع';
      case 'cancelled':
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }


  int getDaysDifference(DateTime date1, DateTime date2) {
    // Normalize both dates to remove time part
    final normalizedDate1 = DateTime(date1.year, date1.month, date1.day);
    final normalizedDate2 = DateTime(date2.year, date2.month, date2.day);

    final difference = normalizedDate1.difference(normalizedDate2).inDays.abs();

    return difference == 0 ? 1 : difference;
  }

  EnrollmentDetailsModel? enrollmentDetailsModel;
  EnrollmentData? enrollmentData;
  EnrollmentData? selectedEnrollmentData;

  String? enrollmentType;
  Color? statusColor;

  String? statusText;
  getEnrollmentDetailsParentData(String enrollmentId) async {
    change(false, status: RxStatus.loading());
    bookingDetailsRepository.getEnrollmentDetailsParent(enrollmentId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentDetailsModel = null;
          enrollmentDetailsModel = value.body;
          selectedEnrollmentData = enrollmentDetailsModel?.data;
          enrollmentType = enrollmentDetailsModel?.data?.enrollmentType;
          for (int i = 0; i < (enrollmentDetailsModel?.data?.children?.length ?? 0); i++) {
            selectedChildrenIds.value.add(enrollmentDetailsModel?.data?.children?[i].id ?? 0);
          }
          print("selectedChildrenIds $selectedChildrenIds");
          day.text = enrollmentDetailsModel?.data?.dayString ?? enrollmentDetailsModel?.data?.startingDate ?? "";
          // month.text = enrollmentDetailsModel?.data?.enrollmentDate ?? "";
          // selectedDay = DateTime.parse(
          //     enrollmentDetailsModel?.data?.startingDate ?? "${DateTime.now()}");
          // selectedMonth = DateTime.parse(
          //     enrollmentDetailsModel?.data?.enrollmentDate ?? "${DateTime.now()}");
          // for(int i =0;i< (enrollmentDetailsModel?.data?.day?.length ?? 0);i++){
          //   selectedDays.add(DateTime.parse(enrollmentData?.day?[i] ?? "${DateTime.now()}"));
          // }
          fromHour.text = enrollmentDetailsModel?.data?.startingTime ?? "";
          untilHour.text = enrollmentDetailsModel?.data?.endingTime ?? "";
          statusColor = getStatusColor(enrollmentDetailsModel?.data?.status);
          statusText = getStatusText(enrollmentDetailsModel?.data?.status);
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

  getEnrollmentDetailsCenterData(String enrollmentId) async {
    change(false, status: RxStatus.loading());
    bookingDetailsRepository.getEnrollmentDetailsCenter(enrollmentId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentData = null;
          enrollmentData = value.body;
          selectedEnrollmentData = enrollmentData;
          enrollmentType = enrollmentData?.enrollmentType;
          print("enrollmentType $enrollmentType");
          for (int i = 0; i < (enrollmentData?.children?.length ?? 0); i++) {
            selectedChildrenIds.value.add(enrollmentData?.children?[i].id ?? 0);
          }
          print("selectedChildrenIds $selectedChildrenIds");
          day.text = enrollmentData?.dayString ?? enrollmentData?.startingDate ?? "";
          dayEnd.text = enrollmentData?.endingDate ?? "";
          // month.text = enrollmentData?.enrollmentDate ?? "";
          // selectedDay = DateTime.parse(
          //     enrollmentData?.startingDate ?? "${DateTime.now()}");
          // selectedMonth = DateTime.parse(
          //     enrollmentData?.enrollmentDate ?? "${DateTime.now()}");
          // for(int i =0;i< (enrollmentData?.day?.length ?? 0);i++){
          //   selectedDays.add(DateTime.parse(enrollmentData?.day?[i] ?? "${DateTime.now()}"));
          // }
          fromHour.text = enrollmentData?.startingTime ?? "";
          untilHour.text = enrollmentData?.endingTime ?? "";
          statusColor = getStatusColor(enrollmentData?.status);
          statusText = getStatusText(enrollmentData?.status);
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


  TextEditingController day = TextEditingController();
  TextEditingController dayEnd = TextEditingController();
  // TextEditingController month = TextEditingController();

  DateTime focusedDay = DateTime.now();
  // DateTime? selectedDay;
  // List<DateTime> selectedDays = [];

  // Future<String?> pickDate(BuildContext context) async {
  //   DateTime? selectedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000), // Set a minimum date
  //     lastDate: DateTime(2100), // Set a maximum date
  //   );
  //
  //   if (selectedDate != null) {
  //     return DateFormat('yyyy-MM-dd').format(selectedDate);
  //   }
  //   return null; // If no date is selected
  // }
  //
  // DateTime? selectedMonth;
  //
  // Future<void> showMonthPicker(
  //     BuildContext context, Function(DateTime) onMonthSelected) async {
  //   final now = DateTime.now();
  //
  //   final picked = await showCustomMonthYearPicker(
  //       context: context,
  //       initialDate: now,
  //       firstDate: DateTime(DateTime.now().year, DateTime.now().month),
  //       lastDate: DateTime(2030),
  //       onMonthSelected: (DateTime selected) {
  //         if (selected != null) {
  //           onMonthSelected(DateTime(selected.year, selected.month));
  //         }
  //       });
  // }

  String? enrollmentId;
  BranchModel? selectedBranch;

  @override
  void onInit() async {
    var args = Get.arguments;
    enrollmentId = args["enrollmentId"];
    selectedBranch = args["selectedBranch"];
    print("$selectedChildrenIds");
    if (AuthService.to.userInfo?.user?.role == "parent") {
      await getEnrollmentDetailsParentData(enrollmentId ?? "");
    } else {
      await getEnrollmentDetailsCenterData(enrollmentId ?? "");
    }
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
