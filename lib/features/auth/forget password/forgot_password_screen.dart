import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/widgets/custom_text_form_filed.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.changeSetting),
            SizedBox(height: 20),
            CustomTextFormFiled(
              hintText: "Email",
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress, controller: emailController,
            ),
            SizedBox(height: 20),
            CustomButton(onPressed: () {}, title: "Reset Password"),
          ],
        ),
      ),
    );
  }
}
