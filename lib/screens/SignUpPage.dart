
import 'package:flutter/material.dart';
import 'package:medinfo/core/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isBorderEnable = true;
  bool isObscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  // Dummy signup function
  Future<void> createUser() async {
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /// Title
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: "Font2",
                    color: Colors.black,
                    fontSize: height * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Email
                Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.03),
                    border: Border.all(
                      color:
                      isBorderEnable ? Colors.greenAccent : Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Email",
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(
                        fontFamily: "Font2",
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: height * 0.025),

                /// Password
                Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.03),
                    border: Border.all(
                      color:
                      isBorderEnable ? Colors.greenAccent : Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passWordController,
                    obscureText: isObscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: 'Password',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20,
                      vertical: height * 0.018),
                      hintStyle: const TextStyle(
                        fontFamily: "Font2",
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        icon: Icon(
                          isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password!';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: height * 0.04),

                /// Button
                SizedBox(
                  height: height * 0.055,
                  width: width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      elevation: 10,
                    ),
                    onPressed: createUser,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: "Font2",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: height * 0.022,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.025),

                /// Navigate to Login
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.login);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontFamily: "Font2",
                        color: Colors.black,
                        fontSize: height * 0.022,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontFamily: "Font2",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
