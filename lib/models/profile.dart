import 'dart:io';

class Profile {
  final int id;
  final String name;
  final String surname;
  final String middlename;
  final DateTime dateBorn;
  final String email;
  final String avatarLink;
  File? avatarFile;

  Profile({
    required this.id,
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
      id: id,
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
    id: -1,
    name: 'Miroslaw',
    surname: 'Javushkin',
    middlename: 'Evgenievich',
    dateBorn: DateTime.now(),
    email: 'javu.mira@github.dev',
  );

  factory Profile.fromJSON(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      surname: json['surname'] as String,
      middlename: json['middlename'] as String,
      avatarLink: json['avatarLink'] as String,
      dateBorn: DateTime.parse(json['dateborn']),
    );
  }

  Object? toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'surname': this.surname,
      'middlename': this.middlename,
      'avatarLink': this.avatarLink,
      'dateborn': this.dateBorn.toLocal().toString()
    };
  }
}
