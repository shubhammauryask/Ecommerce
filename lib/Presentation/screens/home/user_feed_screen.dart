import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Logic/Cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce/Logic/Cubit/product_cubit/product_state.dart';
import 'package:ecommerce/Logic/services/formater.dart';
import 'package:ecommerce/Presentation/screens/Product/product_detail_screen.dart';
import 'package:ecommerce/Presentation/screens/Widget/product_list_View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit,ProductState>(
      builder: (context,state) {

        if(state is ProductLoadingState && state.products.isEmpty){
          return const Center(child: CircularProgressIndicator());
        }

        if(state is ProductErrorState && state.products.isEmpty){
          return Center(
            child:  Text(state.message),
          );
        }
        return Container(
          padding: EdgeInsets.only(top: 0.01*wi),
          width: wi,
          height: he,
          color: Colors.white,
          child: ProductListview( products:state.products,),
        );
      }
    );
  }
}
