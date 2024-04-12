import 'package:codecrafter/app/model/model_questions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController> {
   QuestionView({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuestionView'),
        centerTitle: true,
      ),
      body:Container(
        alignment: Alignment.center,

      ),
    );
  }
}
