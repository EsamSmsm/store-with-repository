class PaymentsModel {
  PaymentsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.enabled,
  });
  late final String? id;
  late final String? title;
  late final String? description;
  late final bool? enabled;

  PaymentsModel.fromJson(dynamic json){
    id = json['id']as String?;
    title = json['title']as String?;
    description = json['description']as String?;
    enabled = json['enabled']as bool?;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['enabled'] = enabled;
    return _data;
  }
}