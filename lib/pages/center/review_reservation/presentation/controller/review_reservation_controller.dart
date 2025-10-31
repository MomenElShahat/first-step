import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../booking_details/model/enrollment_details_model.dart';
import '../../../control_panel/models/center_enrollment_model.dart';
import '../../../control_panel/models/portfolio_prices_model.dart';
import '../../data/review_reservation_repository.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReviewReservationController extends SuperController<bool> {
  ReviewReservationController({required this.reviewReservationRepository});

  final IReviewReservationRepository reviewReservationRepository;

  late AutoScrollController pricingScrollController;

  final highlightedIndex = Rxn<int>();

  // Simple example data (replace with your repo/model)
  final childName = ''.obs;
  final parentName = ''.obs;

  // Dropdown selections
  final selectedChildAge = ''.obs;
  final selectedBranch = ''.obs;

  final frequencyOptions = <String>['hour', 'day', 'week', 'month', 'year'];
  final selectedFrequency = 'month'.obs;

  // Selected month/date
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  final List<DateTime> selectedDays = [];
  TextEditingController day = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  TimeOfDay? startTime;

  TextEditingController fromHour = TextEditingController();

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  final selectedOptionIndex = (-1).obs; // no selection initially

  // UI helpers
  final loading = false.obs;

  void selectFrequency(String f) => selectedFrequency.value = f;

  void selectPricingOption(int index) => selectedOptionIndex.value = index;

  List<PortfolioPrice> portfolioPricesModel = <PortfolioPrice>[];

  Future<void> showPortfolioPrices(String branchId) async {
    change(false, status: RxStatus.loading());
    try {
      final value =
          await reviewReservationRepository.showPortfolioPrices(branchId);
      if (value.statusCode == 200 || value.statusCode == 201) {
        portfolioPricesModel = value.body ?? [];
        itemKeys =
            List.generate(portfolioPricesModel.length, (_) => GlobalKey());
        update();
      }
      change(true, status: RxStatus.success());
    } catch (e) {
      customSnackBar(e.toString(), ColorCode.danger600);
    } finally {
      change(true, status: RxStatus.success());
    }
  }

  RxBool isRespondingReject = false.obs;

  RxBool isResponding = false.obs;

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> enrollmentPaidUpdate(
      {required int enrollmentId, required String respond}) async {
    if (respond == "rejected") {
      isRespondingReject.value = true;
    } else {
      isResponding.value = true;
    }
    // change(false, status: RxStatus.loading());
    if (enrollment?.enrollmentType == "hour") {
      reviewReservationRepository
          .updateExistingToPaid(
              enrollmentId: enrollmentId.toString(),
              status: respond,
              startingTime: formatTime(startTime ?? TimeOfDay.now()),
              dayString: day.text)
          .then(
        (value) async {
          if (value.statusCode == 200 || value.statusCode == 201) {
            // change(true, status: RxStatus.success());
            if (respond == "rejected") {
              isRespondingReject.value = false;
              customSnackBar(value.body ?? "", ColorCode.success600);
              Get.back();
            } else {
              isResponding.value = false;
              customSnackBar(value.body ?? "", ColorCode.success600);
              Get.back();
            }
            update();
          }
        },
      ).onError((error, stackTrace) {
        print("Signup error: $error");
        print("StackTrace: $stackTrace");
        customSnackBar(error.toString(), ColorCode.danger600);
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          isRespondingReject.value = false;
        } else {
          isResponding.value = false;
        }
      });
    } else {
      reviewReservationRepository
          .updateExistingToPaid(
        enrollmentId: enrollmentId.toString(),
        status: respond,
        startingDate: day.text,
      )
          .then(
        (value) async {
          if (value.statusCode == 200 || value.statusCode == 201) {
            // change(true, status: RxStatus.success());
            if (respond == "rejected") {
              isRespondingReject.value = false;
              customSnackBar(value.body ?? "", ColorCode.success600);
              Get.back();
            } else {
              isResponding.value = false;
              customSnackBar(value.body ?? "", ColorCode.success600);
              Get.back();
            }
            update();
          }
        },
      ).onError((error, stackTrace) {
        print("Signup error: $error");
        print("StackTrace: $stackTrace");
        customSnackBar(error.toString(), ColorCode.danger600);
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          isRespondingReject.value = false;
        } else {
          isResponding.value = false;
        }
      });
    }
  }

  CenterEnrollment? enrollment;

  List<GlobalKey<State<StatefulWidget>>> itemKeys = [];

  void scrollToSelectedItem(int selectedIndex, List<GlobalKey> itemKeys) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (!pricingScrollController.hasClients) {
      print("⚠️ ScrollController not attached yet");
      return;
    }

    final context = itemKeys[selectedIndex].currentContext;
    if (context == null) {
      print(
          "⚠️ Context for index $selectedIndex still null — delaying retry...");
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollToSelectedItem(selectedIndex, itemKeys);
      });
      return;
    }

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      print("⚠️ RenderBox not ready — retrying...");
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollToSelectedItem(selectedIndex, itemKeys);
      });
      return;
    }

    final itemPosition = box.localToGlobal(Offset.zero);
    final itemWidth = box.size.width;
    final screenWidth = MediaQuery.of(Get.context!).size.width;

    final targetOffset = pricingScrollController.offset +
        itemPosition.dx -
        (screenWidth / 2) +
        (itemWidth / 2);

    print("✅ Scrolling to index: $selectedIndex | Offset: $targetOffset");

    pricingScrollController.animateTo(
      targetOffset.clamp(
        pricingScrollController.position.minScrollExtent,
        pricingScrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  Future<void> scrollToIndex(int index) async {
    try {
      await pricingScrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.middle,
        duration: const Duration(milliseconds: 500),
      );
      pricingScrollController.highlight(index);

      // 🔥 Trigger highlight animation
      highlightedIndex.value = index;

      // remove the highlight after 1.2 seconds
      Future.delayed(const Duration(milliseconds: 200), () {
        if (highlightedIndex.value == index) {
          highlightedIndex.value = null;
        }
      });
    } catch (e) {
      print("⚠️ Scroll failed: $e");
    }
  }

  @override
  void onInit() async {
    pricingScrollController = AutoScrollController(
      axis: Axis.horizontal,
      suggestedRowHeight: 100, // optional
    );
    var args = Get.arguments;
    enrollment = args;

    await showPortfolioPrices((enrollment?.branchId ?? 0).toString()).then((_) {
      final price = portfolioPricesModel.firstWhere(
        (element) => element.id == enrollment?.branchPriceId,
        orElse: () => portfolioPricesModel.first,
      );
      selectedChildAge.value = "${price.startAge} - ${price.endAge}";
    });

    for (int i = 0; i < (enrollment?.children?.length ?? 0); i++) {
      if (i == (enrollment?.children?.length ?? 0) - 1) {
        childName.value += enrollment?.children?[i].childName ?? "";
      } else {
        childName.value += "${enrollment?.children?[i].childName ?? ""} - ";
      }
    }

    parentName.value = enrollment?.parentName ?? "";
    selectedBranch.value = enrollment?.branchName ?? "";
    selectedFrequency.value = enrollment?.enrollmentType ?? "";

    // // ✅ Wait for layout to be fully built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Add an extra delay for safety
    //   Future.delayed(const Duration(milliseconds: 300), () {
    //     final selectedIndex = portfolioPricesModel.indexWhere(
    //       (item) => item.id == enrollment?.branchPriceId,
    //     );
    //     print("➡️ Selected index to scroll: $selectedIndex");
    //
    //     if (selectedIndex != -1) {
    //       scrollToSelectedItem(selectedIndex, itemKeys);
    //     } else {
    //       print("⚠️ No matching item found for branchPriceId");
    //     }
    //   });
    // });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(milliseconds: 600), () async {
      final selectedIndex = portfolioPricesModel.indexWhere(
        (item) => item.id == enrollment?.branchPriceId,
      );
      if (selectedIndex != -1) {
        print("🎯 Scrolling to index: $selectedIndex");
        await scrollToIndex(selectedIndex);
      }
    });
  }

  // SuperController lifecycle must be implemented (can be left empty)
  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
