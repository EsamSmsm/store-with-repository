part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerGetLoading extends CustomerState {}

class CustomerGetSuccess extends CustomerState {}

class CustomerGetFailed extends CustomerState {
  final String error;
  const CustomerGetFailed({required this.error});
}

class GetLocationLoading extends CustomerState {}

class GetLocationSuccess extends CustomerState {}

class GetLocationFailed extends CustomerState {
  final String error;
  const GetLocationFailed({required this.error});
}

class SearchForUserLoading extends CustomerState {}

class SearchForUserSuccess extends CustomerState {}

class SearchForUserFailed extends CustomerState {
  final String error;
  const SearchForUserFailed({required this.error});
}

class UpdateLocationLoading extends CustomerState {}

class UpdateLocationSuccess extends CustomerState {}

class UpdateLocationFailed extends CustomerState {
  final String error;
  const UpdateLocationFailed({required this.error});
}

class CustomerUpdateLoading extends CustomerState {}

class CustomerUpdateSuccess extends CustomerState {}

class CustomerUpdateFailed extends CustomerState {
  final String error;
  const CustomerUpdateFailed({required this.error});
}

class UpdatePasswordLoading extends CustomerState {}

class UpdatePasswordSuccess extends CustomerState {}

class UpdatePasswordFailed extends CustomerState {
  final String error;
  const UpdatePasswordFailed({required this.error});
}

class VerifyPhoneLoading extends CustomerState {}

class VerifyPhoneSent extends CustomerState {}

class VerifyOTPLoading extends CustomerState {}

class VerifyOTPSuccess extends CustomerState {}

class VerifyPhoneFailed extends CustomerState {
  final String error;
  const VerifyPhoneFailed({required this.error});
}

class ReverifyPhoneLoading extends CustomerState {}

class ReverifyPhoneSent extends CustomerState {}

class ReverifyOTPLoading extends CustomerState {}

class ReverifyOTPSuccess extends CustomerState {}

class ReverifyPhoneFailed extends CustomerState {
  final String error;
  const ReverifyPhoneFailed({required this.error});
}

class PrivacyGetLoading extends CustomerState {}

class PrivacyGetSuccess extends CustomerState {}

class PrivacyGetFailed extends CustomerState {
  final String error;
  const PrivacyGetFailed({required this.error});
}

class TermsGetLoading extends CustomerState {}

class TermsGetSuccess extends CustomerState {}

class TermsGetFailed extends CustomerState {
  final String error;
  const TermsGetFailed({required this.error});
}

class ShippingPolicyGetLoading extends CustomerState {}

class ShippingPolicyGetSuccess extends CustomerState {}

class ShippingPolicyGetFailed extends CustomerState {
  final String error;
  const ShippingPolicyGetFailed({required this.error});
}

class ReturnPolicyGetLoading extends CustomerState {}

class ReturnPolicyGetSuccess extends CustomerState {}

class ReturnPolicyGetFailed extends CustomerState {
  final String error;
  const ReturnPolicyGetFailed({required this.error});
}

class ResetPasswordLoading extends CustomerState {}

class ResetPasswordSuccess extends CustomerState {
  final String message;
  const ResetPasswordSuccess({required this.message});
}

class ResetPasswordFailed extends CustomerState {
  final String error;
  const ResetPasswordFailed({required this.error});
}

class ValidateAndChangePasswordLoading extends CustomerState {}

class ValidateAndChangePasswordSuccess extends CustomerState {
  final String message;
  const ValidateAndChangePasswordSuccess({required this.message});
}

class ValidateAndChangePasswordFailed extends CustomerState {
  final String error;
  const ValidateAndChangePasswordFailed({required this.error});
}

class GetStateLoading extends CustomerState {}

class GetStateSuccess extends CustomerState {
  final List<StateModel> allStates;
  const GetStateSuccess({required this.allStates});
}

class GetStateFailed extends CustomerState {
  final String error;
  const GetStateFailed({required this.error});
}

class GetStateDetailsLoading extends CustomerState {}

class GetStateDetailsSuccess extends CustomerState {}

class GetStateDetailsFailed extends CustomerState {
  final String error;
  const GetStateDetailsFailed({required this.error});
}
