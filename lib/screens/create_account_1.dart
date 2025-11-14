import 'package:final_project/screens/create_account_2.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constans/widgets.dart';
import 'package:final_project/constans/text_styles.dart';

import '../constans/colors.dart';

class CreateAccount1 extends StatefulWidget {
   CreateAccount1({super.key,});
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Username', style: TextStyles.label),
            ),
            Widgets.field(
              controller: usernameController,
              hint: 'E.g Johntheone',
              icon: Icon(Icons.person_sharp,color: AppColors.label,),
            ),
            Spacer(flex: 1,),
            Text('Email', style: TextStyles.label),
            Widgets.field(
              controller: emailController,
              hint: 'Enter your email address',
              icon: Icon(Icons.email_sharp,color: AppColors.label,),
            ),
            Spacer(flex: 1,),
            Text('Password', style: TextStyles.label),
            Widgets.passwordField(
              passwordController: passwordController,
              obscurePassword: _obscurePassword,
              func: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            Spacer(flex: 1,),
            Text('Confirm password', style: TextStyles.label),
            Widgets.passwordField(
              passwordController: confirmController,
              obscurePassword: _obscureConfirmPassword,
              func: () {
                setState(() =>
                _obscureConfirmPassword = !_obscureConfirmPassword);
              },
            ),
            Spacer(flex: 10,),
            Widgets.button(
                text: 'Continue',
                func: (){
                },
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
