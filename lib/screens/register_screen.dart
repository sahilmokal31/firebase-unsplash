import 'package:flutter/material.dart';
import 'package:flutter_flow_app/controller/login_controller.dart';
import 'package:flutter_flow_app/screens/home_screen.dart';
import 'package:flutter_flow_app/screens/login_screen.dart';
import 'package:flutter_flow_app/widgets/text_widgets.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController _controller = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: "Create Account",
                    fontSize: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const TextWidget(
                    text: "Register to get started",
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                  const SizedBox(height: 30),
                  buildTextField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.mail,
                  ),
                  Obx(() => _controller.emailError.isNotEmpty
                      ? buildErrorText(_controller.emailError.value)
                      : Container()),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  Obx(() => _controller.passwordError.isNotEmpty
                      ? buildErrorText(_controller.passwordError.value)
                      : Container()),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  Obx(() => _controller.confirmPasswordError.isNotEmpty
                      ? buildErrorText(_controller.confirmPasswordError.value)
                      : Container()),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      bool isRegistered = await _controller.registerWithEmail(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _confirmPasswordController.text.trim(),
                      );
                      if (isRegistered) {
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
                        text: "Register",
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
                        text: "Already have an account?",
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const TextWidget(
                          text: " Log In",
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

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
}
