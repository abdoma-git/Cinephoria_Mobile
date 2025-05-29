class User {
  final int id;
  final String email;
  final String nom;

  User({
    required this.id,
    required this.email,
    required this.nom,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      nom: json['nom'],
    );
  }
} 