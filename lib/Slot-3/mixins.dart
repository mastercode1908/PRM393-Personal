mixin Fly {
  void fly() {
    print("Flying...");
  }
}

mixin Swim {
  void swim() {
    print("Swimming...");
  }
}

class Duck with Fly, Swim {
  void show() {
    print("I am a duck");
  }
}

void main() {
  Duck duck = Duck();

  duck.show();
  duck.fly();
  duck.swim();
}
