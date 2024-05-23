import 'package:codecrafter/app/modules/resetPassword/controllers/forgetPassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    final token = Get.arguments;
    controller.token.value = token;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Changement du mot de passe',
          style: TextStyle(color: Colors.white), // Couleur du texte de l'appBar
        ),
        backgroundColor: const Color(0xFFF2C4E80),
        centerTitle: true,
        // Couleur de l'appBar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color(0xFFFF1F1F2),
              padding: const EdgeInsets.all(10),
              child: Obx(() => TextFormField(
                    onChanged: (value) => controller.password.value = value,
                    keyboardType: TextInputType.text,
                    obscureText: !controller.isPasswordVisible.value,
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
                      labelText: "Mot de Passe",
                      labelStyle:
                          TextStyle(color: Color(0xFFF2C4E80), fontSize: 15),
                      hintText: "Entrer votre Mot de Passe",
                      hintStyle: const TextStyle(
                          color: Color(0xFFF2C4E80), fontSize: 12),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFFF2C4E80),
                        ),
                        onPressed: () {
                          controller.isPasswordVisible.value =
                              !controller.isPasswordVisible.value;
                        },
                      ),
                    ),
                    validator: (value) => controller.validatePassword(value),
                  )),
            ),
            SizedBox(height: 10),
            Container(
              color: Color(0xFFFF1F1F2),
              padding: const EdgeInsets.all(10),
              child: Obx(() => TextFormField(
                    onChanged: (value) =>
                        controller.confirmPassword.value = value,
                    keyboardType: TextInputType.text,
                    obscureText: !controller.isConfirmPasswordVisible.value,
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
                      labelText: "Confirmer le Mot de Passe",
                      labelStyle:
                          TextStyle(color: Color(0xFFF2C4E80), fontSize: 15),
                      hintText: "Re-Entrer votre Mot de Passe",
                      hintStyle: const TextStyle(
                          color: Color(0xFFF2C4E80), fontSize: 12),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFFF2C4E80),
                        ),
                        onPressed: () {
                          controller.isConfirmPasswordVisible.value =
                              !controller.isConfirmPasswordVisible.value;
                        },
                      ),
                    ),
                    validator: (value) => controller.validateVerPassword(
                        value, controller.password.value),
                  )),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (controller.confirmPassword.value.isNotEmpty &&
                    controller.validateVerPassword(
                            controller.confirmPassword.value,
                            controller.password.value) ==
                        null) {
                  print(token);
                  await controller.changePassword();
                } else {
                  Get.snackbar('Erreur', 'Veuillez vérifier les champs.');
                }
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
