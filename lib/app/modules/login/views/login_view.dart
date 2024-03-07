import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/inscription/views/inscription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF735DA5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              const Icon(Icons.lock, size: 150,color: Colors.white,),
              const SizedBox(height:70),
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
                    labelText: "UserName",
                    labelStyle: TextStyle(color: Colors.white),
                hintText: "Entrer votre nom ",
                      hintStyle: TextStyle(color: Colors.grey.shade50,fontSize: 10)
                  ),
                  controller: controller.usernameController,
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
                    hintText: "Entrer votre mot de passe ",
                    hintStyle: TextStyle(color: Colors.grey.shade50,fontSize: 10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: ()
                {
                  if (controller.usernameController.text.isNotEmpty &&
                      controller.passwordController.text.isNotEmpty) {
                    // Perform login logic here
                    Get.to(() => HomeView());
                  } else {
                    Get.snackbar('Erreur', 'Veuillez remplir tous les champs.');
                  }
                },
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                ),
                child: const Text('envoyer',style: TextStyle(color: Colors.black54),),
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
