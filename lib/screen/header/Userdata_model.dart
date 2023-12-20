class UserProfile {
  final String? name;
  final String? email;
  final String? phone;
  final String? userStatus;
  final String? image;
  final String? addharImage;
  final String? panImage;
  final String? accountNo;
  final String? ifscCode;
  final String? bankName;

  UserProfile({
    this.name,
    this.email,
    this.phone,
    this.userStatus,
    this.image,
    this.addharImage,
    this.panImage,
    this.accountNo,
    this.ifscCode,
    this.bankName,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userStatus: json['user_status'],
      image: json['image'],
      addharImage: json['addhar_img'],
      panImage: json['pan_img'],
      accountNo: json['account_no'],
      ifscCode: json['ifsc_code'],
      bankName: json['bank_name'],
    );
  }
}
