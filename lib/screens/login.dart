import 'package:final_project/constans/classes.dart';
import 'package:final_project/constans/colors.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:final_project/constans/widgets.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Widgets.mainBackgroundDecoration(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  Paths.logoPath,
                  scale: 2,
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: Text(
                      'Login to your Account',
                      style: TextStyles.titles,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Email',
                    style: TextStyles.label,
                  ),
                ),
                Widgets.field(
                    controller: emailController,
                    hint: 'Enter your email address',
                  icon: Icon(Icons.email_sharp,color: AppColors.label,),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Password',
                    style: TextStyles.label,
                  ),
                ),
                Widgets.passwordField(
                  passwordController: passwordController,
                  obscurePassword: _obscurePassword,
                  func: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Widgets.forgotPassword(),
                ),
                Spacer(
                  flex: 3,
                ),
                Widgets.button(text: 'Login', func: () {}),
                Spacer(
                  flex: 1,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,'createAccountSlider');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style:
                            TextStyles.smallText.copyWith(color: AppColors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyles.smallText.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Alternatively Login with:',
                      style: TextStyles.label.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                OutlineButton(
                  imagePath: 'assets/apple.png',
                  text: 'APPLE ID',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 8,
                ),
                OutlineButton(
                  imagePath: 'assets/google.png',
                  text: 'GOOGLE',
                  onPressed: () {},
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}