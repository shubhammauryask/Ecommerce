import 'package:ecommerce/Data/respositories/product_repository.dart';
import 'package:ecommerce/Logic/Cubit/category_product_cubit/category_product_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/Models/category_model/category_model.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final  _productRepository = ProductRepository();
  void _initialize() async{
     try{
        final product = await _productRepository.fetchProductsByCategory(category.sId!);
        emit(CategoryProductLoadedState(product));
     }catch(ex){
       emit(CategoryProductErrorState(ex.toString(), state.products));
     }
  }
}
