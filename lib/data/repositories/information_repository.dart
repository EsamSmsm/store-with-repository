
import 'dart:convert';

import 'package:hospital25/data/models/payments_model.dart';
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

  Future<List<PaymentsModel>> getPaymentWays()async{
    try{
      final result = await _informationServices.getPaymentWays();
      final paymentsJson = json.decode(result);
      final payments = paymentsJson.map<PaymentsModel>((e) => PaymentsModel.fromJson(e)).toList();
      return payments as List<PaymentsModel>;
    } catch(e){
      rethrow;
    }
  }



}
