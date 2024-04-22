import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_state.dart';
import 'package:ecommerce/Logic/services/calculation.dart';
import 'package:ecommerce/Logic/services/formater.dart';
import 'package:ecommerce/Presentation/screens/Widget/cart_list_view.dart';
import 'package:ecommerce/Presentation/screens/Widget/linkTextButton_widget.dart';
import 'package:ecommerce/Presentation/screens/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../Logic/Cubit/cart/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cart";
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Card"),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<CartCubit,CartState>(
            builder: (context,state) {
              if(state is CartLoadingState && state.items.isEmpty){
                return Center(child: CircularProgressIndicator());
              }
              if(state is CartErrorState && state.items.isEmpty){
                return Center(
                  child: Text(state.message),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: CartListView(items: state.items,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 5,right: 5),
                    child: Row(
                      children: [
                         Column(
                         children: [
                           Text("${state.items.length}Items",
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: Colors.black
                           ),),
                           Text("Total Amount ${Formatter.formatPrice(Calculator.carTotal(state.items))}",style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                             fontWeight: FontWeight.bold
                           ),)],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                        Spacer(),
                        SizedBox(
                          width: wi*0.35,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, OrderDetailScreen.routeName);
                              },
                              child: Text("Placed Order",style: TextStyle(
                                color: Colors.white
                              ),),
                              style: ElevatedButton.styleFrom(
                               padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Color(0xFF1EAE98)
                              ),
                            ),
                        ),
                      ],

                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
