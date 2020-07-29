import 'dart:async';
import 'package:packt/models/cart.dart';
import 'package:packt/models/product.dart';
import 'package:packt/widgets/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BlocBase {
  Cart _cart = Cart();

  final _productController = BehaviorSubject<List<Product>>();
  Sink<List<Product>> get _inProducts => _productController.sink;
  Stream<List<Product>> get outProducts => _productController.stream;

  final _countController = BehaviorSubject<int>();
  Sink<int> get _inCount => _countController.sink;
  Stream<int> get outCount => _countController.stream;

  void addProduct(Product product) {
    List<Product> _products = _cart.products;
    if(_products.contains(product)) {
      _products[_products.indexOf(product)].amount++;
    } else {
      product.amount = 1;
      _products.add(product);
    }
    _cart.itemCount++;
    _inProducts.add(_products);
    _inCount.add(_cart.itemCount);

  }

  @override
  void dispose() {
    _productController.close();
    _countController.close();
  }

}