import 'dart:convert';

class TitleSwitch {
  final String title;
  final String subTitle;
  bool status;
  TitleSwitch({
    required this.title,
    required this.subTitle,
    required this.status,
  });

  TitleSwitch copyWith({
    String? title,
    String? subTitle,
    bool? status,
  }) {
    return TitleSwitch(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'status': status,
    };
  }

  factory TitleSwitch.fromMap(Map<String, dynamic> map) {
    return TitleSwitch(
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TitleSwitch.fromJson(String source) =>
      TitleSwitch.fromMap(json.decode(source));

  @override
  String toString() =>
      'TitleSwitch(title: $title, subTitle: $subTitle, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TitleSwitch &&
        other.title == title &&
        other.subTitle == subTitle &&
        other.status == status;
  }

  @override
  int get hashCode => title.hashCode ^ subTitle.hashCode ^ status.hashCode;
}
