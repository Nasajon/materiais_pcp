enum DiasDaSemanaType {
  sunday(code: 1, name: 'Domingo'),
  monday(code: 2, name: 'Segunda'),
  tuesday(code: 3, name: 'Terça'),
  wednesday(code: 4, name: 'Quarta'),
  thursday(code: 5, name: 'Quinta'),
  friday(code: 6, name: 'Sexta'),
  saturday(code: 7, name: 'Sábado');

  final int code;
  final String name;

  const DiasDaSemanaType({required this.code, required this.name});

  String get firstLetter => name.substring(0, 1);
  String get threeLetters => name.substring(0, 3);

  static DiasDaSemanaType selectDayOfWeek(int code) {
    return DiasDaSemanaType.values.where((element) => element.code == code).first;
  }
}
