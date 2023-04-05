class Users {
  String gender;
  String email;
  String phone;
  final UserName name;
  final Picture pic;

  Users({
    required this.email,
    required this.gender,
    required this.phone,
    required this.name,
    required this.pic,
  });
}

class UserName {
  final title;
  final first;
  final last;

  UserName({
    required this.first,
    required this.last,
    required this.title,
  });
}

class Picture {
  final thumbnail;
  Picture({this.thumbnail});
}
