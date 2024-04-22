import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Data/Models/product/product_model.dart';
import '../../../Logic/services/formater.dart';
import '../Product/product_detail_screen.dart';

class ProductListview extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListview({ super.key,required this.products});

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(wi * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [Color(0xFFD8B5FF), Color(0xFF1EAE98)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CupertinoButton(
              onPressed: () {
                Navigator.pushNamed(context, ProductDetailScreen.routeName,
                    arguments: product);
              },
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        width: wi * 0.2, imageUrl: "${product.images?[0]}"),
                  ),
                  SizedBox(
                    width: wi * 0.05,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Text(
                          product.description.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              "${Formatter.formatPrice(product.price!)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
