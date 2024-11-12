import 'package:flutter/material.dart';
import 'package:pr6/data/pallets.dart';
import '../models/profile.dart';
import '../widgets/widget_custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;

  const EditProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController middleNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    surnameController = TextEditingController(text: widget.profile.surname);
    middleNameController = TextEditingController(text: widget.profile.middleName);
    emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    middleNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedProfile = widget.profile.copyWith(
      name: nameController.text,
      surname: surnameController.text,
      middleName: middleNameController.text,
      email: emailController.text,
    );

    Navigator.pop(context, updatedProfile); // Return updated profile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField.create(nameController, 'Enter new name"', 'Name'),
            const SizedBox(height: 20),
            CustomTextField.create(surnameController, 'Enter new surname:', 'Surname'),
            const SizedBox(height: 20),
            CustomTextField.create(middleNameController, 'Enter new middlename:', 'Middlename'),
            const SizedBox(height: 20),
            CustomTextField.create(emailController, 'Enter new email:', 'Email'),
            const SizedBox(height: 80),
            Center(
                child: Text(
                    'If you want to update your profile picture, \njust tap on it.',
                    style: TextStyle(
                      color: CustomDarkTheme.baseColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
              )
            ),
          ],
        ),
      ),
    );
  }
}
