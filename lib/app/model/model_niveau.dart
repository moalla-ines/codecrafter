import 'package:codecrafter/app/model/Quizzes.dart';

class Niveau {
  int? idNiveau;
  String? name;
  Categorie? categorie;

  Niveau({this.idNiveau, this.name, this.categorie});

  Niveau.fromJson(Map<String, dynamic> json) {
    idNiveau = json['idNiveau'];
    name = json['name'];
    categorie = json['categorie'] != null ? Categorie.fromJson(json['categorie']) : null;
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


