// import 'package:equatable/equatable.dart';
// import 'package:hospital25/core/constants/constants.dart';
//
// class SlideshowModel extends Equatable {
//   final int id;
//   final String title;
//   final String? subtitle;
//   final SlideshowImageModel slideshowImage;
//   const SlideshowModel({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.slideshowImage,
//   });
//
//   @override
//   List<Object> get props {
//     return [
//       id,
//       title,
//       slideshowImage,
//     ];
//   }
//
//   factory SlideshowModel.fromMap(Map<String, dynamic> map) {
//     return SlideshowModel(
//       id: map['id'] as int,
//       title: (map['title'] as Map<String, dynamic>)[renderedTxt] as String,
//       subtitle:
//           (map['content'] as Map<String, dynamic>)[renderedTxt] as String?,
//       slideshowImage:
//           SlideshowImageModel.fromMap(map['_embedded'] as Map<String, dynamic>),
//     );
//   }
//
//   SlideshowModel copyWith({
//     int? id,
//     String? title,
//     String? subtitle,
//     SlideshowImageModel? slideshowImage,
//   }) {
//     return SlideshowModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//       slideshowImage: slideshowImage ?? this.slideshowImage,
//     );
//   }
// }
//
// class SlideshowImageModel extends Equatable {
//   final String imageUrl;
//   const SlideshowImageModel({
//     required this.imageUrl,
//   });
//
//   @override
//   List<Object> get props => [imageUrl];
//
//   factory SlideshowImageModel.fromMap(Map<String, dynamic> map) {
//     final featuredMedia =
//         (map['wp:featuredmedia'] as List<dynamic>)[0] as Map<String, dynamic>;
//     final shopSingle =
//         ((featuredMedia['media_details'] as Map<String, dynamic>)['sizes']
//             as Map<String, dynamic>)['shop_single'] as Map<String, dynamic>;
//
//     return SlideshowImageModel(
//       imageUrl: shopSingle['source_url'] as String,
//     );
//   }
// }

class SlideshowModel {
  SlideshowModel({
    required this.id,
    required this.title,
    required this.content,
    required this.slideShowImagesModel,
  });
  late final int id;
  late final Title title;
  late final Content content;
  late final SlideshowImageModel slideShowImagesModel;

  SlideshowModel.fromJson(dynamic json){
    id = json['id'] as int;
    title = Title.fromJson(json['title']as Map<String,dynamic>);
    content = Content.fromJson(json['content']as Map<String,dynamic>);
    slideShowImagesModel = SlideshowImageModel.fromJson(json['_embedded'] as Map<String,dynamic>);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title.toJson();
    _data['content'] = content.toJson();
    // _data['_embedded'] = slideShowImagesModel.toJson();
    return _data;
  }
}

class Title {
  Title({
    required this.rendered,
  });
  late final String rendered;

  Title.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'] as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    return _data;
  }
}

class Content {
  Content({
    required this.rendered,
    required this.protected,
  });
  late final String rendered;
  late final bool protected;

  Content.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'] as String;
    protected = json['protected'] as bool;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rendered'] = rendered;
    _data['protected'] = protected;
    return _data;
  }
}




class SlideshowImageModel {
  SlideshowImageModel(this.imageUrl,);
  late final String imageUrl;

   SlideshowImageModel.fromJson(Map<String, dynamic> json){
    final featuredMedia = (json['wp:featuredmedia'] as List<dynamic>)[0] as Map<String, dynamic>;
    final shopSingle =
    ((featuredMedia['media_details'] as Map<String, dynamic>)['sizes']
    as Map<String, dynamic>)['shop_single'] as Map<String, dynamic>;
    imageUrl = shopSingle['source_url'] as String;
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['wp:featuredmedia'] = wp:featuredmedia.map((e)=>e.toJson()).toList();
  //   return _data;
  // }
}
