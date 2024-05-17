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
        backgroundColor: const Color(0xFFF2C4E80) ,
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          color: Color(0xFFF2C4E80),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 150),
                  const Icon(Icons.lock, size: 150, color: Colors.white),
                  const SizedBox(height: 70),
                  Text(
                    "Content de vous revoir, vous nous avez manqué",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: Color(0xFFFF1F1F2),
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
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
                          borderSide: BorderSide(color:  Color(0xFFF2C4E80)), // Bordure bleue lorsque le champ est en focus
                        ),
                        labelText: "E-mail",
                        labelStyle: const TextStyle(color:  Color(0xFFF2C4E80), fontSize: 15), // Couleur du texte du label
                        hintText: "Entrer votre E-mail",
                        hintStyle: const TextStyle(color:  Color(0xFFF2C4E80) ,fontSize: 12), // Couleur du texte du hint
                      ),
                      style: TextStyle(color: Colors.black), // Couleur du texte saisi
                      controller: controller.emailController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Color(0xFFFF1F1F2),
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controller.passwordController,
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
                        labelText: "Mot de Passe",
                        labelStyle: const TextStyle(color:  Color(0xFFF2C4E80),fontSize: 15), // Couleur du texte du label
                        hintText: "Entrer votre Mot de Passe",
                        hintStyle: const TextStyle(color:  Color(0xFFF2C4E80), fontSize: 12), // Couleur du texte du hint
                      ),
                      style: TextStyle(color: Colors.black), // Couleur du texte saisi
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Utilisation d'une couleur plus contrastée
                ),
                child: Text('Envoyer', style: TextStyle(color: Color(0xFFF2C4E80))),
              ),
                  const SizedBox(height: 20),
          // Utilisation de Get.toNamed pour la création de compte
              GestureDetector(
                onTap: () {
                  Get.toNamed('/inscription'); // Assurez-vous d'avoir configuré cette route dans votre application
                },


              child: Text(
                      'Nouvel utilisateur ? Créez un compte.',
                      style: const TextStyle(
                        color:  Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
