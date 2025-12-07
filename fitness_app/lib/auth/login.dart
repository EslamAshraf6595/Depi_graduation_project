import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fitness_app/constans/widgets.dart';
import 'package:fitness_app/constans/text_styles.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/constans/classes.dart';
import 'package:fitness_app/provider/user_provider.dart';
import 'package:fitness_app/roots/app_roots.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  bool _loading = false; // UI state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Widgets.mainBackgroundDecoration(
        SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(Paths.logoPath, scale: 2)),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Login to your Account',
                      style: TextStyles.titles,
                    ),
                  ),

                  const Spacer(flex: 2),

                  /// EMAIL
                  Text('Email', style: TextStyles.label),
                  const SizedBox(height: 4),
                  Widgets.field(
                    controller: emailController,
                    hint: 'Enter your email',
                    icon: const Icon(Icons.email_outlined, color: AppColors.grey),
                  ),

                  const Spacer(),

                  /// PASSWORD
                  Text('Password', style: TextStyles.label),
                  const SizedBox(height: 4),
                  Widgets.passwordField(
                    passwordController: passwordController,
                    obscurePassword: _obscurePassword,
                    func: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),

                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Widgets.forgotPassword(),
                  ),

                  const Spacer(flex: 2),

                  /// LOGIN BUTTON
                  _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primeOrange),
                        )
                      : Widgets.button(
                          text: 'Login',
                          func: () => _login(context),
                        ),

                  const Spacer(),

                  /// SIGN UP NAVIGATION
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, 'createAccountSlider'),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyles.smallText
                              .copyWith(color: AppColors.white),
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyles.smallText
                                  .copyWith(color: AppColors.primeOrange),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // const Spacer(flex: 2),

                  /// OTHER LOGIN OPTIONS
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: Text(
                  //       'Alternatively Login with:',
                  //       style: TextStyles.label.copyWith(color: AppColors.white),
                  //     ),
                  //   ),
                  // ),

                  // OutlineButton(
                  //   imagePath: 'assets/apple.png',
                  //   text: 'APPLE ID',
                  //   onPressed: () {},
                  // ),
                  // const SizedBox(height: 10),
                  // OutlineButton(
                  //   imagePath: 'assets/google.png',
                  //   text: 'GOOGLE',
                  //   onPressed: () {},
                  // ),

                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  //                          LOGIN LOGIC
  // -------------------------------------------------------------------------
  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    setState(() => _loading = true);

    try {
      final userProv = Provider.of<UserProvider>(context, listen: false);

      /// **** Call login function from provider
      final success = await userProv.login(email, password);

      if (!success) {
        _showError("Invalid email or password");
        setState(() => _loading = false);
        return;
      }

      /// Navigate
      Navigator.pushReplacementNamed(context, AppRoots.homeScreen);
    } catch (e) {
      _showError("Something went wrong");
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }
}
