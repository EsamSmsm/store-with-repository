import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/data/repositories/app_repository.dart';
import 'package:hospital25/data/repositories/customer_repository.dart';
import 'package:hospital25/data/repositories/firebase_repository.dart';
import 'package:hospital25/data/repositories/information_repository.dart';
import 'package:hospital25/data/services/app_services.dart';
import 'package:hospital25/data/services/authentication_services.dart';
import 'package:hospital25/data/services/firebase_auth_services.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/logic/cubit/customer/customer_cubit.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/logic/cubit/theme/theme_cubit.dart';
import 'package:hospital25/logic/debug/app_bloc_observer.dart';
import 'package:hospital25/my_app.dart';

import 'data/repositories/products_repository.dart';
import 'data/services/information_services.dart';
import 'logic/debug/local_notification_service.dart';
import 'data/services/products_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final connectivity = Connectivity();
  await initHydratedStorage();
  await NotificationService().init(); //
  NotificationService().requestIOSPermissions();
  // await hydratedStorage.clear();
  Bloc.observer = AppBlocObserver();
  runApp(
    InitialApp(connectivity: connectivity),
  );
}

class InitialApp extends StatelessWidget {
  InitialApp({
    Key? key,
    required this.connectivity,
  }) : super(key: key);

  final authServices = AuthenticationServices();
  final firebaseServices = FirebaseAuthenticationServices();
  final appServices = AppServices();
  final productsServices = ProductsServices();
  final informationServices = InformationServices();
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CustomerRepository(authServices),
        ),
        RepositoryProvider(
          create: (context) => FirebaseRepository(firebaseServices),
        ),
        RepositoryProvider(
          create: (context) => AppRepository(appServices),
        ),
        RepositoryProvider(
          create: (context) => ProductsRepository(productsServices),
        ),
        RepositoryProvider(
          create: (context) => InformationRepository(informationServices),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                InternetCubit(connectivity)..monitorInternetConnection(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => AppCubit(
              RepositoryProvider.of<AppRepository>(context),
              BlocProvider.of<InternetCubit>(context),
            )
              ..getAppText(context)
              ..getAppCurrency(context),
          ),
          BlocProvider(
            create: (context) => FirebaseAuthBloc(
              RepositoryProvider.of<FirebaseRepository>(context),
              BlocProvider.of<InternetCubit>(context),
              RepositoryProvider.of<CustomerRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CustomerCubit(
              RepositoryProvider.of<CustomerRepository>(context),
              BlocProvider.of<InternetCubit>(context),
            ),
          ),
          BlocProvider(
              create: (context) => ProductCubit(
                    BlocProvider.of<InternetCubit>(context),
                    RepositoryProvider.of<ProductsRepository>(context),
                  )..fetchData()
          ),
          BlocProvider(
              create: (context) => InformationCubit(
                BlocProvider.of<InternetCubit>(context),
                RepositoryProvider.of<InformationRepository>(context),
              )..fetchData()
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: () => MyApp(),
        ),
      ),
    );
  }
}
