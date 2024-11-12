import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/profiles.dart';
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
  @override
  void initState() {
    super.initState();
  }

  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);

        profile.localAvatar = _imageFile;
      });
    }
  }

  void _editProfile() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(profile: profile),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        profile = updatedProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    child: profile.localAvatar != null
                        ? Image.file(
                      profile.localAvatar!,
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      profile.avatarLink,
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomMultilineLabel.create('Date of birth:', DateFormat('dd/MM/yyyy').format(profile.dateTime)),
            CustomMultilineLabel.create('Email:', profile.email),
            CustomMultilineLabel.create('Name:', profile.name),
            CustomMultilineLabel.create('Surname:', profile.surname),
            CustomMultilineLabel.create('Middlename:', profile.middleName),
            const SizedBox(height: 100),
            Center(
              child:
              SizedBox(
                width: 200.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: _editProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomDarkTheme.baseColor,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: CustomDarkTheme.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Font size can remain unchanged
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
