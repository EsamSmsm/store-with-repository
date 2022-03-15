import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';
import 'package:hospital25/presentation/widgets/defaultButton/default_button.dart';
import 'package:hospital25/presentation/widgets/textFieldWithLabel/text_field_with_label.dart';

import '../routers/import_helper.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController =
      TextEditingController(text: FirebaseAuthBloc.customer!.firstName);
  final _lastNameController =
      TextEditingController(text: FirebaseAuthBloc.customer!.lastName);
  final _emailController =
      TextEditingController(text: FirebaseAuthBloc.customer!.email);
  final _userNameController =
      TextEditingController(text: FirebaseAuthBloc.customer!.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if(state is CustomerUpdateSuccess){
            customSnackBar(context: context, message: 'success update profile',color: Colors.green);
          }else  if(state is CustomerUpdateFailed){
            customSnackBar(context: context, message: 'failed update profile');
          }
        },
        builder: (context, state) {
          final CustomerCubit customerCubit = CustomerCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.h,
                      backgroundImage:
                          NetworkImage(FirebaseAuthBloc.customer!.avatarUrl),
                    ),
                    SizedBox(
                      height: vLargePadding,
                    ),
                    SizedBox(
                      height: vLargePadding,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: UnderLineTextFieldWithLabel(
                            labelText: AppCubit.appText!.firstName,
                            requiredField: true,
                            controller: _firstNameController,
                          ),
                        ),
                        SizedBox(
                          width: hSmallPadding,
                        ),
                        Expanded(
                          child: UnderLineTextFieldWithLabel(
                            labelText: AppCubit.appText!.lastName,
                            requiredField: true,
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: vLargePadding,
                    ),
                    UnderLineTextFieldWithLabel(
                      labelText: AppCubit.appText!.email,
                      requiredField: true,
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: vLargePadding,
                    ),
                    UnderLineTextFieldWithLabel(
                      labelText: AppCubit.appText!.username,
                      requiredField: true,
                      controller: _userNameController,
                      readOnly: true,
                    ),
                    SizedBox(height: vMediumPadding),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hMediumMargin),
                      child: DefaultButton(
                        text: AppCubit.appText!.saveChanges,
                        smallSize: true,
                        borderRadius: smallRadius,
                        isLoading: state is CustomerUpdateLoading,
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            customerCubit.updateCustomerName(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
