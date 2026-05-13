import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/theme/app_color.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() =>
      _AddProductScreenState();
}

class _AddProductScreenState
    extends State<AddProductScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController name =
      TextEditingController();

  final TextEditingController price =
      TextEditingController();

  final TextEditingController description =
      TextEditingController();

  bool isLoading = false;

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {

    name.dispose();

    price.dispose();

    description.dispose();

    super.dispose();
  }

  Future<void> pickImage() async {

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {

        selectedImage = File(image.path);
      });
    }
  }
Future<void> addProduct() async {

  if (selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select image first")),
    );
    return;
  }

  setState(() => isLoading = true);

  try {

  // ImgBB
    const imageUrl = "https://i.ibb.co/8DD1BFmw/s.png";

    await FirebaseFirestore.instance.collection("products").add({
      "name": name.text,
      "price": double.parse(price.text),
      "image": imageUrl,
      "description": description.text,
      "createdAt": Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product Added")),
    );

    name.clear();
    price.clear();
    description.clear();

    setState(() {
      selectedImage = null;
    });

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );

  } finally {
    setState(() => isLoading = false);
  }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Product"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: SingleChildScrollView(

            child: Column(

              children: [

                GestureDetector(

                  onTap: pickImage,

                  child: Container(

                    height: 180,

                    width: double.infinity,

                    decoration: BoxDecoration(

                      border: Border.all(
                        color: AppColor.grey,
                      ),

                      borderRadius:
                          BorderRadius.circular(12),
                    ),

                    child: selectedImage != null

                        ? ClipRRect(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),

                            child: Image.file(

                              selectedImage!,

                              fit: BoxFit.cover,
                            ),
                          )

                        : const Column(

                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              Icon(
                                Icons.image,
                                size: 50,
                              ),

                              SizedBox(height: 10),

                              Text(
                                "Tap to select image",
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                CustomTextFormField(

                  hintText: "Product Name",

                  prefixIcon: Icons.shopping_bag,

                  controller: name,

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Enter product name";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                CustomTextFormField(

                  hintText: "Price",

                  prefixIcon:
                      Icons.attach_money,

                  keyboardType:
                      TextInputType.number,

                  controller: price,

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Enter price";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                CustomTextFormField(

                  hintText: "Description",

                  prefixIcon: Icons.description,

                  controller: description,
                ),

                const SizedBox(height: 30),

                SizedBox(

                  width: double.infinity,

                  child: CustomButton(

                    onPressed: () async {

                      if (_formKey.currentState!
                          .validate()) {

                        await addProduct();
                      }
                    },

                    textColor: AppColor.white,

                    backgroundColor:
                        AppColor.orange,

                    isLoading: isLoading,

                    text: "Add Product",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}