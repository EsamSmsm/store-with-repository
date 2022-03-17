import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/data/models/address_model.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/logic/cubit/customer/customer_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/presentation/screens/payment_details.dart';
import 'package:hospital25/presentation/widgets/defaultButton/default_button.dart';
import 'package:hospital25/presentation/widgets/defaults/defaults.dart';

import '../../data/models/customer_model.dart';
import '../../logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import '../routers/import_helper.dart';
import '../widgets/components/components.dart';
import '../widgets/textFieldWithLabel/text_field_with_label.dart';

class CheckOutScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController =
      TextEditingController(text: FirebaseAuthBloc.customer!.firstName);
  final _lastNameController =
      TextEditingController(text: FirebaseAuthBloc.customer!.lastName);
  final _emailController =
      TextEditingController(text: FirebaseAuthBloc.customer!.email);
  final _phoneController =
      TextEditingController(text: FirebaseAuthBloc.customer!.billing.phone);
  final _postCodeController =
      TextEditingController(text: FirebaseAuthBloc.customer!.billing.postcode);
  final _addressController =
      TextEditingController(text: FirebaseAuthBloc.customer!.billing.address1);
  final _countryController =
      TextEditingController(text: FirebaseAuthBloc.customer!.billing.country);
  final _cityController =
      TextEditingController(text: FirebaseAuthBloc.customer!.billing.city);
  // late CustomerModel customerModel;
  CustomerModel? customerModel = FirebaseAuthBloc.customer;
  AddressModel? addressModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
        title: Text(AppCubit.appText!.checkout),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppCubit.appText!.total,
                        style: TextStyle(color: primarySwatch, fontSize: 20.h)),
                    Text(
                        "${ProductCubit.get(context).cart!.totals!.totalPrice} ${ProductCubit.get(context).cart!.totals!.currencySymbol}",
                        style: TextStyle(color: primarySwatch, fontSize: 20.h)),
                  ],
                ),
                SizedBox(
                  height: vLargePadding,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledTextFieldWithLabel(
                        labelText: AppCubit.appText!.firstName,
                        requiredField: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppCubit.appText!.filedIsRequired;
                          } else {
                            return null;
                          }
                        },
                        controller: _firstNameController,
                      ),
                    ),
                    SizedBox(
                      width: hSmallPadding,
                    ),
                    Expanded(
                      child: FilledTextFieldWithLabel(
                        labelText: AppCubit.appText!.lastName,
                        requiredField: true,
                        controller: _lastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppCubit.appText!.filedIsRequired;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.phone,
                  requiredField: true,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppCubit.appText!.filedIsRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.postcodeZIP,
                  requiredField: true,
                  keyboardType: TextInputType.number,
                  controller: _postCodeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppCubit.appText!.filedIsRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.countryRegion,
                  requiredField: true,
                  controller: _countryController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppCubit.appText!.filedIsRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.townCity,
                  requiredField: true,
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppCubit.appText!.filedIsRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                FilledTextFieldWithLabel(
                  labelText: AppCubit.appText!.location,
                  requiredField: true,
                  controller: _addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppCubit.appText!.filedIsRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: vMediumPadding,
                ),
                BlocConsumer<CustomerCubit, CustomerState>(
                  listener: (context, state) {
                    if (state is CustomerUpdateSuccess) {
                      navigateTo(context, const PaymentDetailsScreen());
                    } else if (state is CustomerUpdateFailed) {
                      customSnackBar(
                          context: context, message: 'failed update profile');
                    }
                  },
                  builder: (context, state) {
                    final CustomerCubit customerCubit =
                        CustomerCubit.get(context);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: hMediumMargin),
                      child: DefaultButton(
                        text: AppCubit.appText!.continueToPaymentMethod,
                        smallSize: true,
                        borderRadius: smallRadius,
                        isLoading: state is CustomerUpdateLoading,
                        onPressed: () {
                          ProductCubit.get(context).fillCart();
                          addressModel = customerModel!.billing.copyWith(
                            phone: _phoneController.text,
                            address1: _addressController.text,
                            email: _emailController.text,
                            city: _cityController.text,
                            country: _cityController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            postcode: _postCodeController.text,
                          );
                          customerModel = FirebaseAuthBloc.customer!
                              .copyWith(billing: addressModel);
                          print(addressModel!.postcode);
                          if (_formKey.currentState!.validate()) {
                            customerCubit.updateCustomer(customerModel!);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
