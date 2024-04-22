import 'package:ecommerce/Data/Models/user/user_model.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_cubit.dart';
import 'package:ecommerce/Logic/Cubit/cart/cart_state.dart';
import 'package:ecommerce/Logic/Cubit/order/order_cubit.dart';
import 'package:ecommerce/Presentation/screens/Widget/cart_list_view.dart';
import 'package:ecommerce/Presentation/screens/Widget/gap_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/linkTextButton_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/primaryButton_widget.dart';
import 'package:ecommerce/Presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/Presentation/screens/order/provider/order_detail_provider.dart';
import 'package:ecommerce/Presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce/themeUI/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const routeName = "order_detail";
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Order"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Detail",
                        style: TextStyles.textLow.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const GapWidget(),
                      Text(
                        user.fullName.toString(),
                        style: TextStyles.headerMedium,
                      ),
                      Text(
                        "Email: ${user.email}",
                        style: TextStyles.textLow,
                      ),
                      Text(
                        "Phone Number: ${user.phoneNumber}",
                        style: TextStyles.textLow,
                      ),
                      Text(
                        "Address: ${user.address}",
                        style: TextStyles.textLow,
                      ),
                      LinkButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProfileScreen.routeName);
                        },
                        text: "Edit Profile",
                        color: Colors.blue,
                      )
                    ],
                  );
                }
                if (state is UserErrorState) {
                  return Text(state.message);
                }

                return const SizedBox();
              },
            ),
            GapWidget(),
            Text(
              "Items",
              style: TextStyles.textLow.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState && state.items.isEmpty) {
                  return CircularProgressIndicator();
                }
                if (state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }

                return Container(
                    child: CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                ));
              },
            ),
            GapWidget(),
            Text(
              "Payment",
              style: TextStyles.textLow.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  RadioListTile(
                    value: "pay-on-delivery",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.redAccent,
                    title: Text("Pay on Delivery"),
                  ),
                  RadioListTile(
                    value: "pay-now",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.redAccent,
                    title: Text("Pay Now"),
                  ),
                ],
              );
            }),
            GapWidget(),
            PrimaryButton(
              text: "Place Order",
              onPressed: () async {
                bool success =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                  items: BlocProvider.of<CartCubit>(context).state.items,
                  paymentMethod:
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .paymentMethod
                          .toString(),
                );

                if (success) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(
                      context, OrderPlacedScreen.routeName);
                }
              },
              borderRadius: 10,
              backGroundColor: AppColors.secondary,
            )
          ],
        ),
      ),
    );
  }
}
