import 'package:flutter/cupertino.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/theme/colors.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/information/information_cubit.dart';
import 'package:hospital25/logic/cubit/product/product_cubit.dart';
import 'package:hospital25/presentation/routers/app_router.dart';
import 'package:hospital25/presentation/screens/home_screen.dart';
import 'package:hospital25/presentation/screens/profile_screen.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';

import '../blogs_screen.dart';
import '../../routers/import_helper.dart';
import '../products_screen.dart';

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
    return    DefaultTabController(
      length: 4,
      child: Scaffold(
       bottomNavigationBar: Material(
         elevation: 20,
         shadowColor: Colors.black,
         child: SizedBox(
           height: 65.h,
           child: TabBar(
             indicatorColor: Colors.transparent,
             unselectedLabelStyle: TextStyle(fontSize: 12.h),
             labelStyle: TextStyle(fontSize: 14.h),
             labelColor: lightPrimaryColor,
             unselectedLabelColor: Colors.black,
             labelPadding: EdgeInsets.zero,
             tabs: [
               Tab(
                 text: "Home",
                 icon: Icon(CupertinoIcons.home,size: 20.h),
               ),
               Tab(
                 text: "products",
                 icon: Icon(CupertinoIcons.shopping_cart,size: 20.h),
               ),
               Tab(
                 text: "Blogs",
                 icon: Icon(CupertinoIcons.collections,size: 20.h),
               ),
               Tab(
                 text: "Profile",
                 icon: Icon(CupertinoIcons.person,size: 20.h),
               ),
             ],
           ),
         ),
       ),
        body: TabBarView(
          children: [
            const HomeScreen(),
             const ProductsScreen(),
            const BlogsScreen(),
            ProfileScreen(),
          ],
        ),
    ),
    );
  }
}
