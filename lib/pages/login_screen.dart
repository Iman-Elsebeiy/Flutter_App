import 'package:ecommerce_app/core/theme/app_color.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/core/utils/routes.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() => isLoading = true);

    var result = await auth.login(
      email.text.trim(),
      password.text.trim(),
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (result.user != null) {
      Navigator.pushReplacementNamed(context, Routes.main);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error ?? "Login Failed")),
      );
    }
  }

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
                    "Login",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

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

                  // Password
                  CustomTextFormField(
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    controller: password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Min 6 chars";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "LOGIN",
                      textColor: AppColor.white,
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  //  Navigate to Register
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.reg);
                    },
                    child: const Text("Create Account"),
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