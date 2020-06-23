class ProblemModel {
  final String problemID, problemName, problemLink, category;
  final int difficulty;
  final List<String> companies;
  ProblemModel({this.problemID, this.problemName, this.problemLink, this.category, this.difficulty, this.companies});

  factory ProblemModel.fromMap(String id, Map<String, dynamic> arg) {
    List<String> _companies = List<String>();
    var _temp = arg['companies'] ?? ['-'];
    for (var i in _temp)
      _companies.add(i.toString());

    return ProblemModel(
      problemID: id,
      problemName: arg['name'],
      category: arg['category'],
      problemLink: arg['link'],
      difficulty: int.parse(arg['difficulty'].toString()), // just in case some one puts string "d" instead of number d
      companies: _companies
    );
  }
}