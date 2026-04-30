import 'package:ecommerce_app/core/theme/app_color.dart';
import 'package:ecommerce_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                   CustomTextFormField(
                    hintText: "Full name",
                    prefixIcon: Icons.person,
                    controller: name,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      else if (value.length <3) {
                        return "Name must be more than 3 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextFormField(
                    hintText: "Email",
                    prefixIcon: Icons.email,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomTextFormField(
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    controller: password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 chars";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) => {}),
                      Text(
                        "I accept the condotions",
                        style: TextStyle(color: AppColor.grey),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Privacy",
                          style: TextStyle(color: AppColor.heading),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'sign up',
                      textColor: AppColor.white,
                      backgroundColor: AppColor.orange,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, Routes.main);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
