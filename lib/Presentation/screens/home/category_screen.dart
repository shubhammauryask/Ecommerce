import 'package:ecommerce/Logic/Cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce/Logic/Cubit/category_cubit/category_state.dart';
import 'package:ecommerce/Presentation/screens/Product/category_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryLoadingState && state.categories.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CategoryErrorState && state.categories.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }
      return ListView.builder(
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final category = state.categories[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, CategoryProductScreen.routeName,arguments: category);
            },
            leading: Icon(Icons.category),
            title: Text(category.title.toString()),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
      );
    });
  }
}
