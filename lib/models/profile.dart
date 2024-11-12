import 'dart:io';

class Profile {
  final String name;
  final String surname;
  final String middlename;
  final DateTime dateBorn;
  final String email;
  final String avatarLink;
  File? avatarFile;

  Profile({
    required this.name,
    required this.surname,
    required this.middlename,
    required this.dateBorn,
    required this.email,
    this.avatarLink = 'https://via.placeholder.com/160',
    this.avatarFile,
  });

  Profile copyWith({
    String? name,
    String? surname,
    String? middleName,
    DateTime? dateTime,
    String? email,
    String? avatarLink,
    File? localAvatar,
  }) {
    return Profile(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      middlename: middleName ?? this.middlename,
      dateBorn: dateTime ?? this.dateBorn,
      email: email ?? this.email,
      avatarLink: avatarLink ?? this.avatarLink,
      avatarFile: localAvatar ?? this.avatarFile,
    );
  }

  static Profile defaultProfile = Profile(
    name: 'Miroslaw',
    surname: 'Javushkin',
    middlename: 'Evgenievich',
    dateBorn: DateTime.now(),
    email: 'javu.mira@github.dev',
  );
}
