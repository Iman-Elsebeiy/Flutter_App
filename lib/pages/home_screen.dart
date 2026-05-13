import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/widgets/promo_banner.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedCategory = 0;

  final List<String> categories = [
    "Technology",
    "Fashion",
    "Sports",
    "Supermarket",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColor.white,
        titleSpacing: 10,
        title: const CustomSearchBar(),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const PromoBanner(),

              const SizedBox(height: 10),

              Text(
                '*Valid from 27/03 to 01/04 2022. Min stock: 1 unit',
                style: TextStyle(
                  color: AppColor.grey,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 20),

              /// Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: List.generate(categories.length, (index) {

                    return GestureDetector(

                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },

                      child: CategoryChip(
                        label: categories[index],
                        isSelected: selectedCategory == index,
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              /// Hot Sales
              Text(
                'Hot Sales',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// Products From Firestore
              StreamBuilder<QuerySnapshot>(

                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),

                builder: (context, snapshot) {

                  // Loading
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Empty
                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {

                    return const Center(
                      child: Text("No Products Found"),
                    );
                  }

                  final products = snapshot.data!.docs;

                  return GridView.builder(

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount: products.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      mainAxisSpacing: 10,

                      crossAxisSpacing: 10,

                      childAspectRatio: 0.7,
                    ),

                    itemBuilder: (context, index) {

                      final product =
                          products[index].data()
                              as Map<String, dynamic>;

                      return ProductCard(

                        image: product["image"] ?? "",

                        name: product["name"] ?? "",

                        price:
                            product["price"].toString(),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// Category Chip
class CategoryChip extends StatelessWidget {

  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(right: 8),

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(

        color: isSelected
            ? AppColor.orange
            : AppColor.white,

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: isSelected
              ? AppColor.orange
              : AppColor.grey,
        ),
      ),

      child: Text(

        label,

        style: TextStyle(
          color: isSelected
              ? AppColor.white
              : AppColor.black,
        ),
      ),
    );
  }
}