import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/data/models/payments_model.dart';
import 'package:hospital25/data/models/slideshow_model.dart';
import 'package:hospital25/data/repositories/information_repository.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';

part 'information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  final InternetCubit connection;
  final InformationRepository informationRepo;
  InformationCubit(this.connection, this.informationRepo) : super(InformationInitial());

  static InformationCubit get(BuildContext context) => BlocProvider.of(context);

  static List<SlideshowModel>? slides;
  static List<PaymentsModel>? paymentWays;

  Future<void> getSlideShow()async{
    emit(GetSlideShowLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GetSlideShowFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        slides = await informationRepo.getSlideShow();
        print(slides![0].slideShowImagesModel.imageUrl);
        emit(GetSlideShowSuccess());
      } catch (e) {
        print('get slides error: $e');
        emit(GetSlideShowFailed(error: e.toString()));
      }
    }
  }

  Future<void> getPaymentWays()async{
    emit(GetPaymentWaysLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GetPaymentWaysFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        paymentWays = await informationRepo.getPaymentWays();
        print(paymentWays![0].title);
        emit(GetPaymentWaysSuccess());
      } catch (e) {
        print('get payments error: $e');
        emit(GetPaymentWaysFailed(error: e.toString()));
      }
    }
  }

  void fetchData(){
    getSlideShow();
    getPaymentWays();
  }
}
