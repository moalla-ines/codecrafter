import 'package:codecrafter/app/model/Quizzes.dart';

class Question {
  int? idquestion;
  String? text;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  int? indiceOptionCorrecte;
  Quizzes? quiz;

  Question({this.idquestion, this.text, this.option1, this.option2, this.option3, this.option4, this.indiceOptionCorrecte, this.quiz});

  Question.fromJson(Map<String, dynamic> json) {
    idquestion = json['idquestion'];
    text = json['text'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    indiceOptionCorrecte = json['indice_optionCorrecte'];
    quiz = json['quiz'] != null ? Quizzes.fromJson(json['quiz']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idquestion'] = this.idquestion;
    data['text'] = this.text;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['indice_optionCorrecte'] = this.indiceOptionCorrecte;
    if (this.quiz != null) {
      data['quiz'] = this.quiz!.toJson();
    }
    return data;
  }
}