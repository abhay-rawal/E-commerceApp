import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: Consumer<Product>(
              builder: (context, value, _) => Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            onPressed: () => product.toggleFavouriteStatus(),
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () => cart.addItem(
              product.id,
              product.price,
              product.title,
            ),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
