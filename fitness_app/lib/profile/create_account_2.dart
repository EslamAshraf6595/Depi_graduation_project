import 'package:fitness_app/constans/text_styles.dart';
import 'package:fitness_app/constans/widgets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class CreateAccount2 extends StatefulWidget {
  static String routeName = 'createAccount2';

  @override
  State<CreateAccount2> createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateController = TextEditingController();
  final locationController = TextEditingController();
  final cityController = TextEditingController();

  void _createAccount() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        dateController.text.isEmpty ||
        locationController.text.isEmpty ||
        cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    Provider.of<UserProvider>(context, listen: false).saveBiodata(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      dateOfBirth: dateController.text.trim(),
      location: locationController.text.trim(),
      city: cityController.text.trim(),
    );

    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.4;

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),

            Row(
              children: [
                SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First name', style: TextStyles.label),
                      Widgets.field(
                        controller: firstNameController,
                        hint: 'E.g John',
                        icon: Icon(Icons.person, color: AppColors.primeOrange),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last name', style: TextStyles.label),
                      Widgets.field(
                        controller: lastNameController,
                        hint: 'E.g Appleseed',
                        icon: Icon(Icons.person, color: AppColors.primeOrange),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Spacer(),

            Text('Date of Birth', style: TextStyles.label),
            Widgets.field(
              controller: dateController,
              hint: 'Select a date',
              icon: Icon(Icons.calendar_today, color: AppColors.primeOrange),
            ),
            Spacer(),

            Text('Location', style: TextStyles.label),
            Widgets.field(
              controller: locationController,
              hint: 'Select a location',
              icon: Icon(Icons.location_on, color: AppColors.primeOrange),
            ),
            Spacer(),

            Text('City', style: TextStyles.label),
            Widgets.field(
              controller: cityController,
              hint: 'Select city in your location',
              icon: Icon(Icons.location_city, color: AppColors.primeOrange),
            ),

            Spacer(flex: 3),

            Widgets.button(text: 'Create your account', func: _createAccount),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
