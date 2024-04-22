import 'package:ecommerce/Data/Models/category_model/category_model.dart';
import 'package:ecommerce/Data/Models/product/product_model.dart';
import 'package:ecommerce/Logic/Cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/Presentation/screens/Product/category_product_screen.dart';
import 'package:ecommerce/Presentation/screens/Product/product_detail_screen.dart';
import 'package:ecommerce/Presentation/screens/auth/Provider/login_provider.dart';
import 'package:ecommerce/Presentation/screens/auth/Provider/signUp_provider.dart';
import 'package:ecommerce/Presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/Presentation/screens/auth/signUp_screen.dart';
import 'package:ecommerce/Presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce/Presentation/screens/home/home_screen.dart';
import 'package:ecommerce/Presentation/screens/order/my_order_screen.dart';
import 'package:ecommerce/Presentation/screens/order/order_detail.dart';
import 'package:ecommerce/Presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/Presentation/screens/order/provider/order_detail_provider.dart';
import 'package:ecommerce/Presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/Presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    // Because of static it is directly accessible without the class
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));

      case SignUpScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignUpProvider(context),
                child: const SignUpScreen()));

      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(
                  productModel: settings.arguments as ProductModel,
                ));
      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const EditProfileScreen());

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case MyOrderScreen.routeName:
              return CupertinoPageRoute(
                  builder: (context) => const MyOrderScreen());

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderDetailProvider(),
                child: const OrderDetailScreen()));

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CategoryProductCubit(settings.arguments as CategoryModel),
                child: const CategoryProductScreen()));
      default:
        return null;
    }
  }
}
