//Todo User model

class User {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? photo;
  final String? dateOfBirth;
  final String? accessToken;
  final String? refreshToken;
  final String? password;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.photo,
    this.dateOfBirth,
    this.accessToken,
    this.refreshToken,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json.containsKey('id') ? json['id'].toString() : null,
      username: json.containsKey('username') ? json['username'] : null,
      firstName: json.containsKey('first_name') ? json['first_name'] : null,
      lastName: json.containsKey('last_name') ? json['last_name'] : null,
      email: json.containsKey('email') ? json['email'] : null,
      photo: json.containsKey('photo') ? json['photo'] : null,
      dateOfBirth:
          json.containsKey('date_of_birth') ? json['date_of_birth'] : null,
      accessToken:
          json.containsKey('access_token') ? json['access_token'] : null,
      refreshToken:
          json.containsKey('refresh_token') ? json['refresh_token'] : null,
      password: json.containsKey('password') ? json['password'] : null,
    );
  }

  factory User.fromJsonForRegister(Map<String, dynamic> json) {
    return User(
      id: json.containsKey('id') ? json['id'].toString() : null,
      username: json.containsKey('username') ? json['username'] : null,
      email: json.containsKey('email') ? json['email'] : null,
    );
  }

  factory User.fromJsonForLogin(Map<String, dynamic> json) {
    return User(
      username: json.containsKey('username') ? json['username'] : null,
      email: json.containsKey('email') ? json['email'] : null,
      accessToken:
          json.containsKey('access_token') ? json['access_token'] : null,
      refreshToken:
          json.containsKey('refresh_token') ? json['refresh_token'] : null,
    );
  }

  Map<String, dynamic> toJsonForRegister() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonForLogin() {
    return {
      'username': username,
      'password': password,
    };
  }
}
