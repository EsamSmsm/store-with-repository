import 'package:hospital25/logic/cubit/apple/apple_cubit.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';
import 'package:hospital25/presentation/screens/language/language_screen.dart';
import 'package:hospital25/presentation/widgets/loadingSpinner/loading_spinner.dart';
import 'package:hospital25/presentation/widgets/loadingViewsClasses/loading_views.dart';

class AppRouter {
  final InternetCubit connection;
  static final productApiServices = AppServices();
  static final authApiServices = AuthenticationServices();

  AppRouter(this.connection);

  static const language = '/';
  static const splash = '/splash';
  static const authScreen = '/auth';
  static const loadingScreen = '/loading';
  static const homeLayout = '/homeLayout';
  static const shimmerLoading = '/shimmerLoading';

  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegistrationCubit(
                  RepositoryProvider.of<CustomerRepository>(context),
                  RepositoryProvider.of<FirebaseRepository>(context),
                  connection,
                ),
              ),
              BlocProvider(
                create: (context) => LoginCubit(
                  RepositoryProvider.of<CustomerRepository>(context),
                  connection,
                  RepositoryProvider.of<FirebaseRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => FacebookCubit(
                  RepositoryProvider.of<CustomerRepository>(context),
                  RepositoryProvider.of<FirebaseRepository>(context),
                  connection,
                ),
              ),
              BlocProvider(
                create: (context) => GoogleCubit(
                  RepositoryProvider.of<CustomerRepository>(context),
                  RepositoryProvider.of<FirebaseRepository>(context),
                  connection,
                ),
              ),
              BlocProvider(
                create: (context) => AppleCubit(
                  RepositoryProvider.of<CustomerRepository>(context),
                  RepositoryProvider.of<FirebaseRepository>(context),
                  connection,
                ),
                lazy: false,
              ),
            ],
            child: AuthScreen(),
          ),
        );
      case language:
        return MaterialPageRoute(
          builder: (context) => LanguageScreen(),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            authBloc: FirebaseAuthBloc.get(context)..add(InitialEvent()),
          ),
        );
      case loadingScreen:
        return MaterialPageRoute(
          builder: (context) => const LoadingSpinner(),
        );
      case shimmerLoading:
        return MaterialPageRoute(
          builder: (context) => const ShimmerLoading(),
        );
      case homeLayout:
        return MaterialPageRoute(
          builder: (context) => HomeLayout(reload: args as bool?),
        );

      default:
        throw RouteExceptions('Route Not Found');
    }
  }
}
