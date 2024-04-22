import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_cubit.dart';
import 'package:ecommerce/Logic/Cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce/Logic/Cubit/order/order_cubit.dart';
import 'package:ecommerce/Presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/themeUI/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/routes/routes.dart';
import 'Logic/Cubit/product_cubit/product_cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
     Bloc.observer = MyBlocObserver();
    runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>UserCubit()),
        BlocProvider(create: (context)=>CategoryCubit()),
        BlocProvider(create: (context)=>ProductCubit()),
        BlocProvider(create: (context)=>CartCubit(
          BlocProvider.of<UserCubit>(context)
        )),
        BlocProvider(create: (context)=>OrderCubit(
            BlocProvider.of<UserCubit>(context),
            BlocProvider.of<CartCubit>(context)
        )),
      ],
      child: MaterialApp(
        theme: Themes.defaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    print('Create$bloc');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('Change In $bloc:$change');
    super.onChange(bloc, change);
  }
  
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Change in $bloc:$transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    print('Close$bloc');
    super.onClose(bloc);
  }
}


