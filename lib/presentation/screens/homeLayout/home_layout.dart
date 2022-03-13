import 'package:flutter/material.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/presentation/routers/app_router.dart';

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
          icon: const Icon(Icons.logout), onPressed: () {
          FirebaseAuthBloc.get(context).add(SignOutEvent()
          );
          Navigator.pushReplacementNamed(context, AppRouter.authScreen);
        },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              final ProductCubit cubit = ProductCubit.get(context);
              return Center(
                child: TextButton(
                  onPressed: () {
                    cubit.getAllProducts();
                  },
                  child: const Text('Get Products'),
                ),
              );
            },
          ),
          const SizedBox(height: 20,),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              final ProductCubit cubit = ProductCubit.get(context);
              return Center(
                child: TextButton(
                  onPressed: () {
                    cubit.getCart();
                  },
                  child: const Text('Get Cart'),
                ),
              );
            },
          ),
          const SizedBox(height: 20,),
          BlocBuilder<InformationCubit, InformationState>(
            builder: (context, state) {
              final InformationCubit cubit = InformationCubit.get(context);
              return Center(
                child: TextButton(
                  onPressed: () {
                    cubit.getSlideShow();
                  },
                  child: const Text('Get SlideShow'),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
