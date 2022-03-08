import 'dart:math' show Random;

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'facebook_state.dart';

class FacebookCubit extends Cubit<FacebookState> {
  final CustomerRepository customerRepo;
  final FirebaseRepository firebaseRepos;
  final InternetCubit connection;

  FacebookCubit(
    this.customerRepo,
    this.firebaseRepos,
    this.connection,
  ) : super(FacebookInitial());

  static FacebookCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> facebookLogin() async {
    emit(FacebookLoading());
    if (connection.state is InternetConnectionFail) {
      emit(FacebookFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final userCredentials = await firebaseRepos.facebookSignIn();
        late final CustomerModel customer;
        String? bearerToken;
        if (userCredentials.user != null) {
          if (userCredentials.additionalUserInfo!.isNewUser) {
            final generatedKey = Random().nextInt(99);
            final email = getUserEmail(userCredentials);
            final username = '${email.split('@').first}$generatedKey';
            customer = await customerRepo.registerUser(
              username,
              email,
              userCredentials.user!.uid,
            );
            bearerToken = await customerRepo.getToken(
              email,
              userCredentials.user!.uid,
            );
            await userCredentials.user!.updateEmail(email);
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

          emit(FacebookSuccess());
        }
      } catch (e) {
        print(' Facebook Error: $e');
        emit(FacebookFailed(error: e.toString()));
      }
    }
  }

  String getUserEmail(UserCredential userCredentials) {
    final user = userCredentials.user!;
    final profile = userCredentials.additionalUserInfo!.profile;

    if (user.email != null && !user.email!.contains('-')) {
      return user.email!;
    } else if (profile != null) {
      final email = profile['email'] as String?;
      if (email != null && !user.email!.contains('-')) {
        return email;
      } else {
        final generatedEmail = '${user.uid}@facebook.com';
        return generatedEmail;
      }
    } else {
      final generatedEmail = '${user.uid}@facebook.com';
      return generatedEmail;
    }
  }
}
