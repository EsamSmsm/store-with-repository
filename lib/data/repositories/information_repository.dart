
import 'dart:convert';

import 'package:hospital25/data/models/slideshow_model.dart';
import 'package:hospital25/data/services/information_services.dart';

class InformationRepository{
  final InformationServices _informationServices;

  InformationRepository(this._informationServices);
  Future<List<SlideshowModel>> getSlideShow()async{
    try{
      final result = await _informationServices.getSlidesShow();
      final slidesJson = json.decode(result);
      final slides = slidesJson.map<SlideshowModel>((e) => SlideshowModel.fromJson(e)).toList();
      return slides as List<SlideshowModel>;
    } catch(e){
      rethrow;
    }
  }
}
