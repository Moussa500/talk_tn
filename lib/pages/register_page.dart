import 'package:flutter/material.dart';
import 'package:talk_tn/services/auth/auth_service.dart';
import 'package:talk_tn/components/my_button.dart';
import 'package:talk_tn/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  // tap to geo to register page
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  void register(BuildContext context) {
    final authService = AuthService();
    //passwords match->creatte user
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        authService.signUpWithEmailPassword(
            _emailController.text, _passwordController.text,_nameController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    //passwords don't match -> show error to user
    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords dont match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.send_outlined,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 50,
              ),
              //welcome back message
              Text(
                "Create an account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 25,),
              //name textfield
              MyTextField(
                hintText: "Name",
                obscureText: false,
                controller: _nameController,
              ),
              //pw textfield
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              //confirm pw textfield
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  obscureText: true,
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController),
              //login button
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Register",
                onTap: () {
                  register(context);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ?"),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
