import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:get/get.dart';

import '../../../control_panel/models/parent_model.dart';
import '../../data/choose_parents_repository.dart';

class ChooseParentsController extends SuperController<bool> {
  ChooseParentsController({required this.chooseParentsRepository});

  final IChooseParentsRepository chooseParentsRepository;

  List<ParentModel>? parents;
  int currentPage = 1;
  int rowsPerPage = 10;
  List<bool> checkedStates = [];
  Map<int, ChildModel?> selectedChildrenPerParent = {}; // parentIndex -> selected child
  List<int> selectedChildIds = [];
  final ChildModel allChildrenModel = ChildModel(id: -1, childName: 'كل الأطفال');
  List<int> getSelectedChildIdsForApi() {
    final List<int> ids = [];

    for (int i = 0; i < (parents?.length ?? 0); i++) {
      if (checkedStates[i]) {
        final selected = selectedChildrenPerParent[i];
        final parent = parents![i];

        if (selected != null) {
          if (selected.id == -1) {
            // 'All Children' selected
            ids.addAll(parent.children?.map((c) => c.id!).where((id) => !ids.contains(id)) ?? []);
          } else {
            if (!ids.contains(selected.id)) {
              ids.add(selected.id!);
            }
          }
        }
      }
    }

    return ids;
  }
  @override
  void onInit() {
    var args = Get.arguments;
    parents = args;
    checkedStates = List<bool>.filled(parents?.length ?? 0, false);

    for (int i = 0; i < (parents?.length ?? 0); i++) {
      if ((parents?[i].children?.isNotEmpty ?? false)) {
        selectedChildrenPerParent[i] = parents![i].children!.first;
      }
    }
    super.onInit();
  }

  void onParentChecked(int index, bool? isChecked) {
    checkedStates[index] = isChecked ?? false;

    final parent = parents![index];
    final selectedChild = selectedChildrenPerParent[index];

    if (isChecked == true) {
      if (selectedChild?.id == -1) {
        selectedChildIds.addAll(
          parent.children!.map((c) => c.id!).where((id) => !selectedChildIds.contains(id)),
        );
      } else {
        if (!selectedChildIds.contains(selectedChild?.id)) {
          selectedChildIds.add(selectedChild!.id!);
        }
      }
    } else {
      // Remove child's ID(s)
      if (selectedChild?.id == -1) {
        parent.children?.forEach((c) => selectedChildIds.remove(c.id));
      } else {
        selectedChildIds.remove(selectedChild?.id);
      }
    }

    update();
  }
  bool isSelectAllChecked = false;

  void toggleSelectAll(bool? checked, int startIndex, int endIndex) {
    isSelectAllChecked = checked ?? false;

    for (int i = startIndex; i < endIndex; i++) {
      checkedStates[i] = isSelectAllChecked;

      final selected = selectedChildrenPerParent[i];
      final parent = parents![i];

      if (isSelectAllChecked) {
        if (selected?.id == allChildrenModel.id) {
          selectedChildIds.addAll(
            parent.children?.map((c) => c.id!).where((id) => !selectedChildIds.contains(id)) ?? [],
          );
        } else {
          if (selected != null && !selectedChildIds.contains(selected.id)) {
            selectedChildIds.add(selected.id!);
          }
        }
      } else {
        // Uncheck all — remove any child ids
        parent.children?.forEach((c) => selectedChildIds.remove(c.id));
      }
    }

    update();
  }

  void onChildSelected(int parentIndex, ChildModel? child) {
    selectedChildrenPerParent[parentIndex] = child;

    if (checkedStates[parentIndex]) {
      // update selectedChildIds
      final parent = parents![parentIndex];
      // Remove previous selection
      parent.children?.forEach((c) => selectedChildIds.remove(c.id));

      if (child?.id == -1) {
        parent.children?.forEach((c) {
          if (!selectedChildIds.contains(c.id)) {
            selectedChildIds.add(c.id!);
          }
        });
      } else {
        if (!selectedChildIds.contains(child?.id)) {
          selectedChildIds.add(child!.id!);
        }
      }
    }

    update();
  }

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

