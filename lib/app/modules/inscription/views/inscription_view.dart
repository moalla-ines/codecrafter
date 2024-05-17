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
                    "Inscription",
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
                        color: Color(0xFFFF1F1F2),
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.username.value = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // Couleur de fond blanche pour le champ de texte
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure par défaut
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure lorsque le champ est activé
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF2C4E80),), // Bordure bleue lorsque le champ est en focus
                            ),
                            labelText: "Prénom",
                            labelStyle:  TextStyle(color:  Color(0xFFF2C4E80), fontSize: 15),
                            hintText: "Entrer votre Prénom",
                            hintStyle: const TextStyle(color:  Color(0xFFF2C4E80), fontSize: 12),
                          ),
                          validator: controller.validateUsername,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        color: Color(0xFFFF1F1F2),
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.password.value = value,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // Couleur de fond blanche pour le champ de texte
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure par défaut
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure lorsque le champ est activé
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF2C4E80),), // Bordure bleue lorsque le champ est en focus
                            ),
                            labelText: "Mot de Passe ",
                            labelStyle:  TextStyle(color:  Color(0xFFF2C4E80), fontSize: 15),
                            hintText: "Entrer votre Mot de Passe",
                            hintStyle: const TextStyle(color:  Color(0xFFF2C4E80), fontSize: 12),
                          ),
                          validator: controller.validatePassword,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        color: Color(0xFFFF1F1F2),
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) => controller.email.value = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // Couleur de fond blanche pour le champ de texte
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure par défaut
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none, // Aucune bordure lorsque le champ est activé
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF2C4E80),), // Bordure bleue lorsque le champ est en focus
                            ),
                            labelText: "E-mail",
                            labelStyle:  TextStyle(color:  Color(0xFFF2C4E80), fontSize: 15),
                            hintText: "Entrer votre E-mail",
                            hintStyle: const TextStyle(color:  Color(0xFFF2C4E80), fontSize: 12),
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
                        child: const Text('Envoyer ' ,style: TextStyle(color: Color(0xFFF2C4E80))),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginView());
                        },
                        child: Text(
                          'Vous avez déjà un compte ? Appuyez ici. ',
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
