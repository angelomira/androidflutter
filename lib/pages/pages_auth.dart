import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr9/data/profiles.dart';
import 'package:pr9/pages/page_home.dart';
import 'package:pr9/pages/pages_profile.dart';
import 'package:pr9/pages/pages_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/pallets.dart';
import '../services/service_api_profiles.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final profile = await _apiService.login(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (profile == null) {
          setState(() {
            _errorMessage = 'Invalid credentials. Please try again.';
          });
          return;
        }

        UserCredential userCredential = await _firebaseAuth.signInAnonymously();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        PROFILE_CONST = profile;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile', json.encode(profile.toJson()));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
              (route) => false, // Remove all previous routes
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Login form:')
      ],)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.baseColor,
                        width: 1.5,
                      ),
                    ),
                    hintText: 'Email',
                    hintStyle:
                    TextStyle(color: CustomDarkTheme.backgroundColor),
                    labelText: 'Enter your email:',
                    labelStyle: TextStyle(color: CustomDarkTheme.accentColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.baseColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.accentColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  cursorColor: CustomDarkTheme.accentColor,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                //-----------------------------------------------
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.baseColor,
                        width: 1.5,
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle:
                    TextStyle(color: CustomDarkTheme.backgroundColor),
                    labelText: 'Enter your password:',
                    labelStyle: TextStyle(color: CustomDarkTheme.accentColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.baseColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: CustomDarkTheme.accentColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  cursorColor: CustomDarkTheme.accentColor,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _login,
                  child: Text('Enter account', style: TextStyle(
                    color: CustomDarkTheme.baseColor,
                    fontSize: 16
                  ),),
                ),
                const SizedBox(height: 16.0,),
                Text('Don\'t have an account?', style: TextStyle(
                  fontSize: 16,
                  color: CustomDarkTheme.additionalColor
                ),),
                const SizedBox(height: 8.0,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            (route) => true, // Remove all previous routes
                      );
                    });
                  },
                  child: Text('Register', style: TextStyle(
                      color: CustomDarkTheme.additionalColor,
                      fontSize: 16
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}