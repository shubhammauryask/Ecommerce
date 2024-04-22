import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../Data/Models/card/card_item_model.dart';
import '../../../Logic/Cubit/cart/cart_cubit.dart';
import '../../../Logic/services/formater.dart';
import 'linkTextButton_widget.dart';

class CartListView extends StatelessWidget {
  final List<CardItemModel>items;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView({super.key,required this.items,this.shrinkWrap = false,this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: (noScroll)? const NeverScrollableScrollPhysics():null,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: SizedBox(
            width: 50,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: item.product!.images![0],
            ),
          ),
          title: Text(item.product!.title.toString(),style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),textAlign: TextAlign.start,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity}"
                      "= ${Formatter.formatPrice(item.product!.price!* item.quantity!)}"),
              LinkButton(
                onPressed: (){
                  BlocProvider.of<CartCubit>(context).removeFromCart(item.product!);
                },
                color: Colors.red,
                text:'Delete',
              )
            ],
          ),
          trailing: InputQty(
            minVal: 1,
            initVal: item.quantity!, //product Initial value
            maxVal: 99,
            onQtyChanged: (value) {
              print("I am Updating this");
                BlocProvider.of<CartCubit>(context).
                addToCart(item.product!, value.toInt());
            },
          ),
        );
      },
    );
  }
}
