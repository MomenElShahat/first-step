import 'package:first_step/pages/auth/type_selection/presentation/views/type_selection_view.dart';
import 'package:first_step/pages/center/branch_details/bindings/branch_details_binding.dart';
import 'package:get/get.dart';
import '../pages/auth/login/bindings/login_binding.dart';
import '../pages/auth/login/presentation/views/login_view.dart';
import '../pages/auth/onboarding/bindings/onboarding_binding.dart';
import '../pages/auth/onboarding/presentation/views/onboarding_view.dart';
import '../pages/auth/otp/bindings/otp_binding.dart';
import '../pages/auth/otp/presentation/views/otp_view.dart';
import '../pages/auth/reset_password/bindings/reset_password_binding.dart';
import '../pages/auth/reset_password/presentation/views/reset_password_view.dart';
import '../pages/auth/splash/bindings/splash_binding.dart';
import '../pages/auth/splash/presentation/views/splash_view.dart';
import '../pages/auth/type_selection/bindings/type_selection_binding.dart';
import '../pages/auth/verify_email/bindings/verify_email_binding.dart';
import '../pages/auth/verify_email/presentation/views/verify_email_view.dart';
import '../pages/blog_details/bindings/blog_details_binding.dart';
import '../pages/blog_details/presentation/view/blog_details_screen.dart';
import '../pages/booking_details/bindings/booking_details_binding.dart';
import '../pages/booking_details/presentation/view/booking_details_screen.dart';
import '../pages/bottom_navigation/biniding/navigation_binding.dart';
import '../pages/bottom_navigation/bottom_navigation_widget.dart';
import '../pages/center/add_member/bindings/add_member_binding.dart';
import '../pages/center/add_member/presentation/views/add_member_view.dart';
import '../pages/center/auth/signup/bindings/signup_binding.dart';
import '../pages/center/auth/signup/presentation/views/signup_view.dart';
import '../pages/center/billing_history/bindings/billing_history_binding.dart';
import '../pages/center/billing_history/presentation/view/billing_history_screen.dart';
import '../pages/center/branch_add/bindings/branch_add_binding.dart';
import '../pages/center/branch_add/presentation/views/branch_add_view.dart';
import '../pages/center/branch_details/presentation/views/branch_details_view.dart';
import '../pages/center/branch_edit/bindings/branch_edit_binding.dart';
import '../pages/center/branch_edit/presentation/views/branch_edit_view.dart';
import '../pages/center/center_free_trail/bindings/center_free_trail_binding.dart';
import '../pages/center/center_free_trail/presentation/view/center_free_trail_screen.dart';
import '../pages/center/chat_details/bindings/chat_details_binding.dart';
import '../pages/center/chat_details/presentation/views/chat_details_view.dart';
import '../pages/center/child_details/bindings/child_details_binding.dart';
import '../pages/center/child_details/presentation/views/child_details_view.dart';
import '../pages/center/choose_parents/bindings/choose_parents_binding.dart';
import '../pages/center/choose_parents/presentation/view/choose_parents_screen.dart';
import '../pages/center/control_panel/bindings/control_panel_binding.dart';
import '../pages/center/control_panel/presentation/views/control_panel_view.dart';
import '../pages/center/edit_member/bindings/edit_member_binding.dart';
import '../pages/center/edit_member/presentation/views/edit_member_view.dart';
import '../pages/center/edit_profile/bindings/edit_profile_binding.dart';
import '../pages/center/edit_profile/presentation/view/edit_profile_screen.dart';
import '../pages/center/parent_details/bindings/parent_details_binding.dart';
import '../pages/center/parent_details/presentation/views/parent_details_view.dart';
import '../pages/center/search/bindings/search_binding.dart';
import '../pages/center/search/presentation/views/search_view.dart';
import '../pages/center/send_daily_report/bindings/send_daily_report_binding.dart';
import '../pages/center/send_daily_report/presentation/view/send_daily_report_screen.dart';
import '../pages/daily_report_details/bindings/daily_report_details_binding.dart';
import '../pages/daily_report_details/presentation/view/daily_report_details_screen.dart';
import '../pages/faq/bindings/faq_binding.dart';
import '../pages/faq/presentation/view/faq_screen.dart';
import '../pages/parent/add_child_parent/bindings/add_child_parent_binding.dart';
import '../pages/parent/add_child_parent/presentation/view/add_child_parent_screen.dart';
import '../pages/parent/auth/add_child/bindings/add_child_binding.dart';
import '../pages/parent/auth/add_child/presentation/views/add_child_view.dart';
import '../pages/parent/auth/signup_parent/bindings/signup_parent_binding.dart';
import '../pages/parent/auth/signup_parent/presentation/views/signup_parent_view.dart';
import '../pages/parent/booking/bindings/booking_binding.dart';
import '../pages/parent/booking/presentation/view/booking_screen.dart';
import '../pages/parent/center_details_parent/bindings/center_details_parent_binding.dart';
import '../pages/parent/center_details_parent/presentation/views/center_details_parent_view.dart';
import '../pages/parent/child_reservations/bindings/child_reservations_binding.dart';
import '../pages/parent/child_reservations/presentation/view/child_reservations_screen.dart';
import '../pages/parent/edit_child_details/bindings/edit_child_details_binding.dart';
import '../pages/parent/edit_child_details/presentation/views/edit_child_details_view.dart';
import '../pages/parent/edit_profile_parent/bindings/edit_profile_parent_binding.dart';
import '../pages/parent/edit_profile_parent/presentation/view/edit_profile_parent_screen.dart';
import '../pages/parent/parent_payment/bindings/parent_payment_binding.dart';
import '../pages/parent/parent_payment/presentation/view/parent_payment_screen.dart';
import '../pages/parent/search_parent/bindings/search_parent_binding.dart';
import '../pages/parent/search_parent/presentation/views/search_parent_view.dart';
import '../pages/payment_success/bindings/payment_success_binding.dart';
import '../pages/payment_success/presentation/view/payment_success_screen.dart';
import '../pages/privacy/bindings/privacy_binding.dart';
import '../pages/privacy/presentation/view/privacy_screen.dart';
import '../pages/terms/bindings/terms_binding.dart';
import '../pages/terms/presentation/view/terms_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: Routes.TYPESELECTIONSCREEN, page: () => const TypeSelectionScreen(), binding: TypeSelectionBinding()),
    GetPage(name: Routes.ONBOARDING, page: () => const OnboardingScreen(), binding: OnboardingBinding()),
    GetPage(name: Routes.SIGNUP, page: () => const SignupScreen(), binding: SignupBinding()),
    GetPage(name: Routes.SIGNUP_PARENT, page: () => const SignupParentScreen(), binding: SignupParentBinding()),
    GetPage(name: Routes.ADD_CHILD, page: () => const AddChildScreen(), binding: AddChildBinding()),
    GetPage(name: Routes.LOGIN, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.VERIFY_EMAIL, page: () => const VerifyEmailScreen(), binding: VerifyEmailBinding()),
    GetPage(name: Routes.OTP, page: () => const OtpScreen(), binding: OtpBinding()),
    GetPage(name: Routes.RESET_PASSWORD, page: () => const ResetPasswordScreen(), binding: ResetPasswordBinding()),
    GetPage(name: Routes.BOTTOM_NAVIGATION, page: () => const BottomNavigationWidget(), binding: NavigationBinding()),
    GetPage(name: Routes.SEARCH_PARENT, page: () => const SearchParentScreen(), binding: SearchParentBinding()),
    GetPage(name: Routes.SEARCH_CENTER, page: () => const SearchScreen(), binding: SearchBinding()),
    GetPage(name: Routes.CENTER_DETAILS_PARENT, page: () => const CenterDetailsParentScreen(), binding: CenterDetailsParentBinding()),
    GetPage(name: Routes.PARENT_DETAILS, page: () => const ParentDetailsScreen(), binding: ParentDetailsBinding()),
    GetPage(name: Routes.CHILD_DETAILS_SCREEN, page: () => const ChildDetailsScreen(), binding: ChildDetailsBinding()),
    GetPage(name: Routes.BRANCH_DETAILS_SCREEN, page: () => const BranchDetailsScreen(), binding: BranchDetailsBinding()),
    GetPage(name: Routes.ADD_MEMBER_SCREEN, page: () => const AddMemberScreen(), binding: AddMemberBinding()),
    GetPage(name: Routes.EDIT_MEMBER_SCREEN, page: () => const EditMemberScreen(), binding: EditMemberBinding()),
    GetPage(name: Routes.CHAT_DETAILS_SCREEN, page: () => const ChatDetailsScreen(), binding: ChatDetailsBinding()),
    GetPage(name: Routes.BRANCH_EDIT_SCREEN, page: () => const BranchEditScreen(), binding: BranchEditBinding()),
    GetPage(name: Routes.EDIT_CHILD_DETAILS_SCREEN, page: () => const EditChildDetailsScreen(), binding: EditChildDetailsBinding()),
    GetPage(name: Routes.ADD_CHILD_PARENT_SCREEN, page: () => const AddChildParentScreen(), binding: AddChildParentBinding()),
    GetPage(name: Routes.TERMS, page: () => const TermsScreen(), binding: TermsBinding()),
    GetPage(
        name: Routes.CONTROL_PANEL_SCREEN,
        page: () => ControlPanelScreen(
              openDrawer: null,
              currentIndex: 0.obs,
            ),
        binding: ControlPanelBinding()),
    GetPage(name: Routes.BOOKING_SCREEN, page: () => const BookingScreen(), binding: BookingBinding()),
    GetPage(name: Routes.BLOG_DETAILS_SCREEN, page: () => const BlogDetailsScreen(), binding: BlogDetailsBinding()),
    GetPage(name: Routes.DAILY_REPORT_DETAILS_SCREEN, page: () => const DailyReportDetailsScreen(), binding: DailyReportDetailsBinding()),
    GetPage(name: Routes.CHOOSE_PARENTS_SCREEN, page: () => const ChooseParentsScreen(), binding: ChooseParentsBinding()),
    GetPage(name: Routes.SEND_DAILY_REPORT_SCREEN, page: () => const SendDailyReportScreen(), binding: SendDailyReportBinding()),
    GetPage(name: Routes.FAQ_SCREEN, page: () => const FaqScreen(), binding: FaqBinding()),
    GetPage(name: Routes.BOOKING_DETAILS_SCREEN, page: () => const BookingDetailsScreen(), binding: BookingDetailsBinding()),
    GetPage(name: Routes.CHILD_RESERVATIONS_SCREEN, page: () => const ChildReservationsScreen(), binding: ChildReservationsBinding()),
    GetPage(name: Routes.PARENT_PAYMENT_SCREEN, page: () => const ParentPaymentScreen(), binding: ParentPaymentBinding()),
    GetPage(name: Routes.CENTER_FREE_TRAIL_SCREEN, page: () => const CenterFreeTrailScreen(), binding: CenterFreeTrailBinding()),
    GetPage(name: Routes.PRIVACY, page: () => const PrivacyScreen(), binding: PrivacyBinding()),
    GetPage(name: Routes.BRANCH_ADD_SCREEN, page: () => const BranchAddScreen(), binding: BranchAddBinding()),
    GetPage(name: Routes.PAYMENT_SUCCESS_SCREEN, page: () => const PaymentSuccessScreen(), binding: PaymentSuccessBinding()),
    GetPage(name: Routes.EDIT_PROFILE_SCREEN, page: () => const EditProfileScreen(), binding: EditProfileBinding()),
    GetPage(name: Routes.EDIT_PROFILE_PARENT_SCREEN, page: () => const EditProfileParentScreen(), binding: EditProfileParentBinding()),
    GetPage(name: Routes.BILLING_HISTORY_SCREEN, page: () => const BillingHistoryScreen(), binding: BillingHistoryBinding()),
  ];
}
