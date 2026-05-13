import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_color.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: AppColor.white,
      ),

      body: cart.cartItems.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                /// LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cart.cartItems[index];

                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.lighter,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Image.asset(item["image"], width: 70),

                            const SizedBox(width: 10),

                            /// NAME + PRICE
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(item["name"]),
                                  const SizedBox(height: 5),
                                  Text(
                                    "\$${item["price"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            /// QTY
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      cart.decreaseQty(index),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text("${item["qty"]}"),
                                IconButton(
                                  onPressed: () =>
                                      cart.increaseQty(index),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// TOTAL + CHECKOUT
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color:AppColor.black.withValues(),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text(
                            "\$${cart.total.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                         child:CustomButton(text: 'Checkout', onPressed: (){},
                        textColor: AppColor.white,
                        ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}