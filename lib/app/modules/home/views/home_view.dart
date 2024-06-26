import 'package:codecrafter/app/modules/gestions/views/gestion_categorie.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';
import '../../niveau/controllers/niveau_controller.dart' as niveau_controller;
import '../../gestions/views/gestions_view.dart';
import '../../niveau/views/niveau_view.dart';
import '../../profile/views/profile_view.dart';

class HomeView extends GetView<HomeController> {
  final int? id;
  final String? role;
  final int? score;
  final int? categorie;

  HomeView({this.id, this.role, this.score, this.categorie});

  final List<String> images = [
    "assets/images/Angular.png",
    "assets/images/C++.png",
    "assets/images/Laravel.png",
    "assets/images/flutter.png",
    "assets/images/java.png",
    "assets/images/js.png",
    "assets/images/Python-logo.png",
    "assets/images/react.png"
  ];

  final List<String> languages = [
    "Angular",
    "C++",
    "Laravel",
    "Flutter",
    "Java",
    "JavaScript",
    "Python",
    "React",
  ];

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    controller.role = role;
    return Scaffold(
      backgroundColor: Color(0xFFFF1F1F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2C4E80),
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFF1F1F2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF1F1F2),
              ),
              child: SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Gestionnaire',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Utilisateur'),
                onTap: () {
                  Get.off(() => ProfileView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Quizs'),
                onTap: () {
                  Get.off(() => GestionsView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Categorie'),
                onTap: () {
                  Get.off(() => GestionCategorieView(role: role, id: id));
                },
              ),

            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Profile'),
                onTap: () {
                  Get.off(() => SettingsView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Historique'),
                onTap: () {
                  Get.off(() => HistoriqueView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Prendre Quiz'),
                onTap: () {
                  Get.off(() => HomeView(role: role, id: id));
                },
              ),
            if (controller.role != "admin")
              ListTile(
                title: Text('Gestion Profile'),
                onTap: () {
                  Get.off(() => SettingsView(role: role, id: id));
                },
              ),

            if (controller.role != "admin")
              ListTile(
                title: Text('Historique'),
                onTap: () {
                  Get.off(() => HistoriqueView(role: role, id: id));
                },
              ),
            if (controller.role != "admin")
              ListTile(
                title: Text('Prendre Quiz'),
                onTap: () {
                  Get.off(() => HomeView(role: role, id: id));
                },
              ),
          ],
        ),
      ),
      body: _buildGridView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 9.0,
        mainAxisSpacing: 9.0,
        childAspectRatio: 0.8,
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGridTile(index);
      },
    );
  }

  Widget _buildGridTile(int index) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          String imageUrl = images[index];
         Get.to(() => NiveauView(imageUrl: imageUrl, index: index + 1, role: role, id: id));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFF1F1F2),
            border: Border.all(
              color: Colors.white, // Couleur de la bordure blanche
              width: 0.0, // Épaisseur de la bordure
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languages[index],
                  style: TextStyle(
                    color: Color(0xFFF2C4E80),
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  images[index], // Utilisez Image.asset pour charger des images depuis les ressources
                  width: 170.0,
                  height: 170.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
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

