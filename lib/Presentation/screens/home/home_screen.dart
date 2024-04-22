import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_state.dart';
import 'package:ecommerce/Presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce/Presentation/screens/home/category_screen.dart';
import 'package:ecommerce/Presentation/screens/home/profile_screen.dart';
import 'package:ecommerce/Presentation/screens/home/user_feed_screen.dart';
import 'package:ecommerce/Presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screen = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(

      listener: ( context,state) {
         if(state is UserLogOutState){
           Navigator.pushReplacementNamed(context, SplashScreen.routeName);
         }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.5),
          title: const Text(
            "Ecommerce App",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                icon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Badge(
                      isLabelVisible: (state is CartLoadingState)?false:true,
                        label: Text("${state.items.length}",style: TextStyle(
                          fontSize: 10,
                        ),
                        ),
                        child: Icon(CupertinoIcons.cart_fill));
                  },
                )),
          ],
          backgroundColor: Color(0xFF6F6565FF),
        ),
        body: screen[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF1EAE98),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
