import 'package:final_project/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:final_project/constans/colors.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:final_project/constans/widgets.dart';
import 'package:final_project/constans/classes.dart';
import 'create_account_1.dart';
import 'create_account_2.dart';

class CreateAccountSlider extends StatefulWidget {
  const CreateAccountSlider({super.key});
  static String routeName = 'createAccountSlider';

  @override
  State<CreateAccountSlider> createState() => _CreateAccountSliderState();
}

class _CreateAccountSliderState extends State<CreateAccountSlider> {
  final List<Widget> pages = [CreateAccount1(), CreateAccount2(), ProfileScreen()];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Widgets.mainBackgroundDecoration(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Center(child: Image.asset(Paths.logoPath, scale: 2)),
                Spacer(flex: 1,),
                Center(child: Text('Create an Account', style: TextStyles.titles)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Help us finish setting up your account.',
                      style: TextStyles.label.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                Spacer(flex: 1,),
                Row(
                  children: [
                    Widgets.pageView(context, 'Account information','1'),
                    Spacer(flex: 1,),
                    Widgets.pageView(context, 'Biodata information','2'),
                  ],
                ),
                pages[currentPage],
                Spacer(flex: 1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}