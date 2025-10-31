import 'dart:convert';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/pages/center/control_panel/models/portfolio_response_model.dart';
import 'package:first_step/pages/center/control_panel/models/statistics_model.dart';
import 'package:first_step/pages/center/control_panel/models/team_member_model.dart';
import 'package:first_step/pages/center/control_panel/models/center_info_model.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/chat.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/childrens_files.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/my_branches.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/reservations.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/work_team.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../consts/colors.dart';
import '../../../../../services/pusher_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../booking_details/model/enrollment_details_model.dart';
import '../../../../bottom_navigation/controller/main_controller.dart';
import '../../../../parent/control_panel_parent/models/daily_reports_model.dart';
import '../../../edit_member/models/branch_team_member_model.dart';
import '../../models/branch_model.dart';
import '../../models/branch_team_model.dart';
import '../../models/center_enrollment_model.dart';
import '../../models/center_notify_parents_request_model.dart';
import '../../models/center_notify_parents_response_model.dart';
import '../../models/chats_model.dart';
import '../../models/parent_model.dart';
import '../../models/portfolio_prices_model.dart';
import '../../models/show_portfolio_response_model.dart';
import '../widgets/center_info.dart';
import '../widgets/daily_report_center.dart';
import '../widgets/home.dart';
import '../widgets/notifications.dart';
import '../widgets/pricing_row.dart';
import '../widgets/multi_select_branches_dropdown.dart';
import '../../data/control_panel_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:collection/collection.dart';

