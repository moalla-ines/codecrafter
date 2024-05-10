import 'package:codecrafter/app/modules/inscription/views/inscription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: const Color(0xFFFc19ee0),
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
                    } else {
                      Get.snackbar('Error', 'Please fill in all fields');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200), // Utilisation d'une couleur plus contrastée
                  ),
                  child: const Text('Send', style: TextStyle(color: Color(0xFFF735DA5))),
                ),

                // Utilisation de Get.toNamed pour la création de compte
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/inscription'); // Assurez-vous d'avoir configuré cette route dans votre application
                  },
                  child: Text(
                    'New User? Create Account',
                    style: const TextStyle(
                      color: const Color(0xFFF735DA5),
                      decoration: TextDecoration.underline,
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
