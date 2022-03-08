import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/state_model.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/services/firebase_auth_services.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRepository customerRepo;
  final InternetCubit connection;
  CustomerCubit(
    this.customerRepo,
    this.connection,
  ) : super(CustomerInitial());

  static CustomerCubit get(BuildContext context) => BlocProvider.of(context);

  String? verificationId;
  String? phoneNumber;
  int? resendingToken;
  int? searchedForUserId;

  Future<void> getCustomer() async {
    emit(CustomerGetLoading());
    if (connection.state is InternetConnectionFail) {
      emit(CustomerGetFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final customer = await customerRepo.getCustomer(id: 1);
        FirebaseAuthBloc.customer = customer;
        emit(CustomerGetSuccess());
      } catch (e) {
        emit(CustomerGetFailed(error: e.toString()));
      }
    }
  }

  Future<void> updateCustomer(CustomerModel customerModel) async {
    emit(CustomerUpdateLoading());
    if (connection.state is InternetConnectionFail) {
      emit(CustomerUpdateFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final customer = await customerRepo.updateCustomer(
          id: customerModel.id,
          customerModel: customerModel,
          token: FirebaseAuthBloc.bearerToken!,
        );
        FirebaseAuthBloc.customer = customer;
        emit(CustomerUpdateSuccess());
      } catch (e) {
        emit(CustomerUpdateFailed(error: e.toString()));
      }
    }
  }

  Future<void> updateCustomerName(
      {required String firstName,
      required String lastName,
      String? email}) async {
    emit(CustomerUpdateLoading());
    if (connection.state is InternetConnectionFail) {
      emit(CustomerUpdateFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final customerModel = FirebaseAuthBloc.customer;
        if (customerModel != null) {
          if (email != null && email.isNotEmpty) {
            await FirebaseAuthenticationServices().changeFirebaseEmail(email);
          }
          final customer = await customerRepo.updateCustomerNameAndEmail(
            id: customerModel.id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            token: FirebaseAuthBloc.bearerToken!,
          );
          FirebaseAuthBloc.customer = customer;
          emit(CustomerUpdateSuccess());
        } else {
          emit(const CustomerUpdateFailed(error: 'Failed to get user data'));
        }
      } catch (e) {
        emit(CustomerUpdateFailed(error: e.toString()));
      }
    }
  }

  Future<void> searchForUserByMobileNumber(String mobileNumber) async {
    searchedForUserId = null;
    emit(SearchForUserLoading());
    if (connection.state is InternetConnectionFail) {
      emit(SearchForUserFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final userId = await customerRepo.searchForUserByMobileNumber(
            mobileNumber: mobileNumber);
        if (userId != -1) {
          searchedForUserId = userId;
          emit(SearchForUserSuccess());
        } else {
          searchedForUserId = null;
          emit(const SearchForUserFailed(
              error: "There is no user with this mobile number!"));
        }
      } catch (e) {
        log('Search For User Error: $e');
        emit(SearchForUserFailed(error: e.toString()));
      }
    }
  }

  Future<void> updatePassword(
      {required String newPassword, int? userId}) async {
    emit(UpdatePasswordLoading());
    if (connection.state is InternetConnectionFail) {
      emit(UpdatePasswordFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final customerModel = FirebaseAuthBloc.customer;
        if (customerModel != null) {
          await customerRepo.updatePassword(newPassword, customerModel.id);
          emit(UpdatePasswordSuccess());
        } else if (userId != null) {
          await customerRepo.updatePassword(newPassword, userId);
          emit(UpdatePasswordSuccess());
        } else {
          emit(const UpdatePasswordFailed(error: 'Failed to get user data'));
        }
      } catch (e) {
        log(e.toString());
        emit(UpdatePasswordFailed(error: e.toString()));
      }
    }
  }

  Future<bool> validatePassword({required String currentPassword}) async {
    final auth = FirebaseAuth.instance;
    try {
      final credential = EmailAuthProvider.credential(
        email: auth.currentUser!.email!,
        password: currentPassword,
      );
      final userCredentials =
          await auth.currentUser!.reauthenticateWithCredential(credential);

      return userCredentials.user != null;
    } catch (e) {
      return false;
    }
  }
}
