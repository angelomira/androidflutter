import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr9/pages/page_home.dart';
import '../data/pallets.dart';
import '../data/profiles.dart';
import '../services/service_api_profiles.dart';
import '../widgets/widget_custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // User inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _middlenameController = TextEditingController();
  DateTime? _selectedDate;

  // Password visibility
  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _apiService.registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        surname: _surnameController.text,
        middlename: _middlenameController.text,
        dateBorn: _selectedDate!,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false, // Remove all previous routes
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                const SizedBox(height: 24.0),
                //-----------------------------------------------
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  cursorColor: CustomDarkTheme.accentColor,
                  maxLines: 1,
                ),
                const SizedBox(height: 24.0),
                //-----------------------------------------------
                TextFormField(
                  controller: _repeatPasswordController,
                  obscureText: !_isRepeatPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please repeat your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
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
                    hintText: 'Repeat Password',
                    hintStyle:
                        TextStyle(color: CustomDarkTheme.backgroundColor),
                    labelText: 'Repeat your password:',
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isRepeatPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
                        });
                      },
                    ),
                  ),
                  cursorColor: CustomDarkTheme.accentColor,
                  maxLines: 1,
                ),
                const SizedBox(height: 24.0),
                //-----------------------------------------------
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your name';
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
                    hintText: 'Name',
                    hintStyle:
                        TextStyle(color: CustomDarkTheme.backgroundColor),
                    labelText: 'Enter your name:',
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
                const SizedBox(height: 24.0),
                //-----------------------------------------------
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
                const SizedBox(height: 24.0),
                //-----------------------------------------------
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Date of birth: not selected.'
                            : 'Date of birth: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ],
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
