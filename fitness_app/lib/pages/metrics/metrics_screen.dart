import 'package:fitness_app/pages/metrics/widgets/body_weight_page.dart';
import 'package:fitness_app/pages/metrics/widgets/metric_card.dart';
import 'package:fitness_app/roots/app_roots.dart';
import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Metrics',
          style: AppTextStyle.bold16white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.1,
          children: [
            MetricCard(
              title: "Body weight",
              subtitle: "Input weight weekly to track progress.",
              iconPath: AppAssets.body_weight,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoots.boywheight);
              },
            ),
            MetricCard(
              title: "Calories burned",
              subtitle: "Based on distance and weight.",
              iconPath: AppAssets.body_weight,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoots.caloriesScreen);
              },
            ),
            MetricCard(
              title: "Goals",
              subtitle: "List of all goals created.",
              iconPath: AppAssets.gols,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoots.golsScreen);
              },
            ),
            MetricCard(
                title: "T.U.T",
                subtitle: "Time under tension.",
                iconPath: AppAssets.time_training,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoots.timeTensionScreen);
                }),
            MetricCard(
              title: "Form tracking",
              subtitle: "Track your form and technique.",
              iconPath: AppAssets.tracing,
              // comingSoon: false,
              onTap: () {
               
                Navigator.of(context).pushNamed(AppRoots.formScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
