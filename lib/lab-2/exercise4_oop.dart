class Car {
  String brand;

  // Constructor
  Car(this.brand);

  // Named constructor
  Car.luxury(this.brand);

  // Method
  void showInfo() {
    print("Car brand: $brand");
  }
}

class ElectricCar extends Car {
  ElectricCar(String brand) : super(brand);

  // Override method
  @override
  void showInfo() {
    print("Electric car brand: $brand");
  }
}

void main() {
  Car car1 = Car("Toyota");
  car1.showInfo();

  // Constructor
  Car car2 = Car.luxury("BMW");
  car2.showInfo();

  ElectricCar tesla = ElectricCar("Tesla");
  tesla.showInfo();
}
