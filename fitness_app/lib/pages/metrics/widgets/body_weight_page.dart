import 'package:fitness_app/provider/workout_provider.dart';
import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/widgets/custtom_add_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class BodyWeightScreen extends StatefulWidget {
  const BodyWeightScreen({Key? key}) : super(key: key);

  @override
  State<BodyWeightScreen> createState() => _BodyWeightScreenState();
}

class _BodyWeightScreenState extends State<BodyWeightScreen> {
  final TextEditingController weightController = TextEditingController();
  List<double> weeklyWeights = [];
  double goalWeight = 120.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Body weight", style: AppTextStyle.bold20white),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.darkColor,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Weekly weight log',
              style: AppTextStyle.meduim16white,
            ),
            SizedBox(height: 10.h),
            Custtom_add_feild(
              value: "Add new weight",
              controller: weightController,
              onAdd: () {
                if (weightController.text.isNotEmpty) {
                  double weight = double.tryParse(weightController.text) ?? 0.0;
                  if (weight > 0) {
                    setState(() {
                      weeklyWeights.add(weight);
                    });
                    weightController.clear();
                  }
                }
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: weeklyWeights.isEmpty
                  ? const Center(
                      child: Text(
                        "No weights added yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: weeklyWeights.length,
                      itemBuilder: (context, index) {
                        return _buildWeightLog(
                          "Week ${weeklyWeights.length - index}",
                          "${weeklyWeights[index]}kg",
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownYear() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primeOrange),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Text("2023", style: AppTextStyle.meduim16white),
          Icon(Icons.arrow_drop_down, color: AppColors.white),
        ],
      ),
    );
  }

  Widget _buildCalendarIcon() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primeOrange),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ImageIcon(
        AssetImage(AppAssets.calendar),
        color: AppColors.primeOrange,
      ),
    );
  }

  Widget _buildGoalCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.darkOrange,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Weight goal:", style: AppTextStyle.meduim12grey),
              Text("${goalWeight.toInt()}kg", style: AppTextStyle.bold16white),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Time left to goal:", style: AppTextStyle.meduim12grey),
              Text("10/9/2023", style: AppTextStyle.bold16white),
            ],
          ),
          Icon(Icons.edit, color: AppColors.primeOrange),
        ],
      ),
    );
  }

  Widget _buildWeightLog(String week, String weight) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.darkColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$week", style: AppTextStyle.meduim16white),
          Text("$weight", style: AppTextStyle.meduim16white),
          Icon(Icons.edit, color: AppColors.primeOrange),
        ],
      ),
    );
  }
}
