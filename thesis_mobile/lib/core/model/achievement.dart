class Achievement {
  String image;
  String title;
  String description;
  int amount;

  Achievement(
      {required this.image,
      required this.title,
      required this.description,
      required this.amount});

  Achievement.fromJson(Map json)
      : image = json['image'],
        title = json['title'],
        amount = json['amount'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'description': description,
        'amount': amount,
      };
}
