
import '../../Data/Models/card/card_item_model.dart';

class  Calculator{
   static int carTotal(List<CardItemModel>item){
     int total =0;
     for(int i=0;i<item.length;i++){
       total += item[i].product!.price!*item[i].quantity!;
     }
     return total;
   }
}