import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final CustomerRepository customerRepo;
  final FirebaseRepository firebaseRepo;
  final InternetCubit connection;

  LoginCubit(
    this.customerRepo,
    this.connection,
    this.firebaseRepo,
  ) : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> login(
    BuildContext context, {
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());
    if (connection.state is InternetConnectionFail) {
      emit(LoginFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final bearerToken = await customerRepo.getToken(phone, password);
        FirebaseAuthBloc.bearerToken = bearerToken;
        hydratedStorage.write(bearerTxt, bearerToken);
        final userModel =
            await customerRepo.login(phone, password, bearerToken);
        final customer = await customerRepo.getCustomer(id: userModel.id);
        await hydratedStorage.write('UID', customer.id);

        FirebaseAuthBloc.customer = customer;
        FirebaseAuthBloc.user = userModel;
        emit(LoginSuccess());

        // await firebaseRepo.login(email: email, password: password);
        // final userModel = await customerRepo.login(email, password);

        // final customer = await customerRepo.getCustomer(id: userModel.id);
        // FirebaseAuthBloc.customer = customer;
        // FirebaseAuthBloc.user = userModel;
        // final isVerified = await firebaseRepo.isVerified();
        // if (isVerified) {
        //   emit(LoginSuccess());
        // } else {
        //   emit(LoginUnverified());
        // }
        // } on FirebaseAuthException catch (e) {
        //   print(' Login Error Firebase exception: $e');
        //   final message =
        //       translateFirebaseMessage(context, code: e.code, message: e.message);
        //   if (message != null) {
        //     emit(LoginFailed(error: message));
        //   } else {
        //     emit(LoginFailed(error: e.message ?? e.code));
        //   }
      } catch (e) {
        print(' Login Error: $e');
        emit(LoginFailed(error: e.toString()));
      }
    }
  }
}
