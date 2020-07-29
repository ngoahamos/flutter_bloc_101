import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packt/api/db_api.dart';
import 'package:packt/models/category.dart';
import 'package:packt/widgets/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc implements BlocBase {
  List<Category> _categories = [];
  final _categoriesController =
  BehaviorSubject<List<Category>>();

  Sink<List<Category>> get _inCategories => _categoriesController.sink;

  Stream<List<Category>> get outCategories => _categoriesController.stream;

  CategoriesBloc() {
    getCategories();
  }

  void getCategories() {
    DbApi dbApi = DbApi();
    dbApi.getCategories().listen((snapshot) {
      List<Category> categories = [];
      for(DocumentSnapshot doc in snapshot.documents) {
        Category category = Category.fromFirebase(doc.data);
        category.id = doc.documentID;
        categories.add(category);
      }
      _categories.clear();
      _categories.addAll(categories);
      _inCategories.add(_categories);
    });
  }


  @override
  void dispose() {
    _categoriesController.close();
  }
}
