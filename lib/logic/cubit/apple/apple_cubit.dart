import 'dart:developer';
import 'dart:math' show Random;

import 'package:equatable/equatable.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'apple_state.dart';

class AppleCubit extends Cubit<AppleState> {
  final FirebaseRepository firebaseRepo;
  final CustomerRepository customerRepo;
  final InternetCubit connection;
  AppleCubit(
    this.customerRepo,
    this.firebaseRepo,
    this.connection,
  ) : super(AppleInitial()) {
    isAppleSignInAvailable();
  }
  static AppleCubit get(BuildContext context) => BlocProvider.of(context);

  bool isAvailable = false;

  Future<void> isAppleSignInAvailable() async {
    isAvailable = await SignInWithApple.isAvailable();
  }

  Future<void> appleLogin() async {
    emit(AppleSignInLoading());
    if (connection.state is InternetConnectionFail) {
      emit(AppleSignInFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final userCredentials = await firebaseRepo.appleSignIn();
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
            log('User: ${userCredentials.user}    ');
            final int? id;
            if (userCredentials.user!.displayName != null) {
              id = int.tryParse(userCredentials.user!.displayName!);
            } else {
              id = -1;
            }
            if (id != null && id != -1) {
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

          emit(AppleSignInSuccess());
        }
      } catch (e) {
        print(' Apple Sign in Error: $e');
        if (e.toString() == 'Exception: CANCELLED') {
          emit(AppleSignInCancelled());
        } else {
          emit(AppleSignInFailed(error: e.toString()));
        }
      }
    }
  }
}
