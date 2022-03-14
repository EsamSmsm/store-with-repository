import 'package:flutter/material.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/theme/colors.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/presentation/routers/app_router.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';

import '../../routers/import_helper.dart';

TabController? tabController;
GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class HomeLayout extends StatelessWidget {
  final bool? reload;

  const HomeLayout({
    Key? key,
    required this.reload,
  }) : super(key: key);

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
              BlocBuilder<InformationCubit, InformationState>(
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
                        itemCount: InformationCubit.slides?.length,
                        itemBuilder: (context, index) => Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(InformationCubit
                              .slides?[0].slideShowImagesModel.imageUrl??''),
                          errorBuilder: (context, index,stack) =>Container(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: vLargePadding       ,
              ),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if(state is AddToCartSuccess){
                    customSnackBar(context: context, message: "success add item ",color: Colors.green);
                  }else if(state is AddToCartFailed){
                    customSnackBar(context: context, message: state.error);
                  }
                },
                builder: (context, state) {
                  final ProductCubit productCubit = ProductCubit.get(context);
                  return state is GetAllProductsLoading?
                  const Center(child: CircularProgressIndicator(color: Colors.green),)
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
                                      productCubit.products![index].images![0].src.toString()
                                    )
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
                                      productCubit.addToCart(id: productCubit.products![index].id.toString(), quantity: '1');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
