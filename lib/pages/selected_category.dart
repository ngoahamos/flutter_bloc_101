
import 'package:flutter/material.dart';
import 'package:packt/blocs/cart_bloc.dart';
import 'package:packt/blocs/product_bloc.dart';
import 'package:packt/models/product.dart';
import 'package:packt/widgets/bloc_provider.dart';
import 'package:packt/widgets/containers/cart_button.dart';

class SelectedCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ProductBloc _productBloc = BlocProvider.of<ProductBloc>(context);
    final CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Item'),
      actions: <Widget>[
        CartButton()
      ],),
      body: StreamBuilder<List<Product>>(
        stream: _productBloc.outProducts,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  final product = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      _cartBloc.addProduct(product);
                    },
                    child: Center(
                      child: Text(snapshot.data[index].name),
                    ),
                  );
                });
          } else {
            return SizedBox();
          }
    },
    ),
    );
  }
}
