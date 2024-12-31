import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  bool _passwordVisible = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name!';
    }
    return null;
  }

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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password!';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match!';
    }
    return null;
  }

  Future SignUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _emailController.text.trim(), password:_passwordController.text.trim());
      // Mettre à jour le nom dans le profil utilisateur Firebase
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Enregistrer les données dans Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'fullname': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(), // Timestamp du moment d'inscription
      });


      if (userCredential.user != null) {
        // Naviguer vers la page de connexion (login)
        Navigator.pushReplacementNamed(context, '/login');
      }
    }on FirebaseAuthException catch (e) {
      // Mdp De Moins De 6 Caractères
      if (e.code.contains("weak-password")) {
        Fluttertoast.showToast(msg: "Votre mot de passe doit contenir au moins 6 caractères.");
      }
      // Email Au Mauvais Format
      if (e.code.contains("invalid-email")) {
        Fluttertoast.showToast(msg: "Votre email n'a pas un format valide.");
      }
      // Adresse Déjà Utilisé
      if (e.code.contains("email-already-in-use")){
        Fluttertoast.showToast(msg: "Cette adresse mail est déjà utilisée.");
      }
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Register',
            style: TextStyle(fontSize: 30, color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'images/logo_flut.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: !_passwordVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: _passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: !_passwordVisible,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: _passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                validator: _validateConfirmPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignUp();
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Already have an account? Login here!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
