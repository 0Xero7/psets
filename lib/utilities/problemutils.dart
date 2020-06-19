
String parseDifficulty(int val) {
  if (val <= 3) return "Easy";
  if (val <= 7) return "Medium";
  return "Hard";
}

String toPascalCase(String s) {
  var arr = s.split(' ');
  String res = '';

  for (String x in arr) {
    res += x[0].toUpperCase() + x.substring(1, x.length).toLowerCase() + " ";
  }
  return res;
}