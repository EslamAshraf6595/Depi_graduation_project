import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('This is the Calendar Screen'),
      ),
    );
  }
}
