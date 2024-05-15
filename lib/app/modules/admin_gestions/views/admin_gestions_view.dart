import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_gestions_controller.dart';

class AdminGestionsView extends GetView<AdminGestionsController> {
  final int? id;
  final String? role;
  final int? score;
   AdminGestionsView({this.id, this.role, this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2C4E80),
      appBar: AppBar(
        title: Text(
          'Gestions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF2C4E80),
      ),
      body: const Center(
        child: Text(
          'AdminGestionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
