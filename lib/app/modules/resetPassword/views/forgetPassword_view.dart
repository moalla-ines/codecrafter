import 'package:codecrafter/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgetPassword_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C4E80),
      appBar: AppBar(
        title: Text(
          'Réinitialisation du mot de passe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF2C4E80),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.to(LoginView());
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Color(0xFFFF1F1F2),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: (value) {
                      controller.emailController.text = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF2C4E80),
                        ),
                      ),
                      labelText: "E-mail",
                      labelStyle:
                          TextStyle(color: Color(0xFFF2C4E80), fontSize: 15),
                      hintText: "Entrer votre E-mail",
                      hintStyle: const TextStyle(
                          color: Color(0xFFF2C4E80), fontSize: 12),
                    ),
                    validator: controller.validateEmail,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.resetPassword();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 15)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Réinitialiser',
                    style: TextStyle(color: Color(0xFFF2C4E80)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showCodeDialog(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 15)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Saisir le code',
                    style: TextStyle(color: Color(0xFFF2C4E80)),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  void _showCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade50,
          title: Text('Saisir le code'),
          content: TextFormField(
            controller: controller.codeController,
            decoration: InputDecoration(
              hintText: 'Entrez le code reçu par email',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String code = controller.codeController.text.trim();
                controller.verifyCodeAndNavigate(code);
                Get.back(); // Fermer la boîte de dialogue
              },
              child:
                  Text('Valider', style: TextStyle(color: Color(0xFFF2C4E80))),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Fermer la boîte de dialogue sans vérifier le code
              },
              child:
                  Text('Annuler', style: TextStyle(color: Color(0xFFF2C4E80))),
            ),
          ],
        );
      },
    );
  }
}
