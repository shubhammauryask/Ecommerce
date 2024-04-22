import 'package:ecommerce/Logic/Cubit/category_product_cubit/category_product_State.dart';
import 'package:ecommerce/Logic/Cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/Presentation/screens/Widget/product_list_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  static const routeName = "category_product";
  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    final cubit = BlocProvider.of<CategoryProductCubit>(context,listen:true);
    return Scaffold(
      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body:  SafeArea(
        child: BlocBuilder<CategoryProductCubit,CategoryProductState>(
          builder: (context,state){
            if(state is CategoryProductLoadingState && state.products.isEmpty){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is CategoryProductErrorState && state.products.isEmpty){
              return Center(
                child:  Text(state.message),
              );
            }
            if(state is CategoryProductLoadedState && state.products.isEmpty){
              return Center(
                child: Text("No Product Found"),
              );
            }

            return SizedBox(
              width: wi,
                height: he,
                child: ProductListview(products: state.products));
          },
        ),
      ),
    );
  }
}
