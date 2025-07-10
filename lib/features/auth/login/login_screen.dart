import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/app_text_style.dart';

import 'package:event_app/features/onBoarding/view/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_language_provider.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_route.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_form_filed.dart';
import '../../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(text: "charlesgdawe@examplepetstore.com");

  final TextEditingController passwordController = TextEditingController(text: "Kh@123456");

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLocalizations = AppLocalizations.of(context)!;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);

    bool isEnglish = appLanguageProvider.locale.languageCode == 'en';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: width * 0.35,
                  height: height * 0.2,
                ),
                SizedBox(height: height * 0.02),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormFiled(
                        controller: emailController,
                        hintText: appLocalizations.email,
                        prefixIcon: Icons.email,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return appLocalizations.please_enter_your_email;
                          }

                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                          if (!emailValid) {
                            return appLocalizations.please_enter_a_valid_email;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormFiled(
                        controller: passwordController,
                        hintText: appLocalizations.password,
                        prefixIcon: Icons.lock,
                        obscureText: isPasswordVisible,
                        suffixIcon: isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        keyboardType: TextInputType.text,

                        validator: validatePassword,
                        onSuffixPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.forgotPasswordRouteName);
                          },
                          child: Text(
                            appLocalizations.forgot_password,
                            style: AppTextStyle.bold20primaryLight.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      CustomButton(
                        title: appLocalizations.login,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoute.homeRouteName,
                            );
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.dont_have_account,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.registerRouteName);
                      },
                      child: Text(
                        appLocalizations.create_account,
                        style: AppTextStyle.bold20primaryLight.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLightColor,
                        endIndent: width * 0.04,
                        indent: width * 0.07,
                        thickness: 1,
                      ),
                    ),
                    Text(appLocalizations.or, style: AppTextStyle.bold20primaryLight),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLightColor,
                        endIndent: width * 0.07,
                        indent: width * 0.04,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                CustomButton(
                  backgroundColor: Theme.of(context).canvasColor,
                  onPressed: () {},
                  hasIcons: true,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.googleIcon),
                      SizedBox(width: width * 0.02),
                      Text(
                        appLocalizations.google,
                        style: AppTextStyle.medium20primaryLight,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                ToggleSwitch(
                  themeMode: appLanguageProvider.themeMode,
                  isSelected: isEnglish,
                  imagePathLeft: AppAssets.enLogo,
                  imagePathRight: AppAssets.egLogo,
                  onTapLeft: () {
                    if (!isEnglish) appLanguageProvider.changeLanguage("en");
                  },
                  onTapRight: () {
                    if (isEnglish) appLanguageProvider.changeLanguage("ar");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.please_enter_your_password;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.password_must_be_at_least_6_characters;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context)!.password_must_contain_at_least_one_uppercase_letter;
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return AppLocalizations.of(context)!.password_must_contain_at_least_one_lowercase_letter;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppLocalizations.of(context)!.password_must_contain_at_least_one_number;
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppLocalizations.of(context)!.password_must_contain_at_least_one_special_character;
    }

    return null;
  }
}
