import 'package:intl/intl.dart';

class Formatter{
    static String formatPrice(num price){
    final numberFormat = NumberFormat("₹  #,##,###");
    return numberFormat.format(price);
  }
  static String formatDate(DateTime date){
     DateTime localDate = date.toLocal(); // utc time zone in nodeJs so for local use this
    final dateFormat =DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}