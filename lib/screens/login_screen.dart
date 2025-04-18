import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/storage_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  final String previousRoute;
  LoginScreen({this.previousRoute = '/home'});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoginMode = true;
  String? errorMessage;
  bool showError = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
      showError = true;
    });
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  String? validatePassword(String password) {
    if (password.length < 8) return tr("password_length");
    if (!RegExp(r'[A-Z]').hasMatch(password)) return tr("password_uppercase");
    if (!RegExp(r'[a-z]').hasMatch(password)) return tr("password_lowercase");
    if (!RegExp(r'[0-9]').hasMatch(password)) return tr("password_number");
    return null;
  }

  String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return tr("invalid_email");
    return null;
  }

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty) {
      showErrorMessage(tr("enter_email"));
      return;
    }

    String? emailError = validateEmail(email);
    if (emailError != null) {
      showErrorMessage(emailError);
      return;
    }

    if (password.isEmpty) {
      showErrorMessage(tr("enter_password"));
      return;
    }

    final user = await StorageHelper.loginUser(email, password);

    if (user != null) {
      await StorageHelper.setCurrentUser(email);
      context.go('/profile');
    } else {
      showErrorMessage(tr("user_not_found"));
    }
  }

  void register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      showErrorMessage(tr("enter_name"));
      return;
    }

    if (email.isEmpty) {
      showErrorMessage(tr("enter_email"));
      return;
    }

    String? emailError = validateEmail(email);
    if (emailError != null) {
      showErrorMessage(emailError);
      return;
    }

    if (password.isEmpty) {
      showErrorMessage(tr("enter_password"));
      return;
    }

    if (password != confirmPassword) {
      showErrorMessage(tr("password_mismatch"));
      return;
    }

    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      showErrorMessage(passwordError);
      return;
    }

    await StorageHelper.saveUser(email, password);

    setState(() {
      errorMessage = tr("login_success");
      showError = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showError = false;
          isLoginMode = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        context.go(widget.previousRoute);
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/icons/neo.png',
                              height: 250,
                              width: 400,
                            ),
                          ),
                          SizedBox(height: 20),
                          if (!isLoginMode)
                            TextField(
                              controller: nameController,
                              decoration: inputDecoration(tr("name")),
                              style: TextStyle(color: Colors.white),
                            ),
                          if (!isLoginMode) SizedBox(height: 12),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecoration(tr("email")),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: inputDecoration(tr("password")),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 12),
                          if (!isLoginMode)
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: inputDecoration(tr("confirm_password")),
                              style: TextStyle(color: Colors.white),
                            ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: isLoginMode ? login : register,
                            child: Text(
                              isLoginMode ? tr("login") : tr("register"),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 45, 45, 45),
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 5,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginMode = !isLoginMode;
                                showError = false;
                              });
                            },
                            child: Text(
                              isLoginMode ? tr("dont_have_account") : tr("already_have_account"),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      tr("data_protection"),
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: showError ? 20 : -100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: errorMessage?.contains(tr("login_success")) == true
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        errorMessage?.contains(tr("register_success")) == true
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          errorMessage ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showError = false;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 20,
                        ),
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

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Color.fromARGB(255, 45, 45, 45),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
