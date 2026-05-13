import 'package:flutter/material.dart';
import '../core/theme/app_color.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.lighter,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.network(
              image,
              height: 80,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const CircularProgressIndicator();
              },
            ),
          const SizedBox(height: 8),
          Text(name),
          const SizedBox(height: 5),
          Text(
            "\$$price",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("free shipping", style: TextStyle(color: AppColor.green),),
          IconButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart({
                "name": name,
                "price": double.parse(price),
                "image": image,

              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$name added to cart")),
              );
            },
             icon: Icon(Icons.add_box, color: AppColor.orange),iconSize: 40,
          ),
        ],
      ),
    );
  }
}
