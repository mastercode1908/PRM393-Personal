class Student {
  String _name;
  int _age;

  Student(this._name, this._age);

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}

void main() async {
  var list = [Student("An", 4), Student("Binh", 5)];
  await Future.delayed(Duration(seconds: 1));
  list.forEach((s) => print("${s.name},${s.age}"));
}
