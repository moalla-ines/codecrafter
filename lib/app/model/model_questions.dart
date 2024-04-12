class Questions {
  int? idquestion;
  int? indice_option_correcte;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? text;
  int? idquiz;

  Questions(this.idquestion, this.indice_option_correcte, this.option1,
      this.option2, this.option3, this.option4, this.text, this.idquiz);

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      json['idquestion'],
      json['indice_option_correcte'],
      json['option1'],
      json['option2'],
      json['option3'],
      json['option4'],
      json['text'],
      json['idquiz'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idquestion': idquestion,
      'indice_option_correcte': indice_option_correcte,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'text': text,
      'idquiz': idquiz,
    };
  }
}