import '../widgets/update_portfolio_success_dialog.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ControlPanelController extends SuperController<dynamic> {
  ControlPanelController({required this.controlPanelRepository});

  final IControlPanelRepository controlPanelRepository;

  final List<String> statuses = [
    "all",
    "accepted",
    "pending",
    "rejected",
    "paid",
    "existing",
    "expired",
  ];

  RxList<CenterEnrollment> filteredEnrollments = <CenterEnrollment>[].obs;

  String getStatusText(String? status) {
    switch (status) {
      case 'accepted':
        return AppStrings.waitingForPayment;
      case 'pending':
        return AppStrings.waitingForApproval;
      case 'cancelled':
        return AppStrings.cancelled;
      case 'rejected':
        return AppStrings.rejected;
      case 'paid':
        return AppStrings.paid;
      case 'existing':
        return AppStrings.throughNursery;
      case 'expired':
        return AppStrings.expired;
      default:
        return AppStrings.unknown;
    }
  }

  RxString selectedStatus = "all".obs;

  TextEditingController arabic = TextEditingController();
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  final List<DateTime> selectedDays = [];
  TextEditingController day = TextEditingController();
  TextEditingController fromHour = TextEditingController();
  TimeOfDay? startTime;

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  // --- Form & pagination ---
  GlobalKey<FormState> notificationFormKey = GlobalKey<FormState>();
  int currentPageNotification = 1;
  int rowsPerPageNotification = 10;

  // --- Per-row UI state ---
  List<bool> checkedStatesNotification = [];
  Map<int, ChildModel?> selectedChildrenPerParentNotification = {}; // parentIndex -> selected child (for UI only)
  final ChildModel allChildrenModelNotification = ChildModel(id: -1, childName: 'كل الأطفال');

  // --- NEW: parent ids selected (for API) ---
  List<int> selectedParentIdsNotification = [];

  CenterNotifyParentsResponseModel? centerNotifyParentsResponseModel;

  RxBool isNotifying = false.obs;

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> notifyParents() async {
    CenterNotifyParentsRequestModel body = CenterNotifyParentsRequestModel(
        parentIds: getSelectedParentIdsForApi(), date: day.text, title: arabic.text, time: formatTime(startTime ?? TimeOfDay.now()));
    // change(false, status: RxStatus.loading());
    isNotifying.value = true;
    controlPanelRepository.notifyParents(body: body).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centerNotifyParentsResponseModel = null;
          centerNotifyParentsResponseModel = value.body;
          customSnackBar(centerNotifyParentsResponseModel?.message ?? "", ColorCode.success600);
          day.clear();
          arabic.clear();
          fromHour.clear();
          startTime = null;
          update();
        }
        // change(true, status: RxStatus.success());
        isNotifying.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.") &&
          !error.toString().contains("_Map<String, dynamic>' is not a subtype of type 'List<dynamic>")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
      isNotifying.value = false;
    });
  }

  // ----------------- API helper -----------------
  /// Return the selected parent IDs (unique)
  List<int> getSelectedParentIdsForApi() {
    // make sure it's a unique list (it should already be)
    return selectedParentIdsNotification.toSet().toList();
  }

  // ----------------- checkbox handlers -----------------
  void onParentChecked(int index, bool? isChecked) {
    // defensive checks
    if (parents == null || index < 0 || index >= (parents?.length ?? 0)) {
      return;
    }

    checkedStatesNotification[index] = isChecked ?? false;

    final parent = parents![index];
    final parentId = parent.id;

    if (isChecked == true) {
      // add parent id if not already present
      if (parentId != null && !selectedParentIdsNotification.contains(parentId)) {
        selectedParentIdsNotification.add(parentId);
      }
    } else {
      // remove parent id
      if (parentId != null) {
        selectedParentIdsNotification.remove(parentId);
      }
    }

    update();
  }

  // When user toggles select-all for visible page range
  bool isSelectAllChecked = false;

  void toggleSelectAll(bool? checked, int startIndex, int endIndex) {
    // startIndex inclusive, endIndex exclusive (safeEndIndex computed by caller)
    isSelectAllChecked = checked ?? false;

    for (int i = startIndex; i < endIndex; i++) {
      // guard index validity
      if (i < 0 || parents == null || i >= parents!.length) continue;

      checkedStatesNotification[i] = isSelectAllChecked;

      final parent = parents![i];
      final parentId = parent.id;

      if (isSelectAllChecked) {
        if (parentId != null && !selectedParentIdsNotification.contains(parentId)) {
          selectedParentIdsNotification.add(parentId);
        }
      } else {
        if (parentId != null) {
          selectedParentIdsNotification.remove(parentId);
        }
      }
    }

    update();
  }

  // Selecting a child in the dropdown is for UI / informational use only now.
  // It does NOT change which parent IDs are selected for API.
  void onChildSelected(int parentIndex, ChildModel? child) {
    // Update stored selection for the row (UI)
    selectedChildrenPerParentNotification[parentIndex] = child ?? allChildrenModelNotification;

    // NOTE: previously child selection added child ids to API payload.
    // Now we only send parent ids. So we don't modify selectedParentIdsNotification here.
    // If you want to change behavior (e.g., select parent automatically when a child is chosen), do it here.

    update();
  }

  // ----------------- initialization helpers -----------------
  void initNotificationData(List<ParentModel> parentsList) {
    parents = parentsList;

    // Initialize checkbox states
    checkedStatesNotification = List.generate(parents!.length, (_) => false);

    // Initialize selected children per parent (UI default to "all children" item)
    selectedChildrenPerParentNotification.clear();
    for (int i = 0; i < parents!.length; i++) {
      selectedChildrenPerParentNotification[i] = allChildrenModelNotification;
    }

    // Clear selected parent ids
    selectedParentIdsNotification.clear();

    // reset pagination
    currentPageNotification = 1;

    update();
  }

  void ensureNotificationListsInitialized(int count) {
    if (checkedStatesNotification.length != count) {
      checkedStatesNotification = List.generate(count, (_) => false);
    }

    if (selectedChildrenPerParentNotification.length != count) {
      selectedChildrenPerParentNotification.clear();
      for (int i = 0; i < count; i++) {
        selectedChildrenPerParentNotification[i] = allChildrenModelNotification;
      }
    }

    // If selectedParentIdsNotification contains ids that are no longer valid (parents changed),
    // we keep them until the caller calls initNotificationData. Optionally you can filter them:
    if (parents != null) {
      final validIds = parents!.map((p) => p.id).whereType<int>().toSet();
      selectedParentIdsNotification = selectedParentIdsNotification.where((id) => validIds.contains(id)).toList();
    }
  }

  final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
  RxString selectedSection = "parents".obs;
  Rx<RangeValues> rangeValues = const RangeValues(1, 4).obs;
  BranchModel? selectedBranch;
  BranchModel? selectedBranchPricing;
  String selectedBranchType = AppStrings.selectType;

  // List<ProgramModel> programs = [ProgramModel()]; // at least one program

  final List<Map<String, String>> programTypes = [
    {"value": "day", "label": AppStrings.daily},
    {"value": "week", "label": AppStrings.weekly},
    {"value": "month", "label": AppStrings.monthly},
    {"value": "hour", "label": AppStrings.flexibleHourly},
    {"value": "year", "label": AppStrings.yearly},
  ];

  RxBool isBranchError = false.obs;
  RxBool isBranchPricingError = false.obs;
  RxInt currentIndex = 0.obs;

  TextEditingController centerNameController = TextEditingController();
  TextEditingController centerSloganController = TextEditingController();
  TextEditingController centerdescController = TextEditingController();
  TextEditingController centerimageController = TextEditingController();

  TextEditingController ourPhilosophyController = TextEditingController();
  TextEditingController ourMethodologyController = TextEditingController();
  TextEditingController ourGoalController = TextEditingController();

  TextEditingController nurserySpaceController = TextEditingController();
  TextEditingController numberOfClassesController = TextEditingController();
  TextEditingController numberOfTeamMembersController = TextEditingController();

  TextEditingController activitiesController = TextEditingController();

  File? centerBackgroundImage;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null; // User canceled the picker
  }

  var expandedProgramIndex = (-1).obs;
  RxMap<int, bool> expandedPricingIndex = <int, bool>{}.obs;

  resetMainSection() {
    centerNameController.clear();
    centerSloganController.clear();
    centerdescController.clear();
    centerimageController.clear();
    centerBackgroundImage = null;
  }

  resetGoalsSection() {
    ourPhilosophyController.clear();
    ourMethodologyController.clear();
    ourGoalController.clear();
  }

  resetCenterInfoSection() {
    nurserySpaceController.clear();
    numberOfClassesController.clear();
    numberOfTeamMembersController.clear();
  }

  resetBranchesSection() {
    for (final controller in branchControllers) {
      controller.clear();
    }
  }

  resetAdsSection() {
    adImages.value = [null];
    // update();
    // adImages.clear();
  }

  resetActivitiesSection() {
    activitiesController.clear();
    activities.value = [null];
    // update();
    // adImages.clear();
  }

  resetOurTeamsSection() {
    members.value = [TeamMemberModel()];
    // update();
    // adImages.clear();
  }

  resetOurServicesSection() {
    services.value = [TeamMemberModel()];
    // update();
    // adImages.clear();
  }

  RxList<TeamMemberModel> members = [TeamMemberModel()].obs;
  RxList<TeamMemberModel> services = [TeamMemberModel()].obs;
  RxList<TextEditingController> imageControllers = [TextEditingController()].obs;
  RxList<TextEditingController> professionControllers = [TextEditingController()].obs;
  RxList<TextEditingController> nameControllers = [TextEditingController()].obs;
  RxList<TextEditingController> imageServiceControllers = [TextEditingController()].obs;
  RxList<TextEditingController> descServiceControllers = [TextEditingController()].obs;
  RxList<TextEditingController> nameServiceControllers = [TextEditingController()].obs;

  RxList<TextEditingController> branchControllers = [TextEditingController()].obs;

  RxList<dynamic> adImages = <dynamic>[null].obs; // can be File or String (URL)

  RxList<dynamic> activities = <dynamic>[null].obs;

  Future<void> pickAdsImage(int index) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      File newFile = File(picked.path);
      // newFile = await compressImage(newFile);
      if (adImages[index] is String) {
        // Keep API image, add file to the end
        adImages[index] = newFile;
      } else {
        // Replace only if null or already a file
        adImages[index] = newFile;
      }

      // // Always make sure there is one empty slot at the end
      // if (activities.isEmpty || activities.last != null) {
      //   activities.add(null);
      // }
    }

    update();
  }

  Future<void> pickActivitiesImage(int index) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      File newFile = File(picked.path);
      // newFile = await compressImage(newFile);
      if (activities[index] is String) {
        // Keep API image, add file to the end
        activities[index] = newFile;
      } else {
        // Replace only if null or already a file
        activities[index] = newFile;
      }

      // // Always make sure there is one empty slot at the end
      // if (activities.isEmpty || activities.last != null) {
      //   activities.add(null);
      // }
    }

    update();
  }

  void addBranch() {
    branchControllers.add(TextEditingController());
    // update();
  }

  // Remove branch
  void removeBranch(int index) {
    if (branchControllers.length > 1) {
      branchControllers.removeAt(index);
    }
    // update();
  }

  // Add new ad image slot
  void addAdImage() {
    adImages.add(null);
    // update();
  }

  // Remove ad image
  void removeAdImage(int index) {
    if (adImages.length > 1) {
      adImages.removeAt(index);
    }
    // update();
  }

  void addActivity() {
    activities.add(null);
    // update();
  }

  // Remove ad image
  void removeActivity(int index) {
    if (activities.length > 1) {
      activities.removeAt(index);
    }
    // update();
  }

  @override
  void dispose() {
    for (final controller in branchControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<File> urlToFile(String imageUrl) async {
    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    // Download image
    final response = await http.get(Uri.parse(imageUrl));

    // Save to file
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null; // User canceled the picker
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    final formatted = DateFormat('d / M / y').format(dateTime);
    return formatted;
  }

  RxInt expandedIndex = (-1).obs;
  List<Widget Function()> pageBuilders = AuthService.to.userInfo?.user?.role == "center"
      ? [
          () => DashboardHome(key: UniqueKey()),
          () => MyBranches(key: UniqueKey()),
          () => ChildrensFiles(key: UniqueKey()),
          () => Reservations(key: UniqueKey()),
          () => CenterInfo(key: UniqueKey()),
          () => DailyReportCenter(key: UniqueKey()),
          // () => LocationEdit(key: UniqueKey()),
          // () => BlogAsk(key: UniqueKey()),
          () => Chat(key: UniqueKey()),
          () => Notifications(key: UniqueKey()),
          () => WorkTeam(key: UniqueKey()),
        ]
      : [
          // () => DashboardHome(key: UniqueKey()),
          // () => MyBranches(key: UniqueKey()),
          () => ChildrensFiles(key: UniqueKey()),
          () => Reservations(key: UniqueKey()),
          // () => CenterInfo(key: UniqueKey()),
          () => DailyReportCenter(key: UniqueKey()),
          // () => LocationEdit(key: UniqueKey()),
          // () => BlogAsk(key: UniqueKey()),
          () => Chat(key: UniqueKey()),
          // () => Notifications(key: UniqueKey()),
          () => WorkTeam(key: UniqueKey()),
        ];

  List<BranchModel>? branches;
  List<ParentModel>? parents;
  List<Contacts>? chats;
  List<ChildModel>? children;
  BranchModel? branch;
  StatisticsModel? statisticsModel;
  BranchTeamMemberModel? branchTeamMemberModel;
  BranchTeamModel? branchTeamModel;
  List<CenterEnrollment>? enrollments;

  String getFirstTwoCapitalLetters(String input) {
    // Remove leading/trailing whitespace and ensure it's at least 2 characters
    if (input.trim().length < 2) return '';

    // Extract the first two letters
    String firstTwo = input.trim().substring(0, 2);

    // Check if both characters are English letters
    bool isEnglish = RegExp(r'^[a-zA-Z]{2}$').hasMatch(firstTwo);

    return isEnglish ? firstTwo.toUpperCase() : '';
  }

  RxBool isBranchesLoading = false.obs;

  getBranches() async {
    change(false, status: RxStatus.loading());
    controlPanelRepository.getBranches().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branches = null;
          branches = value.body;
          selectedBranch = branches?.first ?? BranchModel();
          selectedBranchPricing = branches?.first ?? BranchModel();
          await getBranchDetails(selectedBranch?.id.toString() ?? "");
          await getBranchTeam(selectedBranch?.id.toString() ?? "");
          await getParents();
          // await getChildren();
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.") &&
          !error.toString().contains("_Map<String, dynamic>' is not a subtype of type 'List<dynamic>")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      change(true, status: RxStatus.success());
    });
  }

  getBranchesAfterAdding() async {
    change(false, status: RxStatus.loading());
    controlPanelRepository.getBranches().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branches = null;
          branches = value.body;
          // selectedBranch = branches?.first ?? BranchModel();
          // selectedBranchPricing = branches?.first ?? BranchModel();
          // await getBranchDetails(selectedBranch.id.toString());
          // await getBranchTeam(selectedBranch.id.toString());
          // await getParents();
          // await getChildren();
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

  double? percentage;

  double calculatePortfolioProgress(ShowPortfolioResponseModel model, List<PortfolioPrice> portfolioPricesModel) {
    if (model.portofilo == null) return 0.0;
    final data = model.portofilo!;

    // Sections to check
    int totalSections = 9; // total sections you listed
    int filledSections = 0;

    // 1. HeroSection
    if (data.heroSection != null &&
        (data.heroSection!.titleOfHero?.isNotEmpty == true ||
            data.heroSection!.subtitleOfHero?.isNotEmpty == true ||
            data.heroSection!.description?.isNotEmpty == true ||
            data.heroSection!.backgroundImage?.isNotEmpty == true)) {
      filledSections++;
    }

    // 2. Branches
    if (data.branches != null && data.branches!.isNotEmpty) {
      filledSections++;
    }

    // 3. PhilosophyMethodologyGoal
    if (data.philosophyMethodologyGoal != null) {
      final pmg = data.philosophyMethodologyGoal!;
      if ((pmg.philosophy?.title?.isNotEmpty == true || pmg.philosophy?.content?.isNotEmpty == true) ||
          (pmg.methodology?.title?.isNotEmpty == true || pmg.methodology?.content?.isNotEmpty == true) ||
          (pmg.goals?.title?.isNotEmpty == true || pmg.goals?.content?.isNotEmpty == true)) {
        filledSections++;
      }
    }

    // 4. Services
    if (data.services != null && data.services!.isNotEmpty) {
      filledSections++;
    }

    // 5. NurseryState
    if (data.nurseryState != null &&
        (data.nurseryState!.area?.isNotEmpty == true ||
            data.nurseryState!.classRooms?.isNotEmpty == true ||
            data.nurseryState!.teamMembers?.isNotEmpty == true)) {
      filledSections++;
    }

    // 6. ImagesActivities
    if (data.imagesActivities != null && data.imagesActivities!.isNotEmpty) {
      filledSections++;
    }

    // 7. AdsImages
    if (data.adsImages != null && data.adsImages!.isNotEmpty) {
      filledSections++;
    }

    // 8. Teams
    if (data.teams != null && data.teams!.isNotEmpty) {
      filledSections++;
    }

    // 9. ContactInfo
    // if (data.contactInfo != null &&
    //     (data.contactInfo!.address?.isNotEmpty == true ||
    //         data.contactInfo!.workingHours?.isNotEmpty == true ||
    //         data.contactInfo!.phoneNumber?.isNotEmpty == true ||
    //         data.contactInfo!.emailAddress?.isNotEmpty == true ||
    //         data.contactInfo!.facebook?.isNotEmpty == true ||
    //         data.contactInfo!.instagram?.isNotEmpty == true ||
    //         data.contactInfo!.whatsapp?.isNotEmpty == true)) {
    //   filledSections++;
    // }

    // 10. Pricing
    if (portfolioPricesModel.isNotEmpty) {
      filledSections++;
    }

    // Percentage
    return (filledSections / totalSections) * 100;
  }

  ShowPortfolioResponseModel? showPortfolioResponseModel;

  showPortfolio() async {
    // change(false, status: RxStatus.loading());
    controlPanelRepository.showPortfolio().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          showPortfolioResponseModel = null;
          showPortfolioResponseModel = value.body;
          if (selectedBranch != null) {
            await showPortfolioPrices(selectedBranch?.id.toString() ?? "");
          }
          percentage = calculatePortfolioProgress(showPortfolioResponseModel ?? ShowPortfolioResponseModel(), portfolioPricesModel);
          centerNameController.text = showPortfolioResponseModel?.portofilo?.heroSection?.titleOfHero ?? "";
          centerSloganController.text = showPortfolioResponseModel?.portofilo?.heroSection?.subtitleOfHero ?? "";
          centerdescController.text = showPortfolioResponseModel?.portofilo?.heroSection?.description ?? "";
          centerimageController.text = showPortfolioResponseModel?.portofilo?.heroSection?.backgroundImage?.split("/").last ?? "";

          ourPhilosophyController.text = showPortfolioResponseModel?.portofilo?.philosophyMethodologyGoal?.philosophy?.content ?? "";
          ourMethodologyController.text = showPortfolioResponseModel?.portofilo?.philosophyMethodologyGoal?.methodology?.content ?? "";
          ourGoalController.text = showPortfolioResponseModel?.portofilo?.philosophyMethodologyGoal?.goals?.content ?? "";

          nurserySpaceController.text = showPortfolioResponseModel?.portofilo?.nurseryState?.area ?? "";
          numberOfClassesController.text = showPortfolioResponseModel?.portofilo?.nurseryState?.classRooms ?? "";
          numberOfTeamMembersController.text = showPortfolioResponseModel?.portofilo?.nurseryState?.teamMembers ?? "";

          activitiesController.text = showPortfolioResponseModel?.portofilo?.activitySectionTitle ?? "";
          branchControllers.clear();

          final branches = showPortfolioResponseModel?.portofilo?.branches ?? [];

          for (var branch in branches) {
            branchControllers.add(TextEditingController(text: branch.branchName ?? ""));
          }

          activities.clear();

          final apiImages = showPortfolioResponseModel?.portofilo?.imagesActivities ?? [];

// Keep API images as strings in the list
          for (var img in apiImages) {
            activities.add(img); // String
          }

// Always add at least one empty slot for adding a new image
          if (activities.isEmpty) activities.add(null);

          adImages.clear();
          final apiAds = showPortfolioResponseModel?.portofilo?.adsImages ?? [];

          for (var url in apiAds) {
            // final file = await downloadAndCompressImage(url);
            adImages.add(url);
          }

// Add empty slot if needed
          if (adImages.isEmpty) {
            adImages.add(null);
          }

          members.clear();
          final teamMembers = showPortfolioResponseModel?.portofilo?.teams ?? [];

          for (var member in teamMembers) {
            members.add(TeamMemberModel(name: member.name ?? "", profession: member.mission ?? "", imageUrl: member.image ?? ""));
          }

          services.clear();
          final service = showPortfolioResponseModel?.portofilo?.services ?? [];

          for (var service in service) {
            services.add(TeamMemberModel(name: service.title ?? "", profession: service.description ?? "", imageUrl: service.imageService ?? ""));
          }
          // After you've populated controllers/lists from API:
          centerInfoModel = CenterInfoModel(
            centerName: centerNameController.text,
            centerSlogan: centerSloganController.text,
            description: centerdescController.text,
            backgroundImage: null,
            // server image is URL; keep null for file baseline
            branches: branchControllers.map((c) => c.text).where((t) => t.isNotEmpty).toList(),
            adImages: List<dynamic>.from(adImages),
            // keep URL strings
            ourPhilosophy: ourPhilosophyController.text,
            ourMethodology: ourMethodologyController.text,
            ourGoal: ourGoalController.text,
            nurserySpace: nurserySpaceController.text,
            numberOfClasses: numberOfClassesController.text,
            numberOfTeamMembers: numberOfTeamMembersController.text,
            activitiesDescription: activitiesController.text,
            activityImages: List<dynamic>.from(activities),
            // keep URL strings
            teamMembers: members
                .map((m) => TeamMemberModel(
                      name: m.name,
                      profession: m.profession,
                      imageUrl: m.imageUrl, // keep String URL
                    ))
                .toList(),
            services: services
                .map((s) => TeamMemberModel(
                      name: s.name,
                      profession: s.profession,
                      imageUrl: s.imageUrl, // keep String URL
                    ))
                .toList(),
          );

          update();
        }
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
    });
  }

  final _deepEq = const DeepCollectionEquality.unordered();
  List<PortfolioPrice> _pricesOriginal = <PortfolioPrice>[];
  final RxList<PortfolioPrice> portfolioPricesModel = <PortfolioPrice>[].obs;

  bool get pricesChanged {
    final a = _pricesOriginal.map((e) => e.canonical()).toList();
    final b = portfolioPricesModel.toList().map((e) => e.canonical()).toList();
    return !_deepEq.equals(a, b);
  }

  RxBool isShowingPrices = false.obs;
  RxBool isSavingPrices = false.obs;

  // per-item deleting state map
  final RxMap<int, bool> isDeletingPriceById = <int, bool>{}.obs;

  Future<void> showPortfolioPrices(String branchId) async {
    isShowingPrices.value = true;
    try {
      final value = await controlPanelRepository.showPortfolioPrices(branchId);
      if (value.statusCode == 200 || value.statusCode == 201) {
        final fetched = (value.body ?? <PortfolioPrice>[]).map((e) => e.copy()).toList();

        // 2) Snapshot originals
        _pricesOriginal = fetched.map((e) => e.copy()).toList();

        // 3) Use assignAll to notify Obx
        portfolioPricesModel.assignAll(fetched);

        // (Keep your percentage calc)
        percentage = calculatePortfolioProgress(
          showPortfolioResponseModel ?? ShowPortfolioResponseModel(),
          portfolioPricesModel, // RxList acts as List
        );
      } else {
        customSnackBar('Failed to load prices', ColorCode.danger600);
      }
    } catch (e) {
      customSnackBar(e.toString(), ColorCode.danger600);
    } finally {
      isShowingPrices.value = false;
    }
  }

  void addProgram() => portfolioPricesModel.add(PortfolioPrice());

  void removeProgramAt(int index) => portfolioPricesModel.removeAt(index);

  void togglePricingExpansion(int index) {
    // Check if current item is already expanded
    bool isCurrentlyExpanded = expandedPricingIndex[index] ?? false;

    // Close all expanded items
    expandedPricingIndex.clear();

    // If the clicked item was not expanded, expand it
    if (!isCurrentlyExpanded) {
      expandedPricingIndex[index] = true;
    }
    // If it was expanded, it stays collapsed (due to clear above)
  }

  bool isPricingExpanded(int index) {
    return expandedPricingIndex[index] ?? false;
  }

  void showEditPricingDialog(int index) {
    // This will be implemented as a dialog for editing pricing programs
    Get.dialog(
      Dialog(
        backgroundColor: ColorCode.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                AppStrings.editProgram,
                textStyle: TextStyles.title24Medium.copyWith(color: ColorCode.primary600),
              ),
              Gaps.vGap16,
              ProgramPriceRow(
                ctrl: this,
                program: portfolioPricesModel[index],
                index: index,
                enable: true,
              ),
              Gaps.vGap16,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: ColorCode.neutral400),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.5),
                        child: CustomText(
                          AppStrings.cancel,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap16,
                  Obx(() {
                    return Visibility(
                      visible: !isSavingPrices.value,
                      replacement: const SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // For edit, we need to ensure the program has an ID for update
                            final program = portfolioPricesModel[index];
                            if (program.id == null) {
                              customSnackBar('Cannot edit program without ID', ColorCode.danger600);
                              return;
                            }
                            await savePricingChanges();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                transform: GradientRotation(98.52 * (3.1415926535 / 180)),
                                colors: [
                                  Color(0xFF7A8CFD),
                                  Color(0xFF404FB1),
                                  Color(0xFF2B3990),
                                ],
                                stops: [0.1117, 0.6374, 0.9471],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            child: CustomText(
                              AppStrings.saveEdit,
                              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddPricingDialog() {
    // Clear previous selections
    tempProgramsForAdd.clear();
    selectedBranchesForAdd.clear();
    // Add one empty program to start
    tempProgramsForAdd.add(PortfolioPrice());

    Get.dialog(
      Dialog(
        backgroundColor: ColorCode.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                AppStrings.addProgram,
                textStyle: TextStyles.title24Medium.copyWith(color: ColorCode.primary600),
              ),
              Gaps.vGap12,
              // Multi-select branches
              CustomText(
                AppStrings.branch,
                textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
              ),
              Gaps.vGap4,
              GetBuilder<ControlPanelController>(builder: (controller) {
                return MultiSelectBranchesDropdown(
                  selectedValues: selectedBranchesForAdd,
                  onChanged: (branches) {
                    selectedBranchesForAdd.assignAll(branches);
                    controller.update();
                  },
                  branchesList: branches ?? [],
                );
              }),
              Gaps.vGap16,
              // Programs list
              CustomText(
                'Programs',
                textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
              ),
              Gaps.vGap8,
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // List of programs
                        ...List.generate(tempProgramsForAdd.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorCode.neutral300),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '${AppStrings.program} ${index + 1}',
                                      textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                                    ),
                                    if (tempProgramsForAdd.length > 1)
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => tempProgramsForAdd.removeAt(index),
                                      ),
                                  ],
                                ),
                                ProgramPriceRow(
                                  ctrl: this,
                                  program: tempProgramsForAdd[index],
                                  index: index,
                                  enable: true,
                                ),
                              ],
                            ),
                          );
                        }),
                        // Add program button
                        TextButton.icon(
                          onPressed: () => tempProgramsForAdd.add(PortfolioPrice()),
                          icon: const Icon(Icons.add, color: ColorCode.primary600),
                          label: CustomText(
                            AppStrings.addProgram,
                            textStyle: TextStyles.body14Medium.copyWith(color: ColorCode.primary600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gaps.vGap16,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Clear temp data
                        tempProgramsForAdd.clear();
                        selectedBranchesForAdd.clear();
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: ColorCode.neutral400),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.5),
                        child: CustomText(
                          AppStrings.cancel,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap16,
                  Obx(() {
                    return Visibility(
                      visible: !isSavingPrices.value,
                      replacement: const SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (selectedBranchesForAdd.isEmpty) {
                              customSnackBar(AppStrings.pleaseSelectAtLeastOneBranch, ColorCode.danger600);
                              return;
                            }
                            if (tempProgramsForAdd.isEmpty) {
                              customSnackBar(AppStrings.pleaseAddAtLeastOneProgram, ColorCode.danger600);
                              return;
                            }

                            // Add programs to main list
                            portfolioPricesModel.addAll(tempProgramsForAdd);
                            // Save with selected branches
                            await savePricingChangesWithBranches(selectedBranchesForAdd.map((b) => b.id ?? 0).toList());

                            // Clear temp data
                            tempProgramsForAdd.clear();
                            selectedBranchesForAdd.clear();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                transform: GradientRotation(98.52 * (3.1415926535 / 180)),
                                colors: [
                                  Color(0xFF7A8CFD),
                                  Color(0xFF404FB1),
                                  Color(0xFF2B3990),
                                ],
                                stops: [0.1117, 0.6374, 0.9471],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            child: CustomText(
                              AppStrings.add,
                              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // createPortfolioPrices() async {
  //   isUpdating.value = true;
  //   // change(false, status: RxStatus.loading());
  //   controlPanelRepository
  //       .createPortfolioPrices(
  //           branchId: selectedBranch?.id.toString() ?? "" ,
  //       portfolioPrice: portfolioPricesModel ?? [])
  //       .then(
  //     (value) async {
  //       if (value.statusCode == 200 || value.statusCode == 201) {
  //         // customSnackBar(value.body ?? "", ColorCode.success600);
  //         Get.dialog(Dialog(
  //           backgroundColor: ColorCode.white,
  //           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16.r),
  //           ),
  //           child: const UpdatePortfolioSuccessDialog(),
  //         ));
  //         update();
  //       }
  //       await getBranchDetails(selectedBranch?.id.toString() ?? "");
  //       // change(true, status: RxStatus.success());
  //       isUpdating.value = false;
  //     },
  //   ).onError((error, stackTrace) {
  //     print("Signup error: $error");
  //     print("StackTrace: $stackTrace");
  //     customSnackBar(error.toString(), ColorCode.danger600);
  //     // change(true, status: RxStatus.success());
  //     isUpdating.value = false;
  //   });
  // }

  // updatePortfolioPrices() async {
  //   isUpdating.value = true;
  //   // change(false, status: RxStatus.loading());
  //   controlPanelRepository
  //       .updatePortfolioPrices(
  //           branchId: selectedBranch.id.toString(),
  //           hourly: hourlyPricing,
  //           daily: dailyPricing,
  //           monthly: monthlyPricing)
  //       .then(
  //     (value) async {
  //       if (value.statusCode == 200 || value.statusCode == 201) {
  //         customSnackBar(value.body ?? "", ColorCode.success600);
  //         update();
  //       }
  //       // change(true, status: RxStatus.success());
  //       isUpdating.value = false;
  //       await getBranchDetails(selectedBranch.id.toString());
  //     },
  //   ).onError((error, stackTrace) {
  //     print("Signup error: $error");
  //     print("StackTrace: $stackTrace");
  //     customSnackBar(error.toString(), ColorCode.danger600);
  //     // change(true, status: RxStatus.success());
  //     isUpdating.value = false;
  //   });
  // }

  RxBool isParentsLoading = false.obs;

  getParents() async {
    isParentsLoading.value = true;
    // change(false, status: RxStatus.loading());
    controlPanelRepository.getParents().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          parents = null;
          parents = value.body;
          update();
        }
        isParentsLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
      isParentsLoading.value = false;
    });
  }

  getChats() async {
    // isParentsLoading.value = true;
    // change(false, status: RxStatus.loading());
    controlPanelRepository.getChats().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          chats = null;
          chats = value.body;
          update();
        }
        // isParentsLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
      // isParentsLoading.value = false;
    });
  }

  getChildren() async {
    isParentsLoading.value = true;
    // change(false, status: RxStatus.loading());
    controlPanelRepository.getChildren().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          children = null;
          children = value.body;
          update();
        }
        isParentsLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isParentsLoading.value = false;
    });
  }

  getBranchDetails(String branchId) async {
    isBranchesLoading.value = true;
    controlPanelRepository.getBranchDetails(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branch = null;
          branch = value.body;
          await getBranchTeam(branchId);
          await getParents();
          await showPortfolioPrices(branchId);
          update();
        }
        isBranchesLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      isBranchesLoading.value = false;
    });
  }

  RxBool isStatisticsLoading = false.obs;

  getStatistics() async {
    isStatisticsLoading.value = true;
    controlPanelRepository.getStatistics().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          statisticsModel = null;
          statisticsModel = value.body;
          update();
        }
        isStatisticsLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      isStatisticsLoading.value = false;
    });
  }

  List<FlSpot> buildRevenueSpots(List<TotalRevenueForTheLates5Months> revenues) {
    return List.generate(revenues.length, (i) {
      final totalPaid = revenues[i].totalPaid;
      final y = (totalPaid != null && totalPaid >= 0) ? totalPaid.toDouble() : 0.0;
      return FlSpot(i + 1.0, y);
    });
  }

  int getMaxRevenueIndex(List<TotalRevenueForTheLates5Months> revenues) {
    double max = 0;
    int index = 0;
    for (int i = 0; i < revenues.length; i++) {
      double current = revenues[i].totalPaid?.toDouble() ?? 0.0;
      if (current > max) {
        max = current;
        index = i;
      }
    }
    return index;
  }

  double calculateYPosition({
    required double chartHeight,
    required double value,
    required double minY,
    required double maxY,
  }) {
    if (maxY == minY) return chartHeight / 2; // avoid division by zero
    final normalized = (value - minY) / (maxY - minY);
    return chartHeight * (1 - normalized);
  }

  RxBool isDeletingMember = false.obs;

  deleteMember(String memberId) async {
    isDeletingMember.value = true;
    controlPanelRepository.deleteMember(memberId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branchTeamMemberModel = null;
          branchTeamMemberModel = value.body;
          Get.back();
          await getBranchTeam(selectedBranch?.id.toString() ?? "");
          update();
        }
        isDeletingMember.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isDeletingMember.value = false;
    });
  }

  RxBool isDeletingBranch = false.obs;

  deleteBranch(String branchId) async {
    isDeletingBranch.value = true;
    controlPanelRepository.deleteBranch(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 204) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          Get.back();
          await getBranches();
          update();
        }
        isDeletingBranch.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isDeletingBranch.value = false;
    });
  }

  RxBool isDeletingPrice = false.obs;

  deletePrice(String priceId) async {
    isDeletingPrice.value = true;
    controlPanelRepository.deletePrice(priceId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body ?? "", ColorCode.success600);

          update();
        }
        isDeletingPrice.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isDeletingPrice.value = false;
    });
  }

  getBranchTeam(String branchId) async {
    isBranchesLoading.value = true;
    controlPanelRepository.getBranchTeam(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branchTeamModel = null;
          branchTeamModel = value.body;
          update();
        }
        isBranchesLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      isBranchesLoading.value = false;
    });
  }

  getEnrollments() async {
    isBranchesLoading.value = true;
    controlPanelRepository.getEnrollments().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollments = null;
          enrollments = value.body?.data ?? [];
          filteredEnrollments.addAll(enrollments ?? []);
          update();
        }
        isBranchesLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      isBranchesLoading.value = false;
    });
  }

  Future<void> onRefresh() async {
    if (AuthService.to.userInfo?.user?.role == "center") {
      await getBranches();
      await getStatistics();
      await getDailyReports();
      await getEnrollments();
      await showPortfolio();
    }
    if (AuthService.to.userInfo?.user?.role == "branch_admin") {
      change(false, status: RxStatus.loading());
      await getDailyReports();
      await getEnrollments();
      await getChats();
      await getParents();
      await getBranchTeam((AuthService.to.userInfo?.user?.branchId ?? 0).toString());
      change(false, status: RxStatus.success());
    }
  }

  String getArabicMonthName(String dateKey) {
    final parts = dateKey.split('-');
    final monthNumber = int.tryParse(parts[1]) ?? 0;

    switch (monthNumber) {
      case 1:
        return "شهر يناير";
      case 2:
        return "شهر فبراير";
      case 3:
        return "شهر مارس";
      case 4:
        return "شهر إبريل";
      case 5:
        return "شهر مايو";
      case 6:
        return "شهر يونيو";
      case 7:
        return "شهر يوليو";
      case 8:
        return "شهر أغسطس";
      case 9:
        return "شهر سبتمبر";
      case 10:
        return "شهر أكتوبر";
      case 11:
        return "شهر نوفمبر";
      case 12:
        return "شهر ديسمبر";
      default:
        return "شهر غير معروف";
    }
  }

  int currentPage = 1;
  int rowsPerPage = 10;
  List<bool> checkedStates = [];

  List<DailyReport>? dailyReports;

  // Center Info Model
  CenterInfoModel centerInfoModel = CenterInfoModel();

  // RxBool isChildrenLoading = false.obs;
  getDailyReports() async {
    // isChildrenLoading.value = true;
    // change(false, status: RxStatus.loading());
    controlPanelRepository.getDailyReports().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          dailyReports = null;
          dailyReports = value.body?.data ?? [];
          checkedStates = List<bool>.filled(dailyReports?.length ?? 0, false);
          update();
        }
        // isChildrenLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      if (!error.toString().contains("Please renew your plan to continue.")) {
        customSnackBar(error.toString(), ColorCode.danger600);
      }
      // change(true, status: RxStatus.success());
      // isChildrenLoading.value = false;
    });
  }

  EnrollmentData? enrollmentData;

  enrollmentRespond({required int enrollmentId, required String respond}) async {
    if (respond == "rejected") {
      enrollments
          ?.firstWhere(
            (element) => element.enrollmentId == enrollmentId,
          )
          .isRespondingReject
          .value = true;
    } else {
      enrollments
          ?.firstWhere(
            (element) => element.enrollmentId == enrollmentId,
          )
          .isResponding
          .value = true;
    }
    // change(false, status: RxStatus.loading());
    controlPanelRepository.enrollmentRespond(enrollmentId: enrollmentId.toString(), respond: respond).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentData = null;
          enrollmentData = value.body;
          await getEnrollments();
        }
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          enrollments
              ?.firstWhere(
                (element) => element.enrollmentId == enrollmentId,
              )
              .isRespondingReject
              .value = false;
          customSnackBar(AppStrings.reservationRejectedSuccessfully, ColorCode.success600);
        } else {
          enrollments
              ?.firstWhere(
                (element) => element.enrollmentId == enrollmentId,
              )
              .isResponding
              .value = false;
          customSnackBar(AppStrings.reservationAcceptedSuccessfully, ColorCode.success600);
        }
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      if (respond == "rejected") {
        enrollments
            ?.firstWhere(
              (element) => element.enrollmentId == enrollmentId,
            )
            .isRespondingReject
            .value = false;
      } else {
        enrollments
            ?.firstWhere(
              (element) => element.enrollmentId == enrollmentId,
            )
            .isResponding
            .value = false;
      }
    });
  }

  enrollmentPaidUpdate({required int enrollmentId, required String respond}) async {
    if (respond == "rejected") {
      enrollments
          ?.firstWhere(
            (element) => element.enrollmentId == enrollmentId,
          )
          .isRespondingReject
          .value = true;
    } else {
      enrollments
          ?.firstWhere(
            (element) => element.enrollmentId == enrollmentId,
          )
          .isResponding
          .value = true;
    }
    // change(false, status: RxStatus.loading());
    controlPanelRepository.updateExistingToPaid(enrollmentId: enrollmentId.toString(), status: respond).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentData = null;
          enrollmentData = value.body;
          await getEnrollments();
        }
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          enrollments
              ?.firstWhere(
                (element) => element.enrollmentId == enrollmentId,
              )
              .isRespondingReject
              .value = false;
          customSnackBar(AppStrings.reservationRejectedSuccessfully, ColorCode.success600);
        } else {
          enrollments
              ?.firstWhere(
                (element) => element.enrollmentId == enrollmentId,
              )
              .isResponding
              .value = false;
          customSnackBar(AppStrings.reservationAcceptedSuccessfully, ColorCode.success600);
        }
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      if (respond == "rejected") {
        enrollments
            ?.firstWhere(
              (element) => element.enrollmentId == enrollmentId,
            )
            .isRespondingReject
            .value = false;
      } else {
        enrollments
            ?.firstWhere(
              (element) => element.enrollmentId == enrollmentId,
            )
            .isResponding
            .value = false;
      }
    });
  }

  List<ParentModel> getParentsNotInChats() {
    final Set<int> contactIdsInChats = chats?.where((chat) => chat.contactId != null).map((chat) => chat.contactId!).toSet() ?? <int>{};

    // Filter parents whose IDs are not in the contactIdsInChats
    return parents?.where((parent) => parent.id != null && !contactIdsInChats.contains(parent.id)).toList() ?? [];
  }

  List<ParentModel> chatParents = [];

  // final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  //
  // Future<void> initPusher() async {
  //   try {
  //     await pusher.init(
  //       apiKey: "d96caeb137f6e3295d24",
  //       cluster: "ap2",
  //       onEvent: _onPusherEvent,
  //       // FIX these 👇
  //       onSubscriptionSucceeded: (channelName, data) {
  //         print("Subscribed to $channelName with data: $data");
  //       },
  //       onConnectionStateChange: (currentState, previousState) {
  //         print("Connection changed from $previousState to $currentState");
  //       },
  //       onError: (message, code, exception) {
  //         print("Pusher error: $message | code: $code | exception: $exception");
  //       },
  //     );
  //
  //     await setupPusherConnection();
  //     await getChats();
  //   } catch (e) {
  //     print("Pusher initialization error: $e");
  //   }
  // }
  //
  // void _onPusherEvent(PusherEvent event) {
  //   print("Pusher event received: ${event.eventName}");
  //
  //   if (event.eventName == 'chat-list-updated') {
  //     try {
  //       final parsed = jsonDecode(event.data ?? '[]');
  //
  //       if (parsed is List) {
  //         chats = parsed.map((item) => ChatsModel.fromJson(item)).toList();
  //         chatParents = getParentsNotInChats();
  //         update();
  //       } else {
  //         print("Unexpected data format from Pusher: $parsed");
  //       }
  //     } catch (e) {
  //       print("Error parsing real-time message: $e");
  //     }
  //   }
  // }
  //
  // @override
  // void onClose() async{
  //   await disconnectPusher();
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.onClose();
  // }
  //
  // Future<void> setupPusherConnection() async {
  //   final channelName = 'chat-list.${AuthService.to.userInfo?.user?.id}';
  //   final channel = await pusher.getChannel(channelName);
  //   if (channel == null) {
  //     await pusher.subscribe(channelName: channelName);
  //   }
  //   await pusher.connect();
  // }
  //
  // Future<void> disconnectPusher() async {
  //   // await pusher.unsubscribe(channelName: 'chat-list.${AuthService.to.userInfo?.user?.id}');
  //   await pusher.disconnect();
  // }
  //
  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     await setupPusherConnection();
  //     await getChats();
  //   }
  // }
  //
  // @override
  // void onInit() async {
  //   change(true, status: RxStatus.success());
  //   await getBranches();
  //   await getStatistics();
  //   await getDailyReports();
  //   await getEnrollments();
  //   // await getChats();
  //   await initPusher();
  //   WidgetsBinding.instance.addObserver(this);
  //   super.onInit();
  //   // Future.delayed(const Duration(seconds: 3)).then((value) {
  //   //   final isLoggedIn = AuthService.to.isLoggedIn.value;
  //   //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
  //   //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
  //   //
  //   //   if (AuthService.to.isFirstTime) {
  //   //     Get.offNamed(Routes.BOARD);
  //   //   } else {
  //   //     if (isLoggedIn) {
  //   //       Get.offNamed(Routes.ControlPanel);
  //   //     } else {
  //   //       Get.offNamed(Routes.LOGIN);
  //   //     }
  //   //   }
  //   // });
  // }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await _initData();
    await _subscribeToChatList();
  }

  MainController? mainController;

  Future<void> _initData() async {
    change(true, status: RxStatus.success());
    if (AuthService.to.userInfo?.user?.role == "center") {
      await getBranches();
      await getStatistics();
      await getDailyReports();
      await getEnrollments();
      await getChats();
      await showPortfolio();
      await loadThumb();
      initNotificationData(parents ?? []);
      mainController = Get.find<MainController>();
    } else if (AuthService.to.userInfo?.user?.role == "branch_admin") {
      change(false, status: RxStatus.loading());
      await getDailyReports();
      await getEnrollments();
      await getChats();
      await getParents();
      await getBranchTeam((AuthService.to.userInfo?.user?.branchId ?? 0).toString());
      mainController = Get.find<MainController>();
      change(false, status: RxStatus.success());
    }
  }

  Future<void> _subscribeToChatList() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId == null) return;

    await PusherService.to.subscribe(
      channelName: 'chat-list.$userId',
      eventName: 'chat-list-updated',
      onEvent: (data) {
        try {
          final parsed = jsonDecode(data) as Map<String, dynamic>;
          final contactsJson = parsed["contacts"] as List<dynamic>;
          chats = contactsJson.map((e) => Contacts.fromJson(e as Map<String, dynamic>)).toList();
          update();
        } catch (e) {
          print("Error parsing chat-list-updated: $e");
        }
      },
    );
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     await _subscribeToChatList();
  //     await getChats();
  //   }
  // }

  // Future<File> compressImage(File file, {int quality = 50}) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final targetPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
  //
  //   final result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: quality,
  //     format: CompressFormat.png,
  //   );
  //
  //   if (result == null) {
  //     return file; // fallback to original if compression fails
  //   }
  //
  //   return File(result.path); // ensure it's a File
  // }

  // Future<File> downloadAndCompressImage(String imageUrl, {int quality = 50}) async {
  //   final response = await http.get(Uri.parse(imageUrl));
  //
  //   final tempDir = await getTemporaryDirectory();
  //   final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.webp';
  //   final file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //
  //   return await compressImage(file, quality: quality);
  // }

  PortfolioResponseModel? portfolioResponseModel;
  RxBool isUpdating = false.obs;

  // updatePortfolio(FormData formData) async {
  //   isUpdating.value = true;
  //   controlPanelRepository
  //       .updatePortfolio(
  //           formData: formData,
  //           centerId: showPortfolioResponseModel?.portofilo?.id.toString(),
  //           isUpdate: showPortfolioResponseModel?.portofilo?.id != null)
  //       .then((value) async {
  //     if (value.statusCode == 200 || value.statusCode == 201) {
  //       portfolioResponseModel = value.body;
  //       await showPortfolio();
  //       update();
  //       // customSnackBar(
  //       //     portfolioResponseModel?.message ?? "", ColorCode.success600);
  //       // Get.dialog(Dialog(
  //       //   backgroundColor: ColorCode.white,
  //       //   insetPadding: const EdgeInsets.symmetric(horizontal: 16),
  //       //   shape: RoundedRectangleBorder(
  //       //     borderRadius: BorderRadius.circular(16.r),
  //       //   ),
  //       //   child: const UpdatePortfolioSuccessDialog(),
  //       // ));
  //     }
  //     isUpdating.value = false;
  //   }).onError((error, stackTrace) {
  //     print("Signup error: $error");
  //     print("StackTrace: $stackTrace");
  //     customSnackBar(error.toString(), ColorCode.danger600);
  //     isUpdating.value = false;
  //   });
  // }

  // Selected branches for pricing operations
  final RxList<int> selectedBranchIdsForPricing = <int>[].obs;

  // Temporary list for add dialog programs
  final RxList<PortfolioPrice> tempProgramsForAdd = <PortfolioPrice>[].obs;

  // Selected branches for add dialog
  final RxList<BranchModel> selectedBranchesForAdd = <BranchModel>[].obs;

  Future<bool> createPortfolioPrices() async {
    isSavingPrices.value = true;
    try {
      final branchIds =
          selectedBranchIdsForPricing.isEmpty ? [int.tryParse(selectedBranch?.id.toString() ?? "0") ?? 0] : selectedBranchIdsForPricing.toList();
      final value = await controlPanelRepository.createPortfolioPrices(
        branchIds: branchIds,
        portfolioPrice: portfolioPricesModel.toList(),
      );

      if (value.statusCode == 200 || value.statusCode == 201) {
        // Refetch prices for the selected branch to reflect changes
        // Refresh current branch prices only
        await showPortfolioPrices(selectedBranch?.id.toString() ?? "");
        update();
        isSavingPrices.value = false;
        return true; // ✅ Success
      }
      isSavingPrices.value = false;
      return false;
    } catch (error, stackTrace) {
      print("createPortfolioPrices error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isSavingPrices.value = false;
      return false; // ❌ Failed
    }
  }

  Future<void> savePricingChanges() async {
    // Only handle pricing here; portfolio saving is separate
    final changed = pricesChanged;
    if (!changed) return;

    final success = await createPortfolioPrices();
    if (success) {
      // Snapshot originals to the current list
      _pricesOriginal = portfolioPricesModel.toList().map((e) => e.copy()).toList();
      Get.back();
      Get.dialog(Dialog(
        backgroundColor: ColorCode.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: const UpdatePortfolioSuccessDialog(),
      ));
    }
  }

  Future<void> savePricingChangesWithBranches(List<int> branchIds) async {
    // Save pricing with specific branches
    isSavingPrices.value = true;
    try {
      final value = await controlPanelRepository.createPortfolioPrices(
        branchIds: branchIds,
        portfolioPrice: portfolioPricesModel.toList(),
      );

      if (value.statusCode == 200 || value.statusCode == 201) {
        // Refresh current branch prices only
        await showPortfolioPrices(selectedBranchPricing?.id.toString() ?? "");
        update();
        isSavingPrices.value = false;
        Get.back();
        // Show success dialog
        Get.dialog(Dialog(
          backgroundColor: ColorCode.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const UpdatePortfolioSuccessDialog(),
        ));
      } else {
        isSavingPrices.value = false;
        customSnackBar('Failed to save pricing', ColorCode.danger600);
      }
    } catch (error, stackTrace) {
      print("savePricingChangesWithBranches error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isSavingPrices.value = false;
    }
  }

  Future<void> deletePriceById(int priceId) async {
    isDeletingPriceById[priceId] = true;
    update();
    try {
      final res = await controlPanelRepository.deletePrice(priceId.toString());
      if (res.statusCode == 200 || res.statusCode == 201) {
        // refresh current branch prices
        await showPortfolioPrices(selectedBranch?.id.toString() ?? "");
        Get.dialog(Dialog(
          backgroundColor: ColorCode.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const UpdatePortfolioSuccessDialog(),
        ));
      } else {
        customSnackBar('Failed to delete price', ColorCode.danger600);
      }
    } catch (e) {
      customSnackBar(e.toString(), ColorCode.danger600);
    } finally {
      isDeletingPriceById.remove(priceId);
      update();
    }
  }

  Future<bool> updatePortfolio(FormData formData) async {
    isUpdating.value = true;
    try {
      final value = await controlPanelRepository.updatePortfolio(
        formData: formData,
        centerId: showPortfolioResponseModel?.portofilo?.id.toString(),
        isUpdate: showPortfolioResponseModel?.portofilo?.id != null,
      );

      if (value.statusCode == 200 || value.statusCode == 201) {
        portfolioResponseModel = value.body;
        await showPortfolio();
        update();
        isUpdating.value = false;
        return true; // ✅ Success
      }
      isUpdating.value = false;
      return false;
    } catch (error, stackTrace) {
      print("updatePortfolio error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isUpdating.value = false;
      return false; // ❌ Failed
    }
  }

  Future<void> collectCenterInfoData() async {
    final newCenterInfoModel = centerInfoModel.copyWith(
      centerName: centerNameController.text,
      centerSlogan: centerSloganController.text,
      description: centerdescController.text,
      backgroundImage: centerBackgroundImage,
      branches: branchControllers.map((c) => c.text).where((t) => t.isNotEmpty).toList(),
      adImages: adImages,
      ourPhilosophy: ourPhilosophyController.text,
      ourMethodology: ourMethodologyController.text,
      ourGoal: ourGoalController.text,
      nurserySpace: nurserySpaceController.text,
      numberOfClasses: numberOfClassesController.text,
      numberOfTeamMembers: numberOfTeamMembersController.text,
      activitiesDescription: activitiesController.text,
      activityImages: activities,
      teamMembers: members,
      services: services,
    );

    final diffFormData = newCenterInfoModel.diffWith(centerInfoModel);

    final shouldForceUpdatePortfolio = (centerNameController.text.isNotEmpty) ||
        (centerSloganController.text.isNotEmpty) ||
        (centerdescController.text.isNotEmpty) ||
        (centerBackgroundImage != null);

    if (diffFormData.fields.isEmpty && diffFormData.files.isEmpty && !shouldForceUpdatePortfolio) {
      return;
    }

    bool success = false;

    // Update portfolio
    if ((diffFormData.fields.isNotEmpty || diffFormData.files.isNotEmpty) && shouldForceUpdatePortfolio) {
      final portfolioResult = await updatePortfolio(diffFormData);
      if (portfolioResult) success = true;
    }

    // ✅ Show dialog only once if any update was successful
    if (success) {
      Get.dialog(Dialog(
        backgroundColor: ColorCode.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: const UpdatePortfolioSuccessDialog(),
      ));
    }
  }

  late final ui.Image? thumbImage;

  Future<ui.Image> loadUiImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> loadThumb() async {
    final img = await loadUiImage('assets/images/thumb.png');
    thumbImage = img;
    update();
  }

  @override
  void onClose() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId != null) {
      await PusherService.to.unsubscribe('chat-list.$userId');
    }
    for (var controller in branchControllers) {
      controller.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  Future<void> sendNotificationExpired({required int enrollmentId}) async {
    enrollments
        ?.firstWhere(
          (element) => element.enrollmentId == enrollmentId,
        )
        .isResponding
        .value = true;
    controlPanelRepository
        .sendNotificationExpired(
      enrollmentId: enrollmentId.toString(),
    )
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          // change(true, status: RxStatus.success());
          enrollments
              ?.firstWhere(
                (element) => element.enrollmentId == enrollmentId,
              )
              .isResponding
              .value = false;
          customSnackBar(AppStrings.notificationAndEmailHasBeenSent, ColorCode.success600);
          update();
        }
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      enrollments
          ?.firstWhere(
            (element) => element.enrollmentId == enrollmentId,
          )
          .isResponding
          .value = false;
    });
  }
}
