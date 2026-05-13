import 'package:ecommerce_app/pages/add_product.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../core/theme/app_color.dart';
import '../pages/home_screen.dart';
import '../pages/cart_screen.dart';
// import '../providers/cart_provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    CartScreen(),
    AddProductScreen(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColor.orange,
        unselectedItemColor: AppColor.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          /// HOME
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: "Home",
          ),

          /// CART WITH BADGE
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  currentIndex == 1
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                ),

                /// BADGE
                // Positioned(
                //   right: 0,
                //   top: 0,
                //   child: Consumer<CartProvider>(
                //     builder: (context, cart, child) {
                //       int totalQty = cart.cartItems.fold(
                //         0,
                //         (sum, item) => sum + item["qty"] as int,
                //       );

                //       if (totalQty == 0) return const SizedBox();

                //       return Container(
                //         padding: const EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //           color:AppColor.green,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         constraints: const BoxConstraints(
                //           minWidth: 16,
                //           minHeight: 16,
                //         ),
                //         child: Text(
                //           "$totalQty",
                //           style: TextStyle(
                //             color: AppColor.white,
                //             fontSize: 10,
                //             fontWeight: FontWeight.bold,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
            label: "Cart",
          ),

          /// FAVORITE
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            label: "Add product",
          ),

          /// PROFILE
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 3
                  ? Icons.person
                  : Icons.person_outline,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
