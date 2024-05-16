import 'package:codecrafter/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inscription_controller.dart';

class InscriptionView extends GetView<InscriptionController> {
  InscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
    child: Scaffold(
      backgroundColor: const Color(0xFFF2C4E80),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              Container(
                height: 100,
                color: const Color(0xFFF2C4E80),

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
              Container(
                color: Color(0xFFF2C4E80),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
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
                            hintStyle: const TextStyle(color: Colors.white, fontSize: 10),
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
                            hintStyle: const TextStyle(color: Colors.white, fontSize: 10),
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
                            hintStyle: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          validator: controller.validateEmail,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.onRegisterForm();
                          }
                        },
                        child: const Text('Submit' ,style: TextStyle(color: Color(0xFFF2C4E80))),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginView());
                        },
                        child: Text(
                          'You already have an account? Click here',
                          style: TextStyle(
                            color: const  Color(0xFFFF1F1F2),
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
    ),
    );
  }
}
