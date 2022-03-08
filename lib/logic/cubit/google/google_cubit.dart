import 'dart:math' show Random;

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  final CustomerRepository customerRepo;
  final FirebaseRepository firebaseRepo;
  final InternetCubit connection;
  GoogleCubit(
    this.customerRepo,
    this.firebaseRepo,
    this.connection,
  ) : super(GoogleInitial());
  static GoogleCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> googleLogin() async {
    emit(GoogleLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GoogleFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        await GoogleSignIn().signOut();
        final userCredentials = await firebaseRepo.googleSignIn();
        CustomerModel? customer;
        String? bearerToken;
        if (userCredentials.user != null) {
          if (userCredentials.additionalUserInfo!.isNewUser) {
            final generatedKey = Random().nextInt(99);
            final username =
                '${userCredentials.user!.email!.split('@').first}$generatedKey';

            customer = await customerRepo.registerUser(
              username,
              userCredentials.user!.email!,
              userCredentials.user!.uid,
            );
            bearerToken = await customerRepo.getToken(
              userCredentials.user!.email!,
              userCredentials.user!.uid,
            );
            await userCredentials.user!
                .updateDisplayName(customer.id.toString());
          } else {
            final id = int.tryParse(userCredentials.user!.displayName!);
            if (id != null) {
              bearerToken = await customerRepo.getToken(
                userCredentials.user!.email!,
                userCredentials.user!.uid,
              );
              customer = await customerRepo.getCustomer(id: id);
            } else {
              customer = await customerRepo.getCustomerByEmail(
                email: userCredentials.user!.email!,
              );
              userCredentials.user!.updateDisplayName(customer.id.toString());
              await customerRepo.updatePassword(
                userCredentials.user!.uid,
                customer.id,
              );
              bearerToken = await customerRepo.getToken(
                userCredentials.user!.email!,
                userCredentials.user!.uid,
              );
            }
          }

          final userModel = UserModel(
            id: customer.id,
            username: customer.username,
            avatarUrl: customer.avatarUrl,
          );
          FirebaseAuthBloc.socialUser = true;
          FirebaseAuthBloc.user = userModel;
          FirebaseAuthBloc.customer = customer;
          FirebaseAuthBloc.bearerToken = bearerToken;
          hydratedStorage.write(bearerTxt, bearerToken);

          emit(GoogleSuccess());
        }
      } catch (e) {
        print(' Google Sign in Error: $e');
        if (e.toString() == 'Exception: CANCELLED') {
          emit(GoogleCancelled());
        } else {
          emit(GoogleFailed(error: e.toString()));
        }
      }
    }
  }
}
