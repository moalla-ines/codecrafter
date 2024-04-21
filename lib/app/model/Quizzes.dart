
import 'package:codecrafter/app/model/model_niveau.dart';



class Quizzes {
  int? id;
  String? titreQuiz;
  String? description;
  int? nbQuestions;
  Niveau? niveau;
  Categorie? categorie;
  List<dynamic>? questions;

  Quizzes({
    this.id,
    this.titreQuiz,
    this.description,
    this.nbQuestions,
    this.niveau,
    this.categorie,
    this.questions,
  });

  Quizzes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titreQuiz = json['titre_quiz'];
    description = json['description'];
    nbQuestions = json['nb_questions'];
    niveau = json['niveau'] != null ? new Niveau.fromJson(json['niveau']) : null;
    categorie = json['categorie'] != null ? new Categorie.fromJson(json['categorie']) : null;
    if (json['questions'] != null) {
      questions = <dynamic>[];
      json['questions'].forEach((v) {
        questions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titre_quiz'] = this.titreQuiz;
    data['description'] = this.description;
    data['nb_questions'] = this.nbQuestions;
    if (this.niveau != null) {
      data['niveau'] = this.niveau!.toJson();
    }
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!;
    }
    return data;
  }
}




