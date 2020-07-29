import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packt/models/category.dart';
import 'package:packt/models/product.dart';

class DbApi {

//  List<Product> getProducts(Category category) {
//    return [
//      Product.create('Product 1'),
//      Product.create('Product 2'),
//      Product.create('Product 3'),
//      Product.create('Product 4'),
//      Product.create('Product 5'),
//      Product.create('Product 6'),
//      Product.create('Product 7'),
//      Product.create('Product 8')
//    ];
//  }

  Stream<QuerySnapshot> getCategories() {
    Firestore db = Firestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot =
          db.collection('Categories').snapshots();
      return querySnapshot;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Stream<QuerySnapshot> getProducts(Category category) {
    Firestore db = Firestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot =
      db.collection('Categories').document(category.id).collection('parts').snapshots();
      return querySnapshot;
    } catch (e) {
      print(e);
      throw (e);
    }
  }


}
