class UserDetails {
  final String message;
  final String code;
  final String status;
  final UserData? data;

  UserDetails({
    required this.message,
    required this.code,
    required this.status,
    this.data,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      message: json['message'] ?? '',
      code: json['code'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String username;
  final String mobile;
  final String? email;
  final String? bankName;
  final String? accountHolderName;
  final String? ifscCode;
  final String? branchAddress;
  final String? bankAccountNo;
  final String? paytmMobileNo;
  final String? phonepeMobileNo;
  final String? gpayMobileNo;
  final String? pendingNoti;

  UserData({
    required this.username,
    required this.mobile,
    this.email,
    this.bankName,
    this.accountHolderName,
    this.ifscCode,
    this.branchAddress,
    this.bankAccountNo,
    this.paytmMobileNo,
    this.phonepeMobileNo,
    this.gpayMobileNo,
    this.pendingNoti,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'],
      bankName: json['bank_name'],
      accountHolderName: json['account_holder_name'],
      ifscCode: json['ifsc_code'],
      branchAddress: json['branch_address'],
      bankAccountNo: json['bank_account_no'],
      paytmMobileNo: json['paytm_mobile_no'],
      phonepeMobileNo: json['phonepe_mobile_no'],
      gpayMobileNo: json['gpay_mobile_no'],
      pendingNoti: json['pending_noti'],
    );
  }
}
