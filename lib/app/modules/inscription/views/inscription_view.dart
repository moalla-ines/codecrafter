import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/inscription_controller.dart';

class InscriptionView extends GetView<InscriptionController> {
  const InscriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InscriptionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InscriptionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
