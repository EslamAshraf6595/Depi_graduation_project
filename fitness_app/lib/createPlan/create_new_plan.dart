import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateNewPlan extends StatelessWidget {
  const CreateNewPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create_new_plan".tr(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Create New Plan Screen"),
      ),
    );
  }
}