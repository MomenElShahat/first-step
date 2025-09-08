import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/control_panel/models/branch_model.dart';
import '../../data/child_reservations_repository.dart';
import '../../model/cancel_response_model.dart';
import '../../model/child_enrollment_details_model.dart';
import '../../model/parent_branches_model.dart';

class ChildReservationsController extends SuperController<bool> {
  ChildReservationsController({required this.childReservationsRepository});

  final IChildReservationsRepository childReservationsRepository;

  List<ChildEnrollments>? enrollments;

  List<BranchModel>? branches;

  CancelResponseModel? cancelResponseModel;

  getChildEnrollments(int childId) async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    childReservationsRepository.getChildEnrollments(childId.toString()).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollments = null;
          enrollments = value.body?.enrollments ?? [];
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

  getParentBranches() async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    childReservationsRepository.getParentBranches().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branches = null;
          branches = value.body ?? [];
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

  enrollmentRespond(int enrollmentId) async {
    enrollments
        ?.firstWhere(
          (element) => element.id == enrollmentId,
        )
        .isRespondingReject
        .value = true;

    // change(false, status: RxStatus.loading());
    childReservationsRepository.enrollmentRespond(enrollmentId.toString()).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          cancelResponseModel = null;
          cancelResponseModel = value.body;
        }
        // change(true, status: RxStatus.success());
        enrollments
            ?.firstWhere(
              (element) => element.id == enrollmentId,
            )
            .isRespondingReject
            .value = false;
        customSnackBar(
            cancelResponseModel?.message ?? "", ColorCode.success600);
        await getChildEnrollments(childId ?? 0);
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      enrollments
          ?.firstWhere(
            (element) => element.id == enrollmentId,
          )
          .isRespondingReject
          .value = false;
    });
  }

  int? childId;

  Future<void> onRefresh()async{
    await getChildEnrollments(childId ?? 0);
    await getParentBranches();
  }

  @override
  Future<void> onInit() async {
    var args = Get.arguments;
    childId = args;
    await getChildEnrollments(childId ?? 0);
    await getParentBranches();
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
