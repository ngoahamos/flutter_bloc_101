import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packt/api/db_api.dart';
import 'package:packt/models/category.dart';
import 'package:packt/models/product.dart';
import 'package:packt/widgets/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  List<Product> _products = [];
  final _productController = BehaviorSubject<List<Product>>();
  Sink<List<Product>> get _inProducts => _productController.sink;
  Stream<List<Product>> get outProducts => _productController.stream;

  ProductBloc(Category category) {
    getProducts(category);
  }

  void getProducts(Category category) {
    DbApi dbApi = DbApi();
    dbApi.getProducts(category).listen((snapshot) {
      List<Product> tempProducts = [];
      for(DocumentSnapshot doc in snapshot.documents) {
        Product product = Product.fromFirebase(doc.data);
        product.id = doc.documentID;
        tempProducts.add(product);
      }
      _products.clear();
      _products.addAll(tempProducts);
      _inProducts.add(_products);
    });
  }


  @override
  void dispose() {
    _productController.close();
  }

}