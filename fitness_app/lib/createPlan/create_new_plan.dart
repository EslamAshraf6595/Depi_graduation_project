import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateNewPlan extends StatelessWidget {
  const CreateNewPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create_new_plan".tr()),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Create New Plan Screen"),
      ),
    );
  }
}