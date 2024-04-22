


  class Quizzes {
    int? id;
    String? titreQuiz;
    String? description;
    int? nbQuestions;
    Niveau? niveau;
    Categorie? categorie;

  Quizzes(
        {this.id,
          this.titreQuiz,
          this.description,
          this.nbQuestions,
          this.niveau,
          this.categorie});

  Quizzes.fromJson(Map<String, dynamic> json) {
      id = json['id'];
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


