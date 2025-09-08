class ProgramModel {
  String? title;
  int startAge = 1;
  int endAge = 10;
  String? type;
  int period = 0;
  double price = 0;

  ProgramModel({
    this.title,
    this.startAge = 1,
    this.endAge = 10,
    this.type,
    this.period = 0,
    this.price = 0,
  });
}