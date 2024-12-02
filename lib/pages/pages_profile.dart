import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr9/pages/page_home.dart';
import 'package:pr9/pages/pages_auth.dart';
import 'package:pr9/pages/pages_orders_history.dart';
import '../data/profiles.dart';
import '../models/profile.dart';
import '../widgets/widget_multiline_label.dart';
import '../data/pallets.dart';
import './pages_profile_edit.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        PROFILE_CONST.avatarFile = _imageFile;
      });
    }
  }

  void _editProfile() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(profile: PROFILE_CONST),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        PROFILE_CONST = updatedProfile;
      });
    }
  }

  void _leaveAccount() {
    setState(() {
      PROFILE_CONST = Profile.defaultProfile; // Reset to default profile
    });

    // Navigate to the AuthScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is authorized
    if (PROFILE_CONST.id == -1) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomDarkTheme.baseColor,
          title: Center(
            child: Text(
              'Unauthorized',
              style: TextStyle(color: CustomDarkTheme.backgroundColor),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You are not authorized.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomDarkTheme.baseColor,
                ),
                child: Text('Proceed.', style: TextStyle(color: CustomDarkTheme.backgroundColor)),
              ),
            ],
          ),
        ),
      );
    }

    // Display Profile for authorized users
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomDarkTheme.baseColor,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomDarkTheme.backgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: _leaveAccount,
            icon: Icon(Icons.logout, color: CustomDarkTheme.backgroundColor),
            tooltip: 'Leave Account',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: PROFILE_CONST.avatarFile != null
                        ? Image.file(
                      PROFILE_CONST.avatarFile!,
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      PROFILE_CONST.avatarLink,
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomMultilineLabel.create(
                'Date of birth:', DateFormat('dd/MM/yyyy').format(PROFILE_CONST.dateBorn)),
            CustomMultilineLabel.create('Email:', PROFILE_CONST.email),
            CustomMultilineLabel.create('Name:', PROFILE_CONST.name),
            CustomMultilineLabel.create('Surname:', PROFILE_CONST.surname),
            CustomMultilineLabel.create('Middlename:', PROFILE_CONST.middlename),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: _editProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Edit profile',
                  style: TextStyle(
                    color: CustomDarkTheme.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrdersHistoryPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Orders history',
                  style: TextStyle(
                    color: CustomDarkTheme.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
