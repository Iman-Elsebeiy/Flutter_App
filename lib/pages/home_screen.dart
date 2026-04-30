
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/widgets/promo_banner.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_color.dart';
import '../core/constants/app_constants_assets.dart';

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
                style: TextStyle(color: AppColor.grey, fontSize: 11),
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

              /// Grid Products
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: MyAppImage.headphone,
                    name: "Product $index",
                    price: "999",
                  );
                },
              ),

              const SizedBox(height: 40),

              /// Recently Viewed
              Text(
                'Recently Viewed',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProductCard(
                      image: MyAppImage.tvImage,
                      name: "Macbook Air M1",
                      price: "999.99",
                    ),
                    SizedBox(width: 20,),
                    ProductCard(
                      image: MyAppImage.tyre,
                      name: "iPhone 13 Pro",
                      price: "1099.00",
                    ),
                  ],
                ),
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.orange : AppColor.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? AppColor.orange : AppColor.grey,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColor.white : AppColor.black,
        ),
      ),
    );
  }
}
