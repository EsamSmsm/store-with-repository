import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/theme/app_theme.dart';
import 'package:hospital25/core/theme/colors.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';
import 'package:hospital25/presentation/widgets/defaultButton/default_button.dart';
import 'package:hospital25/presentation/widgets/defaults/defaults.dart';
import 'package:hospital25/presentation/widgets/loading_image_container.dart';

import '../../logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import '../routers/app_router.dart';
import 'check_out_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appNameEng),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuthBloc.get(context).add(SignOutEvent());
            Navigator.pushReplacementNamed(context, AppRouter.authScreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SlideShow(),
              SizedBox(
                height: vLargePadding,
              ),
              buildProductsList(),
            ],
          ),
        ),
      ),
    );
  }


}
BlocConsumer<ProductCubit, ProductState> buildProductsList() {
  return BlocConsumer<ProductCubit, ProductState>(
    listener: (context, state) {
      if(state is AddToCartSuccess){
        Navigator.pop(context);
        customSnackBar(context: context, message: "success add item ",color: Colors.green);
        navigateTo(context,  CheckOutScreen());
      }else if(state is AddToCartFailed){
        Navigator.pop(context);
        customSnackBar(context: context, message: state.error);
      }else if (state is AddToCartLoading){
        showLoadingDialog(context);
      }
    },
    builder: (context, state) {
      final ProductCubit productCubit = ProductCubit.get(context);
      return state is GetAllProductsLoading?
      const Center(child: CircularProgressIndicator(color: primarySwatch),)
          :ListView.separated(
        itemCount: productCubit.products?.length??0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(vSmallPadding),
          // height: 120.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(smallRadius),
              boxShadow: const [BoxShadow(color: Colors.black26,blurRadius: 0.2,spreadRadius: 0.5)]
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 80.h,
                  height: 80.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          productCubit.products![index].images![0].src.toString(),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productCubit.products![index].name.toString(),style: const TextStyle(fontSize: 17)),
                    const SizedBox(height: 10,),
                    Text('${productCubit.products![index].price} ${AppCubit.currency}'),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          int productQuantity = 1;
                          return StatefulBuilder(
                            builder: (context, setState) =>  AlertDialog(
                              title: Column(
                                children: [
                                  Center(
                                    child: Text(productCubit.products![index].name.toString(),
                                      style: const TextStyle(color: primarySwatch,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: vVerySmallPadding,),
                                  Center(
                                    child: Text('${(double.parse(productCubit.products![index].price.toString())*productQuantity).toStringAsFixed(2)} ${AppCubit.currency}',
                                    ),
                                  ),
                                ],
                              ) ,
                              ///  COUNTER CONTAINER
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///decrease count
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (productQuantity > 1) productQuantity--;
                                          });
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFA912E),
                                            borderRadius:  BorderRadius.circular(verySmallRadius),
                                            border: Border.all(color: const Color(0xffFA912E)),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                        child: Text(
                                          productQuantity.toString(),
                                          style: const TextStyle(fontFamily: 'roboto'),
                                        ),
                                      ),
                                      ///increase quantity
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            productQuantity++;
                                          });
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFA912E),
                                              borderRadius:  BorderRadius.circular(verySmallRadius),
                                              border: Border.all(color: const Color(0xffFA912E))),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              actions: [
                                DefaultButton(
                                  text: AppCubit.appText!.addToCart,
                                  isLoading: state is AddToCartLoading,
                                  onPressed: (){
                                    Navigator.pop(context);
                                    productCubit.addToCart(id: productCubit.products![index].id.toString(),
                                        quantity: productQuantity.toString());
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        );
                      },
                      icon: const Icon(Icons.shopping_cart,color: lightPrimaryNaas),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: vMediumPadding),
      );
    },
  );
}

class SlideShow extends StatelessWidget {
  const SlideShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationCubit, InformationState>(
      builder: (context, state) {
        final InformationCubit infoCubit =
        InformationCubit.get(context);
        return state is GetSlideShowLoading?
        const Center(child: CircularProgressIndicator(color: Colors.green,),)
            :SizedBox(
          height: 200.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(mediumRadius),
            child: PageView.builder(
              itemCount: infoCubit.slides?.length,
              itemBuilder: (context, index) => Image(
                fit: BoxFit.cover,
                image: NetworkImage(infoCubit
                    .slides?[0].slideShowImagesModel.imageUrl??''),
                errorBuilder: (context, index,stack) =>LoadingImageContainer(width: 100.w, height: 100.h),
              ),
            ),
          ),
        );
      },
    );
  }
}
