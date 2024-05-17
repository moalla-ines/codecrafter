import 'package:codecrafter/app/modules/admin_gestions/views/admin_gestions_view.dart';
import 'package:codecrafter/app/modules/gestions/views/gestions_view.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/Quizzes.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/profile/views/profile_view.dart';
import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import '../controllers/gestions_controller.dart';

class GestionCategorieView extends GetView<GestionsController> {
  String? role;
  int? id;
  final String? imageUrl;
  final int? index;

  GestionCategorieView({this.role, this.id, this.imageUrl, this.index});
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
          'Gestion Categorie',
          style: TextStyle(color: Color(0xFFFF1F1F2), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              // Action à effectuer lorsque l'utilisateur appuie sur l'icône "add"
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFF1F1F2),
        child: Column(
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                leading: Image.asset(
                  images[index],
                  width: 40,
                  height: 40,
                ),
                title: Text(languages[index]),
                trailing: Wrap(
                  spacing: 10, // Espace entre les icônes
                  children: [
                    IconButton(
                      iconSize: 18, // Taille réduite des icônes
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Action à effectuer lorsque l'utilisateur appuie sur l'icône "edit"
                      },
                    ),
                    IconButton(
                      iconSize: 18, // Taille réduite des icônes
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Action à effectuer lorsque l'utilisateur appuie sur l'icône "delete"
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Action à effectuer lorsque l'utilisateur appuie sur le ListTile
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
