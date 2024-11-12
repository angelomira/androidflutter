import 'dart:io';

class Profile {
  final String name;
  final String surname;
  final String middleName;
  final DateTime dateTime;
  final String email;
  final String avatarLink;
  File? localAvatar;

  Profile({
    required this.name,
    required this.surname,
    required this.middleName,
    required this.dateTime,
    required this.email,
    this.avatarLink = 'https://via.placeholder.com/160',
    this.localAvatar,
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
      middleName: middleName ?? this.middleName,
      dateTime: dateTime ?? this.dateTime,
      email: email ?? this.email,
      avatarLink: avatarLink ?? this.avatarLink,
      localAvatar: localAvatar ?? this.localAvatar,
    );
  }

  static Profile defaultProfile = Profile(
    name: 'Miroslaw',
    surname: 'Javushkin',
    middleName: 'Evgenievich',
    dateTime: DateTime.now(),
    email: 'javu.mira@github.dev',
  );
}
