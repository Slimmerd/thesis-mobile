class PerHundredGrams {
  int id;
  int kcal;
  int fat;
  int carbs;
  int protein;

  PerHundredGrams(
      {required this.id,
      required this.kcal,
      required this.fat,
      required this.carbs,
      required this.protein});

  PerHundredGrams.fromJson(Map json)
      : id = json['id'],
        kcal = json['kcal'],
        fat = json['fat'],
        carbs = json['carbs'],
        protein = json['protein'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'kcal': kcal,
        'fat': fat,
        'carbs': carbs,
        'protein': protein,
      };
}
