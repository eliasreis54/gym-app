class Exercises {
  final List<dynamic> monday;
  final List<dynamic> tuesday;

  Exercises({this.monday, this.tuesday});

  factory Exercises.fromJson(Map<String, dynamic> json) {
    return Exercises(monday: json['monday'], tuesday: json['tuesday']);
  }
}
