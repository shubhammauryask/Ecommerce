import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Data/Models/product/product_model.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_state.dart';
import 'package:ecommerce/Presentation/screens/Widget/gap_widget.dart';
import 'package:ecommerce/themeUI/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../../../Logic/services/formater.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});
  static const routeName = "product_detail";
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.white,
          width: wi,
          height: he,
          child: ListView(
            children: [
              SizedBox(
                height: wi,
                child: CarouselSlider.builder(
                  itemCount: widget.productModel.images?.length ?? 0,
                  slideBuilder: (index) {
                    return CachedNetworkImage(
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.fitHeight,
                        imageUrl: widget.productModel.images![index]);
                  },
                ),
              ),
              const GapWidget(),
              Text(
                widget.productModel.title.toString(),
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Formatter.formatPrice(widget.productModel.price!),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    const GapWidget(),
                    SizedBox(
                      width: wi,
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          bool isInCart = BlocProvider.of<CartCubit>(context)
                              .cardContains(widget.productModel);
                          return ElevatedButton(
                            onPressed: () {
                              if (isInCart) {
                                return;
                              }
                              BlocProvider.of<CartCubit>(context)
                                  .addToCart(widget.productModel, 1);
                            },
                            child: Text(
                              BlocProvider.of<CartCubit>(context)
                                      .cardContains(widget.productModel)
                                  ? "Product added to Cart"
                                  : "Add to Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                backgroundColor:
                                    BlocProvider.of<CartCubit>(context)
                                            .cardContains(widget.productModel)
                                        ? Colors.grey
                                        : Color(0xFF1EAE98),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          );
                        },
                      ),
                    ),
                    const GapWidget(),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                          color: Colors.black),
                    ),
                    Text(
                      widget.productModel.description.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
