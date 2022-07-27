import 'dart:convert';

class Intake {
  String id;
  String name;
  int calories;
  int protein;
  int carbs;
  int fats;
  int sodium;
  bool alreadyAte;
  DateTime loadDate;
  DateTime editDate;

  Intake({
    required this.id,
    this.name = '',
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fats = 0,
    this.sodium = 0,
    this.alreadyAte = true,
    required this.loadDate,
    required this.editDate,
  });

  String jsonify([bool ignoreId = false]) => json.encode({
        "name": name,
        "calories": calories,
        "protein": protein,
        "carbs": carbs,
        "fats": fats,
        "sodium": sodium,
        "alreadyAte": alreadyAte,
        "_id": id,
        "loadDate": loadDate.toIso8601String(),
        "editDate": editDate.toIso8601String(),
      });

  static Intake parse(dynamic obj) {
    return Intake(
      id: obj["_id"],
      name: obj["name"],
      calories: obj["calories"],
      protein: obj["protein"],
      carbs: obj["carbs"],
      fats: obj["fats"],
      sodium: obj["sodium"],
      alreadyAte: obj["alreadyAte"],
      loadDate: DateTime.parse(obj["loadDate"]),
      editDate: DateTime.parse(obj["editDate"]),
    );
  }

  static List<Intake> parseList(List<dynamic> obj) {
    return obj.map((e) => parse(e)).toList();
  }

  static List<Intake> parseStringList(List<String> obj) {
    return obj.map((e) => parse(jsonDecode(e))).toList();
  }
}

extension ListExtensions on List<Intake> {
  List<String> jsonify() {
    return map((e) => e.jsonify()).toList();
  }
}
