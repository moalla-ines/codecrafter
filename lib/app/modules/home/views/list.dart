import 'dart:convert';

import 'package:codecrafter/app/modules/gestions/views/gestion_categorie.dart';
import 'package:codecrafter/app/modules/gestions/views/gestions_view.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/modules/home/controllers/home_controller.dart';

import 'settings.dart';

class ListViewPage extends GetView<HomeController> {
  int ? id ;
  String ? role ;
  ListViewPage({Key? key, this.role,this.id});

  @override
  Widget build(BuildContext context) {
    controller.role = role;
    controller.id = id;
    if (controller.role == "admin") {
      controller.getAllQuizHistories();
    } else {
      controller.fetchQuizHistoriesByUser(controller.id);
    }

    return Scaffold(
      backgroundColor: Color(0xFFFF1F1F2),
      appBar: AppBar(
        title: Text('Historique',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF2C4E80),
      ),
      drawer:
      Drawer
        (
        backgroundColor:Color(0xFFFF1F1F2),
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
                title: Text('Gestion Profil'),
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
                title: Text('Gestion Profil'),
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
      body: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        child: Obx(() =>
            ListView.builder(
              itemCount: controller.quizHistory.length,
              itemBuilder: (context, index) {
                final history = controller.quizHistory[index];
                return _buildExpansionTile(
                  context,
                  controller.role == "admin"
                      ? "Historique du quiz de ${history.user!.email}"
                      : "mon quiz numéro ${index +1 }",
                  Color(0xFFF2C4E80),
                  history,
                );
              },
            )),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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

  Widget _buildExpansionTile(BuildContext context, String title, Color color,
      QuizHistory history) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            color: Color(0xFFF2C4E80),
            ),
      ),
      backgroundColor:Colors.grey.shade100,
      children: controller.role == "user"
          ? [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}',style:TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${ utf8.decode(history.quiz!.niveau!.name!.codeUnits)?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Quiz: ${utf8.decode(history.quiz!.titreQuiz!.codeUnits) ?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',style:TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ]
          : [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}',style:TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${history.user!.username}',style:TextStyle(color: Colors.black)),
              Text('Niveau: ${ utf8.decode(history.quiz!.niveau!.name!.codeUnits)?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Quiz: ${utf8.decode(history.quiz!.titreQuiz!.codeUnits) ?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',style:TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}