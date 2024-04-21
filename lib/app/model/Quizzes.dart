
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

class Niveau {
  int? idNiveau;
  String? name;
  Categorie? categorie;

  Niveau({this.idNiveau, this.name, this.categorie});

  Niveau.fromJson(Map<String, dynamic> json) {
    idNiveau = json['idNiveau'];
    name = json['name'];
    categorie = json['categorie'] != null ? new Categorie.fromJson(json['categorie']) : null;
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
  List<Quizzes>? quizzes;

  Categorie({this.idcategorie, this.titreCategorie, this.quizzes});

  Categorie.fromJson(Map<String, dynamic> json) {
    idcategorie = json['idcategorie'];
    titreCategorie = json['titre_categorie'];
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) { quizzes!.add(new Quizzes.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcategorie'] = this.idcategorie;
    data['titre_categorie'] = this.titreCategorie;
    if (this.quizzes != null) {
      data['quizzes'] = this.quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


