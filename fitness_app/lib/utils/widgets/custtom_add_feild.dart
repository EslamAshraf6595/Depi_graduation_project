import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custtom_add_feild extends StatelessWidget {
  Custtom_add_feild({
    super.key,
    required this.value,
  });
  String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.darkColor,
        border: Border.all(color: AppColors.primeOrange),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: AppTextStyle.meduim14white.copyWith(fontSize: 12.sp),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: AppColors.white,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: BorderSide(
                          color: AppColors.darkOrange, width: 1.5.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: BorderSide(
                          color: AppColors.darkOrange, width: 1.5.w))),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton(
            icon: Icon(Icons.add, color: AppColors.primeOrange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
