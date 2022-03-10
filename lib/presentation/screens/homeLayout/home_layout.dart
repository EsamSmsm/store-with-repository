import 'package:flutter/material.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/presentation/routers/app_router.dart';

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
      body: Container(),
    );
  }
}
