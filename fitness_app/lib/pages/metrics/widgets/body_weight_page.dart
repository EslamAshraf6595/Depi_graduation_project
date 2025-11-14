import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/widgets/custtom_add_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';

class BodyWeightScreen extends StatelessWidget {
  const BodyWeightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> weights = [180, 120, 150, 175, 130, 110, 140, 125, 160];
    double goalWeight = 120;

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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primeOrange),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ImageIcon(
                    AssetImage(
                      AppAssets.calendar,
                    ),
                    color: AppColors.primeOrange,
                  ),
                ),
              ],
            ),

            /// Chart
            // SizedBox(
            //   height: 250.h,
            //   child: BarChart(
            //     BarChartData(
            //       alignment: BarChartAlignment.spaceAround,
            //       barTouchData: BarTouchData(
            //         enabled: true,
            //         touchTooltipData: BarTouchTooltipData(
            //          // tooltipBgColor: Colors.black87,
            //           getTooltipItem: (group, groupIndex, rod, rodIndex) {
            //             return BarTooltipItem(
            //               "${rod.toY.toInt()} kg",
            //               TextStyle(color: Colors.white),
            //             );
            //           },
            //         ),
            //       ),
            //       titlesData: FlTitlesData(
            //         leftTitles: AxisTitles(
            //           sideTitles: SideTitles(showTitles: true, reservedSize: 28),
            //         ),
            //         rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            //         topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            //         bottomTitles: AxisTitles(
            //           sideTitles: SideTitles(
            //             showTitles: true,
            //             getTitlesWidget: (value, meta) {
            //               return Text("W${value.toInt() + 1}",
            //                   style: TextStyle(color: Colors.white, fontSize: 10.sp));
            //             },
            //           ),
            //         ),
            //       ),
            //       gridData: FlGridData(show: false),
            //       borderData: FlBorderData(show: false),
            //       barGroups: List.generate(weights.length, (index) {
            //         return BarChartGroupData(
            //           x: index,
            //           barRods: [
            //             BarChartRodData(
            //               toY: weights[index],
            //               color: AppColors.primeOrange,
            //               width: 14.w,
            //               borderRadius: BorderRadius.circular(4.r),
            //             ),
            //           ],
            //         );
            //       }),
            //       extraLinesData: ExtraLinesData(
            //         horizontalLines: [
            //           HorizontalLine(
            //             y: goalWeight,
            //             color: Colors.green,
            //             strokeWidth: 2,
            //             dashArray: [5, 5],
            //             label: HorizontalLineLabel(
            //               show: true,
            //               alignment: Alignment.topLeft,
            //               labelResolver: (line) => "Goal: ${goalWeight.toInt()}kg",
            //               style: TextStyle(color: Colors.white, fontSize: 12.sp),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16.h),

            /// Goal info
            Container(
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
                      Text("120kg", style: AppTextStyle.bold16white),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time left to goal:",
                          style: AppTextStyle.meduim12grey),
                      Text("10/9/2023", style: AppTextStyle.bold16white),
                    ],
                  ),
                  Icon(Icons.edit, color: AppColors.primeOrange),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Weekly weight log',
              style: AppTextStyle.meduim16white,
            ),
            SizedBox(height: 10.h),

            /// Add new weight
            Custtom_add_feild(
              value: "Add new weight",
            ),

            SizedBox(height: 16.h),

            /// Weekly log
            Expanded(
              child: ListView(
                children: [
                  _buildWeightLog("Week 9", "130kg"),
                  _buildWeightLog("Week 8", "140kg"),
                  _buildWeightLog("Week 7", "145kg"),
                  _buildWeightLog("Week 6", "150kg"),
                ],
              ),
            ),
          ],
        ),
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
