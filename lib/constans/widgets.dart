import 'package:final_project/constans/colors.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:flutter/material.dart';

class Widgets {
  static Widget mainBackgroundDecoration (Widget widget){
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.grey,
              AppColors.black, // top dark// bottom darker
            ],
          ),
        ),
        child: widget,
    );
  }

  static Widget button ({required String text, required Function func}){
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // transparent button
          shadowColor: Colors.transparent,     // remove default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => func(),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  static Widget field ({required controller, required String hint, required Icon icon}){
    return Container(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyles.label,
          hintText: hint,
          hintStyle: TextStyles.label,
          prefixIcon: icon,
          filled: true,
          fillColor: AppColors.field, // background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
  static Widget passwordField (
      {required passwordController, required obscurePassword, required func}){
    return Container(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        controller: passwordController,
        obscureText: obscurePassword,
        decoration: InputDecoration(
          labelStyle: TextStyles.label,
          hintText: "Enter password",
          hintStyle: TextStyles.label,
          prefixIcon: const Icon(Icons.lock_rounded,color: AppColors.label,),
          suffixIcon: IconButton(
            icon: Icon(
              color: AppColors.label,
              obscurePassword ? Icons.visibility_off_sharp : Icons.visibility,
            ),
            onPressed: (){
              func();
            },
          ),
          filled: true,
          fillColor: AppColors.field,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
  static Widget forgotPassword (){
    return Text(
      "Forgot password?",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xffC6C6C6),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xffC6C6C6),
        decorationThickness: 2,
      ),
    );
  }

  static Widget dropdownLikeField({
    required String text,
    Function()? onTap,
    IconData icon = Icons.keyboard_arrow_down_rounded,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.field, // نفس لون الخلفية للـ TextField
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyles.smallText.copyWith(
                color: text == 'Select a date' ||
                    text == 'Select a location' ||
                    text == 'Select city in your location'
                    ? Colors.grey.shade500
                    : AppColors.white,
              ),
            ),
            Icon(
              icon,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  static Widget pageView(context,String text,String num,){
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(32)
                ),
                child: Center(child: Text(num,style: TextStyle(color: Colors.white),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyles.label.copyWith(color: Colors.white,fontSize: 12),),
              ),
            ],
          ),
          Container(
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ],
      ),
    );
  }

}