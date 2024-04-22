import '../../../Data/Models/card/card_item_model.dart';

abstract class CartState{
 final List<CardItemModel>items;
 CartState(this.items);
}

class CartInitialState extends CartState{
  CartInitialState():super([]);
}

class CartLoadingState extends CartState{
  CartLoadingState(super.items);
}
class CartLoadedState extends CartState{
  CartLoadedState(super.items);
}
class CartErrorState extends CartState{
  final String message;
  CartErrorState(this.message,super.items);
}