import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemStore {
  static Map<int, Set<String>> _problemsets;
  static int _problem_count = 0;
  static int get problem_count => _problem_count;

  static Set<String> problemsOnDay({int day}) => _problemsets[day];

  static Future loadProblemsets() async {
    var db = Firestore.instance;
    _problem_count = 0;

    var psets = await db.collection('/problemset').getDocuments();
    
    _problemsets = Map<int, Set<String>>();
    for (var i in psets.documents) {
      var problems = Set<String>();

      for (var j in i['problems']) {
        problems.add(j);
        ++_problem_count;
      }

      _problemsets[int.parse(i.documentID.replaceFirst('day', ''))] = problems;
    }
  }
}