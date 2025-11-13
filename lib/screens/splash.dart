import 'package:final_project/constans/classes.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:final_project/constans/widgets.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  static String routeName = 'splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..forward();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );

    Future.delayed(const Duration(milliseconds: 2500), () {
      _textController.forward();
    });

    Future.delayed(const Duration(milliseconds: 3900), () {
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Widgets.mainBackgroundDecoration(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3,),

              // Logo Animation
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _logoController,
                  curve: Curves.elasticOut,
                ),
                child: Image.asset(Paths.logoPath, scale: .7),
              ),

              const SizedBox(height: 20),

              // Text Animation
              FadeTransition(
                opacity: _textController,
                child: Column(
                  children: [
                    Text('Helios Sports Tech', style: TextStyles.bigText),
                    Text('Here To Compete.', style: TextStyles.smallText),
                  ],
                ),
              ),

              const Spacer(flex: 6,),

              // Button Animation (slide from bottom)
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _buttonController,
                  curve: Curves.easeOut,
                )),
                child: Widgets.button(
                  text: "Get started",
                  func: (){
                    Navigator.pushNamed(context, 'login');
                  }
                ),
              ),

              const Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}