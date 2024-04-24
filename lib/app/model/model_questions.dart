class Question {
  int? idquestion;
  String? text;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  int? selectedOption;
  int? indiceOptionCorrecte;
  Quiz? quiz;

  Question(
      {this.idquestion,
        this.text,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
        this.selectedOption,
        this.indiceOptionCorrecte,
        this.quiz});

  Question.fromJson(Map<String, dynamic> json) {
    idquestion = json['idquestion'];
    text = json['text'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    selectedOption = json['selectedOption'];
    indiceOptionCorrecte = json['indice_optionCorrecte'];
    quiz = json['quiz'] != null ? new Quiz.fromJson(json['quiz']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idquestion'] = this.idquestion;
    data['text'] = this.text;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['selectedOption'] = this.selectedOption;
    data['indice_optionCorrecte'] = this.indiceOptionCorrecte;
    if (this.quiz != null) {
      data['quiz'] = this.quiz!.toJson();
    }
    return data;
  }

  String? getOption(int index) {
    switch (index) {
      case 1:
        return option1;
      case 2:
        return option2;
      case 3:
        return option3;
      case 4:
        return option4;
      default:
        return null;
    }
  }
}

class Quiz {
  int? idquiz;
  String? titreQuiz;
  String? description;
  int? nbQuestions;
  Niveau? niveau;
  Categorie? categorie;

  Quiz(
      {this.idquiz,
        this.titreQuiz,
        this.description,
        this.nbQuestions,
        this.niveau,
        this.categorie});

  Quiz.fromJson(Map<String, dynamic> json) {
    idquiz = json['idquiz'];
    titreQuiz = json['titre_quiz'];
    description = json['description'];
    nbQuestions = json['nb_questions'];
    niveau =
    json['niveau'] != null ? new Niveau.fromJson(json['niveau']) : null;
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idquiz'] = this.idquiz;
    data['titre_quiz'] = this.titreQuiz;
    data['description'] = this.description;
    data['nb_questions'] = this.nbQuestions;
    if (this.niveau != null) {
      data['niveau'] = this.niveau!.toJson();
    }
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    return data;
  }
}

class Niveau {
  int? idNiveau;
  String? name;
  Categorie? categorie;

  Niveau({this.idNiveau, this.name, this.categorie});

  Niveau.fromJson(Map<String, dynamic> json) {
    idNiveau = json['idNiveau'];
    name = json['name'];
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNiveau'] = this.idNiveau;
    data['name'] = this.name;
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    return data;
  }
}

class Categorie {
  int? idcategorie;
  String? titreCategorie;

  Categorie({this.idcategorie, this.titreCategorie});

  Categorie.fromJson(Map<String, dynamic> json) {
    idcategorie = json['idcategorie'];
    titreCategorie = json['titre_categorie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcategorie'] = this.idcategorie;
    data['titre_categorie'] = this.titreCategorie;
    return data;
  }
}
