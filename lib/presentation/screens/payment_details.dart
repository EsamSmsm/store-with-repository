import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InformationCubit informationCubit = InformationCubit.get(context);
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
              Text('Choose ${AppCubit.appText!.paymentMethod}',style: TextStyle(
                fontSize: 20.h,fontWeight: FontWeight.bold
              )),
              SizedBox(height: vLargePadding,),
              ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                    title: Text(informationCubit.paymentWays![index].title.toString()),
                    subtitle: Text(informationCubit.paymentWays![index].description.toString()),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: informationCubit.paymentWays!.length
              )
            ],
          ),
        ),
      ),
    );
  }
}
