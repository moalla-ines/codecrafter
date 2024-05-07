class QuizHistory {
  int? idquizhistory;
  int? result;
  User? user;
  Quiz? quiz;

  QuizHistory({this.idquizhistory, this.result, this.user, this.quiz});

  QuizHistory.fromJson(Map<String, dynamic> json) {
    idquizhistory = json['idquizhistory'];
    result = json['result'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    quiz = json['quiz'] != null ? new Quiz.fromJson(json['quiz']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idquizhistory'] = this.idquizhistory;
    data['result'] = this.result;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.quiz != null) {
      data['quiz'] = this.quiz!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? password;
  String? email;
  List<Roles>? roles;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? enabled;
  List<Authorities>? authorities;
  bool? accountNonLocked;

  User(
      {this.id,
        this.username,
        this.password,
        this.email,
        this.roles,
        this.credentialsNonExpired,
        this.accountNonExpired,
        this.enabled,
        this.authorities,
        this.accountNonLocked});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonExpired = json['accountNonExpired'];
    enabled = json['enabled'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    accountNonLocked = json['accountNonLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonExpired'] = this.accountNonExpired;
    data['enabled'] = this.enabled;
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['accountNonLocked'] = this.accountNonLocked;
    return data;
  }
}

class Roles {
  int? idrole;
  String? name;

  Roles({this.idrole, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    idrole = json['idrole'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idrole'] = this.idrole;
    data['name'] = this.name;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}

class Quiz {
  int? idquiz;
  String? titreQuiz;
  String? description;
  int? nbQuestions;
  Niveau? niveau;
  Categorie? categorie;
  List<Questions>? questions;

  Quiz(
      {this.idquiz,
        this.titreQuiz,
        this.description,
        this.nbQuestions,
        this.niveau,
        this.categorie,
        this.questions});

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
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
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
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
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

class Questions {
  int? idquestion;
  String? text;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  int? indiceoptionCorrecte;

  Questions(
      {this.idquestion,
        this.text,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
        this.indiceoptionCorrecte});

  Questions.fromJson(Map<String, dynamic> json) {
    idquestion = json['idquestion'];
    text = json['text'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    indiceoptionCorrecte = json['indiceoptionCorrecte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idquestion'] = this.idquestion;
    data['text'] = this.text;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['indiceoptionCorrecte'] = this.indiceoptionCorrecte;
    return data;
  }
}