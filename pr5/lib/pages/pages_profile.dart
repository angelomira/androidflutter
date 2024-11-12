import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr5/models/car.dart';
import 'package:pr5/widgets/widget_multline_label.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/pallets.dart';
import '../models/profile.dart';  // Make sure to import your theme

class ProfileScreen extends StatefulWidget {
  final Profile profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  color: CustomDarkTheme.backgroundColor,  // Keep text white for contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView( // Added ScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CircleAvatar(
                      radius: 64.0,
                      backgroundImage: NetworkImage(widget.profile.avatarLink),
                      backgroundColor: CustomDarkTheme.accentColor,
                    ),
                  )
              )
            ),
            const SizedBox(height: 20),
            CustomMultilineLabel.create('Date of birth:', DateFormat('dd/MM/yyyy').format(widget.profile.dateTime)),
            CustomMultilineLabel.create('Email:', widget.profile.email),
            CustomMultilineLabel.create('Name:', widget.profile.name),
            CustomMultilineLabel.create('Surname:', widget.profile.surname),
            CustomMultilineLabel.create('Middlename:', widget.profile.middleName)
          ]
        )
      ),
    );
  }
}
