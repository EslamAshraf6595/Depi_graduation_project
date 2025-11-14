import 'package:flutter/material.dart';
import 'package:final_project/constans/widgets.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:final_project/constans/colors.dart';

class CreateAccount2 extends StatefulWidget {
  CreateAccount2({super.key});
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1,),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('First name', style: TextStyles.label),
                        ],
                      ),
                      Widgets.field(
                        controller: firstNameController,
                        hint: 'E.g John',
                        icon: const Icon(Icons.person, color: AppColors.label),
                      ),
                    ],
                  ),
                ),
               Spacer(flex: 1,),
               Container(
                 width: MediaQuery.of(context).size.width * 0.4,
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Last name', style: TextStyles.label),
                       ],
                     ),
                     Widgets.field(
                       controller: lastNameController,
                       hint: 'E.g Appleseed',
                       icon: const Icon(Icons.person, color: AppColors.label),
                     ),
                   ],
                 ),
               )
              ],
            ),
            Spacer(flex: 1,),
            Text('Date of Birth', style: TextStyles.label),
            Widgets.field(
              controller: dateController,
              hint: 'Select a date',
              icon: const Icon(Icons.calendar_today, color: AppColors.label),
            ),
            Spacer(flex: 1,),
            Text('Location', style: TextStyles.label),
            Widgets.field(
              controller: locationController,
              hint: 'Select a location',
              icon: const Icon(Icons.location_on, color: AppColors.label),
            ),
            Spacer(flex: 1,),
            Text('City', style: TextStyles.label),
            Widgets.field(
              controller: cityController,
              hint: 'Select city in your location',
              icon: const Icon(Icons.location_city, color: AppColors.label),
            ),
            Spacer(flex: 8,),
            Widgets.button(
              text: 'Create your account',
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