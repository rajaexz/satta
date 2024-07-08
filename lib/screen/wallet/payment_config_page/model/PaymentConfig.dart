// models/payment_config.dart
class PaymentConfig {
  String supportNumber;
  AvailableMethods availableMethods;
  AvailableMethodsDetails availableMethodsDetails;

  PaymentConfig({
    required this.supportNumber,
    required this.availableMethods,
    required this.availableMethodsDetails,
  });

  factory PaymentConfig.fromJson(Map<String, dynamic> json) {
    return PaymentConfig(
      supportNumber: json['support_number'],
      availableMethods: AvailableMethods.fromJson(json['available_methods']),
      availableMethodsDetails: AvailableMethodsDetails.fromJson(json['available_methods_details']),
    );
  }
}

class AvailableMethods {
  bool bankAccount;
  bool upi;
  bool qrCode;
  List<PaymentGateway> paymentGateway;

  AvailableMethods({
    required this.bankAccount,
    required this.upi,
    required this.qrCode,
    required this.paymentGateway,
  });

  factory AvailableMethods.fromJson(Map<String, dynamic> json) {
    var list = json['payment_gateway'] as List;
    List<PaymentGateway> gatewayList = list.map((i) => PaymentGateway.fromJson(i)).toList();

    return AvailableMethods(
      bankAccount: json['bank_account'],
      upi: json['upi'],
      qrCode: json['qr_code'],
      paymentGateway: gatewayList,
    );
  }
}

class PaymentGateway {
  String type;
  String video;
  String notice;

  PaymentGateway({
    required this.type,
    required this.video,
    required this.notice,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) {
    return PaymentGateway(
      type: json['type'],
      video: json['video'],
      notice: json['notice'],
    );
  }
}

class AvailableMethodsDetails {
  String defaultMethod;
  String upiLimit;
  String amountConfiguration;
  PaymentMethod upi;
  PaymentMethod smallAmountUpi;
  PaymentMethod largeAmountUpi;
  BankAccount bankAccount;
  QrCode qrCode;

  AvailableMethodsDetails({
    required this.defaultMethod,
    required this.upiLimit,
    required this.amountConfiguration,
    required this.upi,
    required this.smallAmountUpi,
    required this.largeAmountUpi,
    required this.bankAccount,
    required this.qrCode,
  });

  factory AvailableMethodsDetails.fromJson(Map<String, dynamic> json) {
    return AvailableMethodsDetails(
      defaultMethod: json['default_method'],
      upiLimit: json['upi_limit'],
      amountConfiguration: json['amount_configuration'],
      upi: PaymentMethod.fromJson(json['upi']),
      smallAmountUpi: PaymentMethod.fromJson(json['small_amount_upi']),
      largeAmountUpi: PaymentMethod.fromJson(json['large_amount_upi']),
      bankAccount: BankAccount.fromJson(json['bank_account']),
      qrCode: QrCode.fromJson(json['qr_code']),
    );
  }
}

class PaymentMethod {
  String upiName;
  String upiId;
  String remark;
  String type;

  PaymentMethod({
    required this.upiName,
    required this.upiId,
    required this.remark,
    required this.type,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      upiName: json['upi_name'],
      upiId: json['upi_id'],
      remark: json['remark'],
      type: json['type'],
    );
  }
}

class BankAccount {
  String video;
  String notice;
  String bankName;
  String accountHolderName;
  String accountNo;
  String ifscCode;

  BankAccount({
    required this.video,
    required this.notice,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNo,
    required this.ifscCode,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      video: json['video'],
      notice: json['notice'],
      bankName: json['bank_name'],
      accountHolderName: json['account_holder_name'],
      accountNo: json['account_no'],
      ifscCode: json['ifsc_code'],
    );
  }
}

class QrCode {
  String video;
  String notice;
  String qrImage;
  String qrUpiId;

  QrCode({
    required this.video,
    required this.notice,
    required this.qrImage,
    required this.qrUpiId,
  });

  factory QrCode.fromJson(Map<String, dynamic> json) {
    return QrCode(
      video: json['video'],
      notice: json['notice'],
      qrImage: json['qr_image'],
      qrUpiId: json['qr_upi_id'],
    );
  }
}
