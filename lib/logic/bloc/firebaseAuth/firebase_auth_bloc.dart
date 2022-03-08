// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final FirebaseRepository firebaseRepo;
  final InternetCubit connection;
  final CustomerRepository customerRepo;

  FirebaseAuthBloc(
    this.firebaseRepo,
    this.connection,
    this.customerRepo,
  ) : super(FirebaseAuthInitial());

  static FirebaseAuthBloc get(BuildContext context) => BlocProvider.of(context);

  StreamSubscription<User?>? userStreamSubscription;
  static UserModel? user;
  static CustomerModel? customer;
  static String? fcmToken;
  static String? bearerToken;
  static User? firebaseUser;
  bool? isVerified;
  int? cachedUID;

  static bool socialUser = false;

  @override
  Stream<FirebaseAuthState> mapEventToState(
    FirebaseAuthEvent event,
  ) async* {
    if (event is InitialEvent) {
      bearerToken = hydratedStorage.read(bearerTxt) as String?;
      yield AuthCheckLoading();
      if (connection.state is InternetConnectionFail) {
        yield AuthCheckFailed(LanguageAr().connectionFailed);
      } else {
        try {
          final int? id = await hydratedStorage.read('UID') as int?;
          if (id != null) {
            if (bearerToken != null) {
              customer = await customerRepo.getCustomer(id: id);
              final userModel = UserModel(
                id: customer!.id,
                username: customer!.username,
                avatarUrl: customer!.avatarUrl,
              );
              user = userModel;
              socialUser = false;
              emit(AuthCheckSuccess(userModel: user!));
            } else {
              log('No Bearer Token 1');
              emit(AuthCheckUnauthenticated());
            }
          } else {
            userStreamSubscription =
                firebaseRepo.isSignedIn().listen((firebaseUser) async {
              firebaseUser = firebaseUser;
              if (firebaseUser != null) {
                log('Firebase User: $firebaseUser ');
                if (firebaseUser.displayName != null) {
                  final int? customerId =
                      int.tryParse(firebaseUser.displayName!);
                  if (customerId != null) {
                    if (bearerToken != null) {
                      try {
                        customer =
                            await customerRepo.getCustomer(id: customerId);
                        log(customer.toString());
                        final userModel = UserModel(
                          id: customer!.id,
                          username: customer!.username,
                          avatarUrl: customer!.avatarUrl,
                        );
                        user = userModel;
                        if (firebaseUser.providerData[0].providerId ==
                                'facebook.com' ||
                            firebaseUser.providerData[0].providerId ==
                                'google.com') {
                          socialUser = true;
                          isVerified = true;
                        } else {
                          isVerified = await firebaseRepo.isVerified();
                        }
                        if (isVerified != null && isVerified!) {
                          emit(AuthCheckSuccess(userModel: user!));
                        } else {
                          emit(AuthCheckUnverified());
                        }
                      } catch (e) {
                        print(e);
                        emit(AuthCheckFailed(e.toString()));
                      }
                    } else {
                      log('No Bearer Token 2');
                      emit(AuthCheckWaitingFirebase());
                    }
                  } else {
                    emit(AuthCheckWaitingFirebase());
                  }
                } else {
                  emit(AuthCheckWaitingFirebase());
                }
              } else {
                final int? id = await hydratedStorage.read('UID') as int?;
                if (id != null) {
                  if (bearerToken != null) {
                    customer = await customerRepo.getCustomer(id: id);
                    final userModel = UserModel(
                      id: customer!.id,
                      username: customer!.username,
                      avatarUrl: customer!.avatarUrl,
                    );
                    user = userModel;
                    emit(AuthCheckSuccess(userModel: user!));
                  } else {
                    log('No Bearer Token 3');
                    emit(AuthCheckWaitingFirebase());
                  }
                } else {
                  emit(AuthCheckUnauthenticated());
                }
              }
            });
          }
        } catch (e) {
          print(e);
          yield AuthCheckFailed(e.toString());
        }
      }
    } else if (event is VerifyEmailEvent) {
      yield VerificationMailLoading();
      try {
        await firebaseRepo.sendEmailVerification();

        yield VerificationMailSent();
      } catch (e) {
        yield VerificationMailFailed(error: e.toString());
      }
    } else if (event is SignOutEvent) {
      yield AuthCheckLoading();
      if (connection.state is InternetConnectionFail) {
        yield AuthCheckFailed(LanguageAr().connectionFailed);
      } else {
        try {
          await hydratedStorage.delete('UID');
          await firebaseRepo.logOut();
          user = null;
          firebaseUser = null;
          customer = null;
          bearerToken = null;
          hydratedStorage.delete(bearerTxt);
          socialUser = false;
          yield AuthCheckUnauthenticated();
        } catch (e) {
          yield AuthCheckFailed(e.toString());
        }
      }
    }
  }

  @override
  Future<void> close() {
    userStreamSubscription?.cancel();
    return super.close();
  }
}
