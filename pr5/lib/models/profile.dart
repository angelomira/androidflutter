class Profile {
  final String name;
  final String surname;
  final String middleName;
  final DateTime dateTime;
  final String email;
  final String avatarLink = 'https://via.placeholder.com/160';

  Profile(
      {required this.name,
      required this.surname,
      required this.middleName,
      required this.dateTime,
      required this.email});

  static Profile defaultProfile = new Profile(
      name: 'Miroslaw',
      surname: 'Javushkin',
      middleName: 'Evgenievich',
      dateTime: DateTime.now(),
      email: 'javu.mira@github.com');
}
