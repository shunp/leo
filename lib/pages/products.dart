import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/products.dart';
import '../scoped_models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
        child: Text('no products found.'),
      );
      if (model.displayedProducts.length > 0) {
        content = Products();
      }
      return RefreshIndicator(
        onRefresh: model.fetchProducts,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            ),
          ],
        ),
        body: _buildProductList());
  }
}
