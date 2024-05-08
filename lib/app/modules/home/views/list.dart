import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/modules/home/controllers/home_controller.dart';

class ListViewPage extends GetView<HomeController> {
  ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.role == "admin") {
      controller.getAllQuizHistories();
    } else {
      controller.fetchQuizHistoriesByUser(controller.id);
    }

    return Scaffold(
      backgroundColor: Color(0xFFFD3C5E5),
      appBar: AppBar(
        title: Text('Historique',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF735DA5),
      ),
      body: Obx(() =>
          ListView.builder(
            itemCount: controller.quizHistory.length,
            itemBuilder: (context, index) {
              final history = controller.quizHistory[index];
              return _buildExpansionTile(
                context,
                controller.role == "admin"
                    ? "QuizHistory of ${history.user!.email}"
                    : "My Quizzes",
                Colors.grey.shade100,
                history,
              );
            },
          )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildBottomNavigationBar() {
    return Obx(() =>
        GNav(
          backgroundColor: Color(0xFFF735DA5),
          color: Colors.white,
          activeColor: Color(0xFFF735DA5),
          tabBackgroundColor: Colors.grey.shade50,
          padding: EdgeInsets.all(20),
          gap: 8,
          selectedIndex: controller.selectedIndex.value,
          onTabChange: controller.onItemTapped,
          tabs: [
            GButton(icon: Icons.settings, text: 'Settings'),
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.list, text: 'List'),
          ],
        ));
  }

  Widget _buildExpansionTile(BuildContext context, String title, Color color,
      QuizHistory history) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFFF735DA5),
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      children: controller.role == "user"
          ? [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${history.quiz?.niveau?.name ?? "Unknown"}'),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Unknown"}'),
              Text('Score: ${history.result} %'),
            ],
          ),
        ),
      ]
          : [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${history.user!.username}'),
              Text('Niveau: ${history.quiz?.niveau?.name ?? "Unknown"}'),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Unknown"}'),
              Text('Score: ${history.result}'),
            ],
          ),
        ),
      ],
    );
  }
}