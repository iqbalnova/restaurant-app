import 'package:flutter/material.dart';
import '../feature/home/presentation/screens/restaurant_detail.dart';
import '../feature/home/presentation/screens/restaurant_screen.dart';
import '../feature/core/presentation/screens/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      return Builder(
        builder: (BuildContext context) {
          switch (settings.name) {
            case AppRoutes.splash:
              return const SplashScreen();
            case AppRoutes.restaurant:
              return const RestaurantScreen();
            case AppRoutes.restaurantDetail:
              final Map<String, dynamic> args =
                  settings.arguments as Map<String, dynamic>;
              return RestaurantDetail(
                restaurant: args['detailRestaurant'],
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
        },
      );
    });
  }
}
