
import 'package:codecrafter/app/model/model_niveau.dart';

class Quizzes{
  int? id;
  String? titreQuiz;
  String? description;
  int? nbQuestions;
  Niveau? niveau;

  Quizzes({this.id, this.titreQuiz, this.description, this.nbQuestions, this.niveau});

  Quizzes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titreQuiz = json['titre_quiz'];
    description = json['description'];
    nbQuestions = json['nb_questions'];
    niveau = json['niveau'] != null ? new Niveau.fromJson(json['niveau']) : null;
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
    return data;
  }
}





