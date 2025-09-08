import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts/text_styles.dart';
import '../resources/strings_generated.dart';
import '../widgets/custom_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.white,centerTitle: true,
        title: CustomText(AppStrings.noInternetConnection,textStyle: TextStyles.body16Medium.copyWith(
          color: Colors.white
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_off,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.tryAgain,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}