import 'dart:async';
import 'package:ecommerce/Data/Models/card/card_item_model.dart';
import 'package:ecommerce/Data/Models/order/order_model.dart';
import 'package:ecommerce/Data/respositories/order_repository.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_cubit.dart';
import 'package:ecommerce/Logic/Cubit/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../User_Cubit/User_state.dart';
import '../User_Cubit/user_Cubit.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  OrderCubit(this._userCubit,this._cartCubit) : super(OrderInitialState()) {
    _handelUserState(_userCubit.state);
    //listing of user cubit
    _userSubscription = _userCubit.stream.listen(_handelUserState);
  }

  void _handelUserState(UserState userState) async {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedInState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchOrderForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
    }
  }

  Future<bool> createOrder(
      {required List<CardItemModel> items,
      required String paymentMethod
      }) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return false;
      }
      OrderModel newOrder = OrderModel(
          items: items,
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == "pay-on-delivery")
              ? "order-placed"
              : "payment-pending");
      final order = await _orderRepository.createOrder(newOrder);
      List<OrderModel> orders = [
        order,
        ...state.orders
      ]; //... means add one array with other array
      emit(OrderLoadedState(orders));
      _cartCubit.clearCart();//clear the cart
      return true;
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
