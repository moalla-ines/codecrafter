import 'package:codecrafter/app/modules/inscription/views/inscription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';



class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF735DA5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              Icon(Icons.lock, size: 150, color: Colors.white),
              SizedBox(height: 70),
              Text(
                "Welcome back you've been missed",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey.shade50, fontSize: 10),
                  ),
                  controller: controller.emailController,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controller.passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey.shade50, fontSize: 10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: controller.onSubmitLoginForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                ),
                child: const Text('Send', style: TextStyle(color: Colors.black54)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => InscriptionView());
                },
                child: Text(
                  'New User? Create Account',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
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
