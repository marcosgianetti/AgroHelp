class Fruit {
  String name = '';
  String dbName = '';
  List<Disease> desease = <Disease>[];

  changeName(String name) {
    this.name = name;
    dbName = _dbNameMap[this.name]!;
  }

  Map<String, String> _dbNameMap = {'': '', 'Maça': 'Apple', 'Milho': 'Corn', 'Uva': 'Grape', 'Tomate': 'Tomato'};
}

class Disease {
  String name = '';
  String caracteristc = '';
  String treatement = '';
  String prevention = '';
  double score = 0.0;
}
