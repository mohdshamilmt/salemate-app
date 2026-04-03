
import 'package:flutter/material.dart';
import 'package:post_data_to_api_sample/controller/home_screen_controller.dart';
import 'package:post_data_to_api_sample/view/home_screen/dashboard_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernamecntrlr = TextEditingController();
  final TextEditingController passwordctrlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Title
                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Username Field
                TextFormField(
                  controller: usernamecntrlr,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username required";
                    }
                    if (value.length < 5) {
                      return "Minimum 5 characters required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // 🔥 Password Field
                TextFormField(
                  controller: passwordctrlr,
                  obscureText: isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }
                    if (value.length < 6) {
                      return "Minimum 6 characters required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var success = await context
                            .read<HomeScreenController>()
                            .postData(usernamecntrlr.text, passwordctrlr.text);
                        if (success) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),(route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login Failed")),
                          );
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),

                const SizedBox(height: 20),

                // Footer
                Center(
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
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
