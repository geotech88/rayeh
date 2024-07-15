import 'dart:convert';

List<User> usersFromJson(String str) => List<User>.from(
      jsonDecode(str).map((x) => User.fromJson(x)),
    );

User userFromJson(String str) => User.fromJson(
      jsonDecode(str),
    );

class User {
  final int id;
  final String auth0UserId;
  final String name;
  final String email;
  final String? profession;
  final String path;
  final String createdAt;
  final String updatedAt;
  final Role? role;

  User({
    required this.id,
    required this.auth0UserId,
    required this.name,
    required this.email,
    required this.profession,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      auth0UserId: json["auth0UserId"],
      name: json["name"],
      email: json["email"],
      profession: json["profession"] ?? "not definded",
      path: json["path"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "auth0UserId": auth0UserId,
      "name": name,
      "email": email,
      "profession": profession,
      "path": path,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "role": role!.toJson(),
    };
  }
}

class Role {
  final int id;
  final String name;

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
