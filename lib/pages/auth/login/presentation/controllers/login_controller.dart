import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_step/pages/auth/login/models/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../consts/colors.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/login_repository.dart';

class LoginController extends SuperController<dynamic> {
  LoginController({required this.loginRepository});

  final ILoginRepository loginRepository;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool isHidden = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onLoginClicked() async {
    change(false, status: RxStatus.loading());
    loginRepository
        .login(LoginRequest(
      email: email.text,
      password: password.text,
    ))
        .then((value) async {
      if (value.body?.user != null) {
        AuthService.to.isGuest = false;
        // AuthService.to.savePassword(password.text);
        // AuthService.to.isParent = value.body?.user?.role == "parent" ? true : false;
        update();
        if (value.body?.user?.role != "branch_admin") {
          Get.offAllNamed(
            Routes.BOTTOM_NAVIGATION,
          );
        } else {
          Get.offAllNamed(Routes.CONTROL_PANEL_SCREEN);
        }
      } else {
        customSnackBar(value.body?.message ?? "", ColorCode.danger600);
      }
      change(true, status: RxStatus.success());
    }, onError: (error) {
      customSnackBar(error.toString() ?? "", ColorCode.danger600);
      change(false, status: RxStatus.success());
    });
  }

  RxBool isLoggingIn = false.obs;
  Future<void> onLoginWithGoogleClicked() async {
    isLoggingIn.value = true;

    try {
      // Initialize Google Sign-In with scopes
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Always sign out to force account selection
      await googleSignIn.signOut();

      // Step 1: Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        customSnackBar("Google Sign-In was cancelled", ColorCode.danger600);
        return;
      }

      // Step 2: Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        customSnackBar("Failed to retrieve accessToken", ColorCode.danger600);
        return;
      }

      // Step 3: Firebase sign-in (optional, only if you still need Firebase auth locally)
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print("googleAuth.accessToken: $accessToken");
        print("googleAuth.idToken: $idToken");

        // Send accessToken to backend instead of serverAuthCode
        final response = await loginRepository.loginWithGoogle(token: accessToken);

        if (response.body?.user != null) {
          AuthService.to.isGuest = false;
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          await FirebaseAuth.instance.signOut();
          await googleSignIn.signOut();
          customSnackBar(response.body?.message ?? "Login failed", ColorCode.danger600);
        }
      } else {
        customSnackBar("Google Sign-In failed: Firebase user is null", ColorCode.danger600);
      }
    } catch (e) {
      print("errorerror $e");
      customSnackBar(e.toString(), ColorCode.danger600);
    } finally {
      isLoggingIn.value = false;
    }
  }

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    super.onInit();
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
}
