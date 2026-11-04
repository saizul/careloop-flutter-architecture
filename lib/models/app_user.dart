class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.userType,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final String userType;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'userType': userType,
    };
  }
}
