import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/theme/app_color.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/core/utils/routes.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool accepted = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> register() async {
    var result = await auth.register(
      email.text.trim(),
      password.text.trim(),
    );

    if (!mounted) return;

    if (result.user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.uid)
          .set({
        "name": name.text,
        "email": email.text,
      });

      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error ?? "Register Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // Name
              CustomTextFormField(
                hintText: "Name",
                prefixIcon: Icons.person,
                controller: name,
                validator: (v) {
                  if (v == null || v.length < 3) {
                    return "Min 3 chars";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Email
              CustomTextFormField(
                hintText: "Email",
                prefixIcon: Icons.email,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              //Password
              CustomTextFormField(
                hintText: "Password",
                prefixIcon: Icons.lock,
                controller: password,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.length < 6) {
                    return "Min 6 chars";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Terms
              Row(
                children: [
                  Checkbox(
                    value: accepted,
                    onChanged: (v) {
                      setState(() => accepted = v!);
                    },
                  ),
                  const Text("Accept terms"),
                ],
              ),

              const SizedBox(height: 20),

              // Button
              CustomButton(text: 
              'Register',
              textColor:AppColor.white,
               onPressed: (){
                 {
                  if (!_formKey.currentState!.validate()) return;

                  if (!accepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Accept terms first")),
                    );
                    return;
                  }

                  register();
              }})
            ],
          ),
        ),
      ),
    );
  }
}