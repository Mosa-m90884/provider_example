import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                width: double.infinity,
                color: Colors.black45,
                child: Text(
                  loadedProduct.title,
                  // style: TextStyle(backgroundColor: Colors.black54),
                ),
              ),
              background: FittedBox(
                  child: Hero(
                      tag: loadedProduct.id,
                      child: Image.network(
                        loadedProduct.imageUrl,
                        fit: BoxFit.cover,
                      ))),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                margin: EdgeInsets.all(5),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loadedProduct.title,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // FittedBox(
                    //     child: Hero(
                    //         tag: loadedProduct.id,
                    //         child: Image.network(loadedProduct.imageUrl))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: \$" + loadedProduct.price.toString(),
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton(
                          onPressed: () {
                            cart.addItem(loadedProduct.id, loadedProduct.price,
                                loadedProduct.title);
                          },
                          child: Text("ADD TO CART"),
                        )
                      ],
                    ),
                    Text(
                      loadedProduct.description,
                      style: TextStyle(color: Colors.black26),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 800,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
