import 'package:codecrafter/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inscription_controller.dart';

class InscriptionView extends GetView<InscriptionController> {

  InscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF735DA5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                height: 50,
                color: const Color(0xFFF735DA5),
                child: Center(
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey.shade400,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.all(50),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.username.value = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                            hintText: "Enter your username",
                            hintStyle: const TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          validator: controller.validateUsername,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.password.value = value,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          validator: controller.validatePassword,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.email.value = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            hintText: "Enter your Email",
                            hintStyle: const TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          validator: controller.validateEmail,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                        ),
                        onPressed: controller.submitForm,
                        child: const Text('Submit'),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginView()); // Use inscriptionViewKey
                        },
                        child: Text(
                          'You already have an account? Click here',
                          style: TextStyle(
                            color: const Color(0xFFF735DA5),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

