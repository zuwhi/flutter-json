import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  @JsonKey(name: "registration_date_milis")
  final int registrationDateMilis;

  User(this.name, this.email, this.registrationDateMilis);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// void main() {
//   print('ok');
// }
