class ProblemModel {
  final String problemID, problemName, problemLink, category;
  final int difficulty;
  ProblemModel({this.problemID, this.problemName, this.problemLink, this.category, this.difficulty});

  factory ProblemModel.fromMap(String id, Map<String, dynamic> arg) {
    return ProblemModel(
      problemID: id,
      problemName: arg['name'],
      category: arg['category'],
      problemLink: arg['link'],
      difficulty: int.parse(arg['difficulty'].toString()) // just in case some one puts string "d" instead of number d
    );
  }
}