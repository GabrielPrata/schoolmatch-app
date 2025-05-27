class GenderModel {
  final int genderId;
  final String genderName;
  bool selected;

  GenderModel({
    required this.genderId,
    required this.genderName,
    required this.selected,
  });

  static createAppGenders() {
    List<GenderModel> appGenders = [];
    appGenders.add(GenderModel(genderId: 1, genderName: "Homem", selected: false));
    appGenders.add(GenderModel(genderId: 2, genderName: "Mulher", selected: false));
    appGenders.add(GenderModel(genderId: 3, genderName: "Não Binário", selected: false));

    return appGenders;
  }

  static createAppGendersPreferences() {
    List<GenderModel> appGenders = [];
    appGenders.add(GenderModel(genderId: 1, genderName: "Homem", selected: false));
    appGenders.add(GenderModel(genderId: 2, genderName: "Mulher", selected: false));
    appGenders.add(GenderModel(genderId: 3, genderName: "Não Binário", selected: false));
    appGenders.add(GenderModel(genderId: 4, genderName: "CAIU NA VILA O PEIXE FUZILA", selected: false));

    return appGenders;
  }
}