import 'dart:async';

// Class
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }
}

// Repository
class ProductRepository {
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 1500.0),
    Product(id: 2, name: 'Mouse', price: 25.0),
  ];

  // StreamController.broadcast cho phep nhieu listener cung nghe
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  // Tra ve list ds product
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  // Giai phong tai nguyen
  void dispose() {
    _controller.close();
  }
}

Future<void> main() async {
  final repository = ProductRepository();

  print('Danh sach sp ban dau');
  final products = await repository.getAll();

  for (var product in products) {
    print(product);
  }

  print('Lang nghe sp moi');

  repository.liveAdded().listen((product) {
    print('Sp moi dc them: $product');
  });

  repository.addProduct(Product(id: 3, name: 'Keyboard', price: 50.0));

  await Future.delayed(Duration(seconds: 1));
  repository.dispose();
}
