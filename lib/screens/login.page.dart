import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passVisible = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email!';
    }
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address!';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password!';
    }
    if (value.length < 6) return 'Password must be at least 6 characters!';
    return null;
  }
  Future<void> SignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _mailController.text.trim(), password:_passwordController.text.trim());
      if (userCredential.user != null) {
        print("Signed in: ${userCredential.user?.email}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-in successful!")),);
        // Naviguer vers la page d'accueil (Home) après une connexion réussie
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      // Bloc spécifique pour FirebaseAuthException
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email";
          break;
        case 'wrong-password':
          message = "Wrong password provided";
          break;
        case 'invalid-email':
          message = "The email address is invalid";
          break;
        case 'user-disabled':
          message = "This user account has been disabled.";
          break;
        case 'too-many-requests':
          message = "Too many attempts. Please try again later.";
          break;
        default:
          message = "An error occurred. Try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      print("FirebaseAuthException: $message");
    } on SocketException catch (e){
      //bloc specifique pour les problemes de reseau
      String message = "Network error: Please check your internet connection.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)),);
      print("SocketException: $e");
    }catch(e){
      //bloc general pour les autres erreurs
      String message="An unexpected error occurred.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)),);
      print("Unknown error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Login Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'images/logo_flut.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 22),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: !_passVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                      icon: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    SignIn();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Don\'t have an account? Register here!',
                      style: TextStyle(color: Colors.green),
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
