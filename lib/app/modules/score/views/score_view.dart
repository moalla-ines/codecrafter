import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/score_controller.dart';

class ScoreView extends GetView<ScoreController> {
  int? totalQuestions;
  int?score ;

 ScoreView({ this.score ,this.totalQuestions});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScoreView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScoreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
