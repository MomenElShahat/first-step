import 'package:get/get.dart';
import '../../data/center_free_trail_repository.dart';

class CenterFreeTrailController extends SuperController<bool> {
  CenterFreeTrailController({required this.centerFreeTrailRepository});

  final ICenterFreeTrailRepository centerFreeTrailRepository;
 
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
