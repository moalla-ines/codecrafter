import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/inscription/views/inscription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  final GlobalKey<NavigatorState> loginViewKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> inscriptionViewKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF735DA5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              const Icon(Icons.lock, size: 150, color: Colors.white),
              const SizedBox(height: 70),
              Text(
                "Welcome back you've been missed",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  controller: controller.emailController,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: controller.passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (controller.emailController.text.isNotEmpty &&
                      controller.passwordController.text.isNotEmpty) {
                    controller.onSubmitLoginForm();
                    Get.to(() => HomeView(key: loginViewKey));
                  } else {
                    Get.snackbar('Error', 'Please fill in all fields');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                ),
                child: const Text('Send', style: TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => InscriptionView(key: inscriptionViewKey)); // Use inscriptionViewKey
                },
                child: Text(
                  'New User? Create Account',
                  style: const TextStyle(
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
