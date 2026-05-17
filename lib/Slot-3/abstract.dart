abstract class Animal {
  String name;

  Animal(this.name);

  void sound(); // abstract method

  void info() {
    print("Tên: $name");
  }
}

class Dog implements Animal {
  @override
  String name;

  Dog(this.name);

  @override
  void sound() {
    print("Gâu gâu");
  }

  @override
  void info() {
    print("Dog name: $name");
  }
}

void main() {
  Dog dog = Dog("Husky");

  dog.info();
  dog.sound();
}
