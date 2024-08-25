import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myresto/feature/core/presentation/screens/main_screen.dart';
import '../feature/home/presentation/screens/restaurant_detail.dart';
import '../feature/home/presentation/screens/restaurant_screen.dart';
import '../feature/core/presentation/screens/splash_screen.dart';
import '../feature/home/bloc/restaurant_bloc.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      settings;
      switch (settings.name) {
        case AppRoutes.splash:
          return const SplashScreen();
        case AppRoutes.main:
          return const MainScreen();
        case AppRoutes.restaurant:
          return const RestaurantScreen();
        case AppRoutes.restaurantDetail:
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => RestaurantBloc(),
            child: RestaurantDetail(
              restaurantId: args['restaurantId'],
            ),
          );
        // case AppRoutes.main:
        //   return const MainScreen();
        default:
          return const Scaffold(
            body: Center(
              child: Text(
                'Check Named Routes',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          );
      }
    });
  }
}
