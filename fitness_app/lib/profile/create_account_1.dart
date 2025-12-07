import 'package:fitness_app/auth/login.dart';
import 'package:fitness_app/constans/text_styles.dart';
import 'package:fitness_app/constans/widgets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'create_account_2.dart';

class CreateAccount1 extends StatefulWidget {
  static String routeName = 'createAccount1';

  @override
  State<CreateAccount1> createState() => _CreateAccount1State();
}

class _CreateAccount1State extends State<CreateAccount1> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _continue() {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    Provider.of<UserProvider>(context, listen: false).saveAccountInfo(
      username: username,
      email: email,
      password: pass,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username', style: TextStyles.label),
            Widgets.field(
              controller: usernameController,
              hint: 'E.g Johntheone',
              icon: Icon(Icons.person_sharp, color: AppColors.primeOrange),
            ),
            Spacer(),

            Text('Email', style: TextStyles.label),
            Widgets.field(
              controller: emailController,
              hint: 'Enter your email address',
              icon: Icon(Icons.email_sharp, color: AppColors.primeOrange),
            ),
            Spacer(),

            Text('Password', style: TextStyles.label),
            Widgets.passwordField(
              passwordController: passwordController,
              obscurePassword: _obscurePassword,
              func: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            Spacer(),

            Text('Confirm password', style: TextStyles.label),
            Widgets.passwordField(
              passwordController: confirmController,
              obscurePassword: _obscureConfirmPassword,
              func: () =>
                  setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
            SizedBox(height: 80.h),

            Widgets.button(text: 'Continue', func: _continue),
          ],
        ),
      ),
    );
  }
}
