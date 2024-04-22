import 'dart:async';
import 'package:ecommerce/Data/Models/card/card_item_model.dart';
import 'package:ecommerce/Data/Models/product/product_model.dart';
import 'package:ecommerce/Data/respositories/card_repository.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../User_Cubit/user_Cubit.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    _handelUserState(_userCubit.state);
    //listing of user cubit
    _userSubscription = _userCubit.stream.listen(_handelUserState);
  }
  void _handelUserState(UserState userState) async {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedInState) {
      emit(CartInitialState());
    }
  }

  final _cardRepository = CardRepository();
  void sort(List<CardItemModel>items){
    items.sort((a,b)=>b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items));
  }
  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cardRepository.fetchCardForUser(userId);
      sort(items);
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;
        CardItemModel newItem =
            CardItemModel(product: product, quantity: quantity);
        final items =
            await _cardRepository.addToCard(newItem, userState.userModel.sId!);
        sort(items);
      } else {
        throw " An Error occur while adding the item";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  bool cardContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem = state.items
          .where((item) => item.product!.sId! == product.sId)
          .toList();
      if (foundItem.isNotEmpty) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void removeFromCart(ProductModel product) async {
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cardRepository.removeToCard(
            product.sId!, userState.userModel.sId!);
        sort(items);
      } else {
        throw " An Error occur while removing the item";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void clearCart()async{
    emit(CartLoadedState([]));
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
