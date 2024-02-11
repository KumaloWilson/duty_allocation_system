import 'package:duty_allocation_system/api_services/api_methods.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/views/screens/mainscreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final deptController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    deptController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: deptController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : MaterialButton(
              onPressed: () async {
                if (!_validateInputs()) return;

                setState(() {
                  _isLoading = true;
                });

                final signUpResponse = await ApiAssistants.signUp(
                  username: usernameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  dept: deptController.text.trim(),
                );

                setState(() {
                  _isLoading = false;
                });

                if (signUpResponse != null) {
                  Helpers.permanentNavigator(context, HomeScreen());
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (usernameController.text.trim().isEmpty ||
        deptController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }

    if (!emailController.text.trim().contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return false;
    }

    // You can add more validation logic here if needed

    return true;
  }
}
