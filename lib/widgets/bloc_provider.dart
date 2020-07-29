import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider = context.dependOnInheritedWidgetOfExactType();
    return provider.bloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}

