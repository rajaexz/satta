class UserDetails {
  final String name;
  final String email;
  final String phone;
  final String image;
  final String bankName;
  final String accountNo;
  final String ifscCode;
  UserDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.bankName,
    required this.accountNo, required this.ifscCode,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'] ?? "No Name",
      email: json['email'] ?? "No Email",
      phone: json['phone'] ?? "No phone",
      image: json['image'] ?? "",
      bankName: json['bank_name'] ?? "No Name",
      accountNo: json['account_no'] ?? "No Account",
      ifscCode: json['ifsc_code'] ?? "No Ifsc"
    );
  }
}
