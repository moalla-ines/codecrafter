import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:codecrafter/app/model/Quizzes.dart';
import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  final String? imageUrl;
  final int? niveau;
  final int? categorie;
  final int? idquiz;
  int get index => categorie! -1;
  String? role;
  int? id;
  QuizView(
      {this.imageUrl,
        this.niveau,
        this.categorie,
        this.idquiz,
        this.role,
        this.id,});

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

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    controller.role = role;
    controller.id = id;
    print(niveau);
    return Scaffold(
      backgroundColor: const Color(0xFFFe4c1f9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFc19ee0),
        title: const Text(
          'Quiz List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back ,color: Colors.white),
          onPressed: () {
            controller.quiz = [].obs;
            Get.back();
          },
        ),
        actions: controller.role == "admin"
            ? [
          IconButton(
            icon: const Icon(Icons.add ,color: Colors.white),
            onPressed: () {
              if (niveau != null && categorie != null) {
                _showCreateQuizDialog(context);
              } else {
                Get.snackbar('Erreur', 'Niveau ou catégorie est null');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete ,color: Colors.white),
            onPressed: () {
              for (var idquiz in controller.selectedQuizzes) {
                controller.onDeleteQuiz(idquiz);
              }
              controller.selectedQuizzes.clear();
              Get.snackbar('Succès', 'Quiz supprimé avec succès !');
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit ,color: Colors.white),
            onPressed: () {
              if (controller.selectedQuizzes.isNotEmpty) {
                var idquiz = controller.selectedQuizzes.first;
                var quizToUpdate = controller.quiz.firstWhere(
                        (quiz) => quiz.idquiz == idquiz,
                    orElse: () => null);
                if (quizToUpdate != null) {
                  _showCreateQuizDialog(context,
                      isUpdate: true,
                      quiz: quizToUpdate,
                      idquiz: quizToUpdate.idquiz);
                } else {
                  Get.snackbar(
                      'Erreur', 'Le quiz à modifier n\'a pas été trouvé');
                }
              } else {
                Get.snackbar('Erreur',
                    'Aucun quiz sélectionné pour la modification');
              }
            },
          ),
        ]
            : null,
      ),
      body: Obx(() {
        if (controller.quiz.isEmpty) {
          if (niveau != null) {
            controller.fetchQuizzesByNiveau(niveau!);
          }
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var quiz in controller.quiz)
                      buildQuizTile(
                        context,
                        quiz.idquiz.toString(),
                        quiz.titreQuiz ?? '',
                        quiz.description ?? '',

                        Colors.grey.shade100,
                        SizedBox(height: 2),
                        Container(padding: const EdgeInsets.all(3)),
                        images[index],
                        quiz,
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget buildQuizTile(
      BuildContext context,
      String tag,
      String title,
      String subtitle,
      Color tileColor,
      Widget? sizedBox,
      Widget? container,
      String? imageUrl,
      Quiz quiz,
      ) {
    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(imageUrl, width: 40, height: 40)
                  : const Icon(Icons.image),
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(
                        () => QuestionView(quiz: quiz.idquiz, id: id, role: role));
              },
            ),
          ),
        ),
        if (controller.role == "admin")
          CheckboxListTile(

            tileColor: tileColor,
            value: controller.selectedQuizzes.contains(quiz.idquiz),
            onChanged: (value) {
              if (value != null && value) {
                controller.toggleQuizSelection(quiz.idquiz ?? 0);
              }
            },
          ),
      ],
    );
  }

  final TextEditingController titleQuizController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nbQuestionsController = TextEditingController();

  void _showCreateQuizDialog(BuildContext context,
      {bool isUpdate = false, Quiz? quiz, int? idquiz}) {
    if (isUpdate && quiz != null) {
      // Mettre à jour les contrôleurs avec les données du quiz existant
      titleQuizController.text = quiz.titreQuiz ?? '';
      descriptionController.text = quiz.description ?? '';
      nbQuestionsController.text = quiz.nbQuestions?.toString() ?? '';
    } else {
      // Réinitialiser les contrôleurs s'il s'agit d'une création de nouveau quiz
      titleQuizController.text = '';
      descriptionController.text = '';
      nbQuestionsController.text = '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Modifier le quiz' : 'Créer un nouveau quiz'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleQuizController,
              decoration: InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: nbQuestionsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nombre de questions'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              int? nbQuestions = int.tryParse(nbQuestionsController.text);
              if (nbQuestions != null) {
                if (niveau != null && categorie != null) {
                  if (isUpdate) {
                    controller.onUpdateQuiz(
                      idquiz!, // Utilisez quiz.idquiz au lieu de quiz.id
                      titleQuizController.text,
                      descriptionController.text,
                      nbQuestions,
                      niveau,
                      categorie,
                    );

                    Get.back();
                  } else {
                    // Créer un nouveau quiz
                    controller.onCreateQuizzes(
                        titleQuizController.text,
                        descriptionController.text,
                        nbQuestions,
                        niveau,
                        categorie);
                    Navigator.pop(context);
                  }
                } else {
                  print('Niveau ou catégorie est null');
                }
              }
            },
            child: Text(isUpdate ? 'Modifier' : 'Créer'),
          ),
        ],
      ),
    );
  }
}
