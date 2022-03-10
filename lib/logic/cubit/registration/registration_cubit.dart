import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/constants/firebase_exception.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final CustomerRepository customerRepo;
  final FirebaseRepository firebaseRepo;
  final InternetCubit connection;
  RegistrationCubit(
    this.customerRepo,
    this.firebaseRepo,
    this.connection,
  ) : super(RegistrationInitial());

  static RegistrationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> registerUser(
    BuildContext context, {
    required String phone,
    required String password,
  }) async {
    emit(RegistrationLoading());
    if (connection.state is InternetConnectionFail) {
      emit(RegistrationFailed(error: LanguageAr().connectionFailed));
    } else {
      try {

        final email = '$phone@hospital25.com';

        final firebaseUser =
            await firebaseRepo.register(email: email, password: password);
        final customer =
            await customerRepo.registerUser(phone, email, password);
        final bearerToken = await customerRepo.getToken(email, password);
        await firebaseUser.updateDisplayName(customer.id.toString());
        final userModel = UserModel(
          id: customer.id,
          username: customer.username,
          avatarUrl: customer.avatarUrl,
        );
        FirebaseAuthBloc.user = userModel;
        FirebaseAuthBloc.customer = customer;
        FirebaseAuthBloc.bearerToken = bearerToken;

        hydratedStorage.write(bearerTxt, bearerToken);

        emit(RegistrationSuccess());
      } on FirebaseAuthException catch (e) {
        print(' Registration Error Firebase exception: $e');
        final message =
            translateFirebaseMessage(context, code: e.code, message: e.message);
        if (message != null) {
          emit(RegistrationFailed(error: message));
        } else {
          emit(RegistrationFailed(error: e.message ?? e.code));
        }
      } catch (e) {
        print('Registration Error: $e');
        emit(RegistrationFailed(error: e.toString()));
      }
    }
  }
}
