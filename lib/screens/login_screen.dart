import 'package:flutter/material.dart';
import 'package:flutter_flow_app/controller/login_controller.dart';
import 'package:flutter_flow_app/screens/animation.dart';
import 'package:flutter_flow_app/screens/home_screen.dart';
import 'package:flutter_flow_app/screens/register_screen.dart';
import 'package:flutter_flow_app/widgets/text_widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget buildErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          errorText,
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const StarrySkyView(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextWidget(
                        text: "Welcome Back!",
                        fontSize: 28,
                        color: Color(0xFF490355),
                      ),
                      const SizedBox(height: 10),
                      const TextWidget(
                        text: "Login to your account",
                        fontSize: 16,
                        color: Color(0xFF490355),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon:
                              const Icon(Icons.mail, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Obx(() => _controller.emailError.isNotEmpty
                          ? buildErrorText(_controller.emailError.value)
                          : Container()),
                      const SizedBox(height: 20),
                      Obx(
                        () => TextFormField(
                          controller: _passwordController,
                          obscureText: !_controller.isPasswordVisible.value,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue,
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: _controller.togglePasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Obx(() => _controller.passwordError.isNotEmpty
                          ? buildErrorText(_controller.passwordError.value)
                          : Container()),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Checkbox(
                              value: _controller.isRememberMe.value,
                              onChanged: (value) {
                                _controller.updateIsRememberMe();
                              },
                            ),
                          ),
                          const TextWidget(
                              text: "Remember Me", color: Colors.black),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          bool isLoggedIn = await _controller.signInWithEmail(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          if (isLoggedIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const TextWidget(
                            text: "Log In",
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: "Don't have an account?",
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const TextWidget(
                              text: " Register",
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
