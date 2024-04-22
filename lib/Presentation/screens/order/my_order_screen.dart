import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Logic/Cubit/order/order_cubit.dart';
import 'package:ecommerce/Logic/Cubit/order/order_state.dart';
import 'package:ecommerce/Logic/services/formater.dart';
import 'package:ecommerce/themeUI/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});
  static const routeName = "my_order";
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Order"),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          if (state is OrderLoadingState && state.orders.isEmpty) {
            return CircularProgressIndicator();
          }
          if (state is OrderErrorState && state.orders.isEmpty) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.orders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = state.orders[index];
              return Card(
                elevation: 5,
                shadowColor: AppColors.secondary,
                child: Padding(
                  padding: const EdgeInsets.only(top:10,right:10,left:10,bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("#-${order.sId}",style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Text(
                          "Order Placed on:${Formatter.formatDate(order.createdOn!)}",
                      style: TextStyles.textLow.copyWith(color: Colors.blueAccent),),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: order.items!.length,
                        itemBuilder: (context,index){
                          final item = order.items![index];
                          final product = item.product!;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CachedNetworkImage(
                              width: 50,
                              imageUrl:product.images![0],),

                            title: Text("${product.title}"),
                            subtitle: Text("Qyt:${item.quantity}"),
                            trailing: Text("${Formatter.formatPrice(product.price!*item.quantity!) }"),
                          );
                        },
                      ),
                      Center(
                        child: SizedBox(
                          width: 100,
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
