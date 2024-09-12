
import 'package:flutter/material.dart';
import 'package:talk_tn/services/auth/auth_service.dart';
import 'package:talk_tn/components/my_button.dart';
import 'package:talk_tn/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //tap to go to register page
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  //login method
  void login(BuildContext context) async{
    //auth service
    final authService = AuthService();
    //try login
    try {
      await authService.signInWithEmailPassword(_emailController.text,_passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(context: context, builder: (context)=>AlertDialog(title: Text(e.toString())),);
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
                "Welcome back!",
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
              //pw textfield
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              //login button
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Login",
                onTap: () {
                  login(context);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register now",
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
