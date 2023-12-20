
class Banners {
  final int? bannerId;
  final String? text;
  final String? image;
  final String? url;
  final String? status;
  final String? createTimestamp;
  final String? activeTimestamp;
  final String? modifyTimestamp;

  Banners({
    required this.bannerId,
    required this.text,
    required this.image,
    required this.url,
    required this.status,
    required this.createTimestamp,
    required this.activeTimestamp,
    required this.modifyTimestamp,
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      bannerId: json['banner_id'],
      text: json['text'],
      image: json['image'],
      url: json['url'],
      status: json['status'],
      createTimestamp: json['create_timestamp'],
      activeTimestamp: json['active_timestamp'],
      modifyTimestamp: json['modify_timestamp'],
    );
  }
}
