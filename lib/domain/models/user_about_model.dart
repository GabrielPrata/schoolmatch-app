class UserAboutModel {
  String? zodiacSign;
  String? loveLanguage;
  String? pets;
  String? drink;
  String? smoker;
  String? physicalActivity;
  String? typeOfOuting;

  UserAboutModel({
    this.zodiacSign,
    this.loveLanguage,
    this.pets,
    this.drink,
    this.smoker,
    this.physicalActivity,
    this.typeOfOuting,
  });

  factory UserAboutModel.fromJson(Map<String, dynamic> json) {
    return UserAboutModel(
      zodiacSign: json['zodiacSign'],
      loveLanguage: json['loveLanguage'],
      pets: json['pets'],
      drink: json['drink'],
      smoker: json['smoker'],
      physicalActivity: json['physicalActivity'],
      typeOfOuting: json['typeOfOuting'],
    );
  }
}
