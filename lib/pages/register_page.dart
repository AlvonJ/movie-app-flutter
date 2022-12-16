import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/models/utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let's register.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to movie app.",
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Theme.of(context).primaryColor,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => email != null && email.isEmpty
                        ? 'Please enter an email'
                        : null,
                    decoration: InputDecoration(
                        labelText: "Email",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.white54, fontSize: 22),
                        labelStyle: const TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white24),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(16))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Theme.of(context).primaryColor,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                    obscureText: true,
                    // obscuringCharacter: '*',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        : null,
                    decoration: InputDecoration(
                        labelText: "Password",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.white54, fontSize: 22),
                        labelStyle: const TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white24),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(16))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    cursorColor: Theme.of(context).primaryColor,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                    obscureText: true,
                    // obscuringCharacter: '*',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value != null && value != passwordController.text
                            ? 'Confirmation password is not same'
                            : null,
                    decoration: InputDecoration(
                        labelText: "Confirmation Password",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.white54, fontSize: 22),
                        labelStyle: const TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white24),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(16))),
                  ),
                  const SizedBox(height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          context.goNamed('login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final isValid = formKey.currentState!.validate();

                          if (!isValid) return;

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => Center(
                                      child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )));

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim())
                              .then((userRegister) => users
                                  .doc(userRegister.user!.uid)
                                  .set({'money': 0}))
                              .then((_) {
                            Navigator.of(context, rootNavigator: true).pop();

                            showTopSnackBar(
                                Overlay.of(context) as OverlayState,
                                displayDuration:
                                    const Duration(milliseconds: 1500),
                                const CustomSnackBar.success(
                                    message:
                                        'Success, your account has been created!'));

                            context.goNamed('login');
                          }).catchError((e) {
                            Navigator.of(context, rootNavigator: true).pop();

                            showTopSnackBar(Overlay.of(context) as OverlayState,
                                CustomSnackBar.error(message: e.message));
                            // Utils.showSnackBarError(e.message);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
