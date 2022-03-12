/// id : 36
/// name : "WordPress Pennant"
/// description : "<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>\n"
/// price : "11.05"
/// regular_price : "11.05"
/// sale_price : ""
/// categories : [{"id":21,"name":"Decor","slug":"decor"}]
/// images : [{"id":59,"date_created":"2022-03-10T12:39:38","date_created_gmt":"2022-03-10T12:39:38","date_modified":"2022-03-10T12:39:38","date_modified_gmt":"2022-03-10T12:39:38","src":"https://dev.scopelinks.com/dev1/hospital25/wp-content/uploads/2022/03/pennant-1.jpg","name":"pennant-1.jpg","alt":""}]

class ProductsListModel {
  ProductsListModel({
      int? id,
      String? name,
      String? description,
      String? price,
      String? regularPrice,
      String? salePrice,
      List<Categories>? categories,
      List<Images>? images,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _categories = categories;
    _images = images;
}

  ProductsListModel.fromJson(dynamic json) {
    _id = json['id']as int;
    _name = json['name']as String;
    _description = json['description']as String;
    _price = json['price']as String;
    _regularPrice = json['regular_price']as String;
    _salePrice = json['sale_price']as String;
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _description;
  String? _price;
  String? _regularPrice;
  String? _salePrice;
  List<Categories>? _categories;
  List<Images>? _images;

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get price => _price;
  String? get regularPrice => _regularPrice;
  String? get salePrice => _salePrice;
  List<Categories>? get categories => _categories;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 59
/// date_created : "2022-03-10T12:39:38"
/// date_created_gmt : "2022-03-10T12:39:38"
/// date_modified : "2022-03-10T12:39:38"
/// date_modified_gmt : "2022-03-10T12:39:38"
/// src : "https://dev.scopelinks.com/dev1/hospital25/wp-content/uploads/2022/03/pennant-1.jpg"
/// name : "pennant-1.jpg"
/// alt : ""

class Images {
  Images({
      int? id,
      String? dateCreated,
      String? dateCreatedGmt,
      String? dateModified,
      String? dateModifiedGmt,
      String? src,
      String? name,
      String? alt,}){
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _src = src;
    _name = name;
    _alt = alt;
}

  Images.fromJson(dynamic json) {
    _id = json['id']as int;
    _dateCreated = json['date_created'] as String;
    _dateCreatedGmt = json['date_created_gmt']as String;
    _dateModified = json['date_modified']as String;
    _dateModifiedGmt = json['date_modified_gmt']as String;
    _src = json['src']as String;
    _name = json['name']as String;
    _alt = json['alt']as String;
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _src;
  String? _name;
  String? _alt;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  String? get dateModified => _dateModified;
  String? get dateModifiedGmt => _dateModifiedGmt;
  String? get src => _src;
  String? get name => _name;
  String? get alt => _alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['src'] = _src;
    map['name'] = _name;
    map['alt'] = _alt;
    return map;
  }

}

/// id : 21
/// name : "Decor"
/// slug : "decor"

class Categories {
  Categories({
      int? id,
      String? name,
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  Categories.fromJson(dynamic json) {
    _id = json['id']as int;
    _name = json['name']as String;
    _slug = json['slug']as String;
  }
  int? _id;
  String? _name;
  String? _slug;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}