class DataModel {
  final String bannerMarquee;
  final String withdrawOpenTime;
  final String withdrawCloseTime;
  final String addFundNotice;
  final String withdrawNotice;
  final String appNotice;
  final String appLink;
  final String appStatus;
  final String adminMessage;
  final String shareMessage;
  final ContactDetails contactDetails;
  final BannerImage bannerImage;
  final List<Banner> banner;
  final ProjectStatus projectStatus;

  DataModel({
    required this.bannerMarquee,
    required this.withdrawOpenTime,
    required this.withdrawCloseTime,
    required this.addFundNotice,
    required this.withdrawNotice,
    required this.appNotice,
    required this.appLink,
    required this.appStatus,
    required this.adminMessage,
    required this.shareMessage,
    required this.contactDetails,
    required this.bannerImage,
    required this.banner,
    required this.projectStatus,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      bannerMarquee: json['banner_marquee'],
      withdrawOpenTime: json['withdraw_open_time'],
      withdrawCloseTime: json['withdraw_close_time'],
      addFundNotice: json['add_fund_notice'],
      withdrawNotice: json['withdraw_notice'],
      appNotice: json['app_notice'],
      appLink: json['app_link'],
      appStatus: json['app_status'],
      adminMessage: json['admin_message'],
      shareMessage: json['share_message'],
      contactDetails: ContactDetails.fromJson(json['contact_details']),
      bannerImage: BannerImage.fromJson(json['banner_image']),
      banner: (json['banner'] as List).map((i) => Banner.fromJson(i)).toList(),
      projectStatus: ProjectStatus.fromJson(json['project_status']),
    );
  }
}

class ContactDetails {
  final String whatsappNo;
  final String mobileNo1;
  final String mobileNo2;
  final String email1;
  final String telegramNo;
  final String withdrawProof;

  ContactDetails({
    required this.whatsappNo,
    required this.mobileNo1,
    required this.mobileNo2,
    required this.email1,
    required this.telegramNo,
    required this.withdrawProof,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      whatsappNo: json['whatsapp_no'],
      mobileNo1: json['mobile_no_1'],
      mobileNo2: json['mobile_no_2'],
      email1: json['email_1'],
      telegramNo: json['telegram_no'],
      withdrawProof: json['withdraw_proof'],
    );
  }
}

class BannerImage {
  final String bannerImg1;
  final String bannerImg2;
  final String bannerImg3;

  BannerImage({
    required this.bannerImg1,
    required this.bannerImg2,
    required this.bannerImg3,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) {
    return BannerImage(
      bannerImg1: json['banner_img_1'],
      bannerImg2: json['banner_img_2'],
      bannerImg3: json['banner_img_3'],
    );
  }
}

class Banner {
  final String image;

  Banner({required this.image});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      image: json['image'],
    );
  }
}

class ProjectStatus {
  final String mainMarket;
  final String starlineMarket;
  final String galidesawarMarket;
  final String bannerStatus;
  final String marqueeStatus;

  ProjectStatus({
    required this.mainMarket,
    required this.starlineMarket,
    required this.galidesawarMarket,
    required this.bannerStatus,
    required this.marqueeStatus,
  });

  factory ProjectStatus.fromJson(Map<String, dynamic> json) {
    return ProjectStatus(
      mainMarket: json['main_market'],
      starlineMarket: json['starline_market'],
      galidesawarMarket: json['galidesawar_market'],
      bannerStatus: json['banner_status'],
      marqueeStatus: json['marquee_status'],
    );
  }
}
