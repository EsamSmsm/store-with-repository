import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/data/models/payments_model.dart';
import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';

import '../routers/import_helper.dart';
import '../widgets/components/components.dart';
import '../widgets/defaultButton/default_button.dart';
import '../widgets/defaults/defaults.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InformationCubit infoCubit = InformationCubit.get(context);
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
            child: Column(
              children: [
                Text('Choose ${AppCubit.appText!.paymentMethod}',
                    style:
                        TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: vLargePadding,
                ),
                BlocBuilder<InformationCubit, InformationState>(
                  builder: (context, state) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: vSmallPadding,
                                  horizontal: hVerySmallPadding),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(mediumRadius),
                                  border: infoCubit.selectedMethod == index
                                      ? Border.all(
                                          color: primarySwatch, width: 2.w)
                                      : Border.all(color: Colors.transparent)),
                              child: ListTile(
                                title: Text(infoCubit.paymentWays![index].title
                                    .toString()),
                                subtitle: Text(infoCubit
                                    .paymentWays![index].description
                                    .toString()),
                                selected: index == infoCubit.selectedMethod,
                                onTap: () {
                                  infoCubit.changeSelectedMethod(index);
                                },
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: infoCubit.paymentWays!.length);
                  },
                ),
                SizedBox(
                  height: vVeryLargePadding,
                ),
                BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {
                    if (state is CheckOutSuccess) {
                      customSnackBar(
                          context: context,
                          message: 'Success checkout',
                          color: Colors.green);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Center(
                                    child: Text(
                                  AppCubit.appText!.finish,
                                  style:  TextStyle(
                                      color: primarySwatch,
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.bold),
                                )),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${AppCubit.appText!.orderNo}: ",
                                        ),
                                    Text(state.order.number),
                                  ],
                                ),
                                actions: [
                                  DefaultButton(
                                      text: AppCubit.appText!.continueShopping,
                                      onPressed: () {
                                        navigateAndFinish(
                                            context,
                                            const HomeLayout(
                                              reload: false,
                                            ));
                                      })
                                ],
                              ));
                    } else if (state is CheckOutFailed) {
                      customSnackBar(
                          context: context, message: 'failed checkout');
                    }
                  },
                  builder: (context, state) {
                    final ProductCubit productCubit = ProductCubit.get(context);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: hMediumMargin),
                      child: DefaultButton(
                        text: AppCubit.appText!.checkout,
                        smallSize: true,
                        borderRadius: smallRadius,
                        isLoading: state is CheckOutLoading,
                        onPressed: () {
                          productCubit.checkOut(
                              billing: FirebaseAuthBloc.customer!.billing,
                              shipping: FirebaseAuthBloc.customer!.billing,
                              paymentMethod: infoCubit
                                  .paymentWays![infoCubit.selectedMethod].id
                                  .toString(),
                              paymentTitle: infoCubit
                                  .paymentWays![infoCubit.selectedMethod].id
                                  .toString(),
                              customerId:
                                  FirebaseAuthBloc.customer!.id.toString());
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
