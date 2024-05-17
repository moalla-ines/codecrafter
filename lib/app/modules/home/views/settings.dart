import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';
import '../../login/controllers/login_controller.dart';

class SettingsView extends GetView<HomeController> {
  final int? id;
  final String? role;

  SettingsView({Key? key, this.role, this.id});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.role = role;
    controller.id = id;
    print(role);
    return Scaffold(
      backgroundColor: const Color(0xFFFF1F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2C4E80),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(

        child: ListView(
          children: <Widget>[
            _buildListTile("Account", Icons.person, () {}),
            const SizedBox(height: 10.0),
            _buildCard(ListTile(
              leading: const Icon(Icons.lock_clock_outlined, color: Color(0xFFF2C4E80)),
              title: const Text("Changer mot de passe"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: controller.changePassword,
            )),
            _buildListTile("Notification Settings", null, () {}),
            _buildSwitchListTile("Réception Notification", true),
            _buildSwitchListTile("Réception offer Notification", true),
            const SizedBox(height: 280),
            _buildListTile("Déconnexion", Icons.logout, () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.grey.shade50,
                    title: Text('Déconnexion'),
                    content: Text('Voulez-vous vraiment vous déconnecter?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Action à effectuer lors de la déconnexion
                          // Par exemple, vous pouvez appeler une méthode de déconnexion dans votre controller
                          loginController.logout();
                          Get.offAllNamed('/login');
                        },
                        child: Text('Déconnexion',style:TextStyle(color: Color(0xFFF2C4E80))),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back(); // Ferme la boîte de dialogue sans déconnecter
                        },
                        child: Text('Annuler',style:TextStyle(color: Color(0xFFF2C4E80))),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildListTile(String title, IconData? icon, VoidCallback onTap) {
    return Card(
      color: Colors.grey.shade100,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, color: Color(0xFFF2C4E80)),
          ),
          trailing: icon != null ? Icon(icon, color: const Color(0xFFF2C4E80)) : null,
        ),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: child,
    );
  }

  Widget _buildSwitchListTile(String title, bool value) {
    return SwitchListTile(
      activeColor: const Color(0xFFF2C4E80),
      contentPadding: const EdgeInsets.all(5),
      value: value,
      title: Text(title),
      onChanged: (val) {
        // Mettre à jour l'état ici si nécessaire
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() =>
        GNav(
          backgroundColor: Color(0xFFF2C4E80),
          color: Colors.white,
          activeColor: Color(0xFFF2C4E80),
          tabBackgroundColor: Colors.grey.shade50,
          padding: EdgeInsets.all(20),
          gap: 8,
          selectedIndex: controller.selectedIndex.value,
          onTabChange: controller.onItemTapped,
          tabs: [
            GButton(icon: Icons.person, text: 'Profile'),
            GButton(icon: Icons.quiz, text: 'Prendre Quiz'),
            GButton(icon: Icons.list, text: 'Liste'),
          ],
        ));
  }
}
