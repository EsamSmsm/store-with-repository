import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
  });

  @override
  List<Object> get props {
    return [
      id,
      username,
    ];
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {required bool isLogin}) {
    return UserModel(
      id: map['id'] as int,
      username: isLogin ? map['name'] as String : map['username'] as String,
      avatarUrl: isLogin
          ? (map['avatar_urls'] as Map<String, dynamic>)['96'] as String
          : map['avatar_url'] as String,
    );
  }
}
