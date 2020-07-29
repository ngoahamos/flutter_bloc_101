import 'package:flutter/material.dart';
import 'package:packt/api/db_api.dart';
import 'package:packt/blocs/category_bloc.dart';
import 'package:packt/blocs/product_bloc.dart';
import 'package:packt/models/category.dart';
import 'package:packt/pages/selected_category.dart';
import 'package:packt/widgets/bloc_provider.dart';
import 'package:packt/widgets/containers/cart_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commence'),
        actions: <Widget>[CartButton()],
      ),
      body: StreamBuilder<List<Category>>(
          stream: _categoriesBloc.outCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    final category = snapshot.data[index];
                    return ListTile(
                      title: Text(category.name),
                      onTap: () => navigateSelectedCategory(context, category),
                    );
                  });
            }
            return Center(child: Text('No Category!'),);
          }),
    );
  }

  void navigateSelectedCategory(BuildContext context, Category category) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
            bloc: ProductBloc(category), child: SelectedCategory())));
  }
}
