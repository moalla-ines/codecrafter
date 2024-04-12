import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inscription_controller.dart';

class InscriptionView extends StatelessWidget {
  final InscriptionController controller = Get.put(InscriptionController());

  InscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (value) => controller.username.value = value,
                  decoration: InputDecoration(
                    labelText: "User Name",
                  ),
                ),
                TextFormField(
                  onChanged: (value) => controller.password.value = value,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),

                TextFormField(
                  onChanged: (value) => controller.email.value = value,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.submitForm,
                  child: const Text('Submit'),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
