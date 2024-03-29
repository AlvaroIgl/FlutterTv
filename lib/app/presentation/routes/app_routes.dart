import 'package:flutter/material.dart';

import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sing_in/views/sing_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.favorites: (context) => const FavoritesView(),
    Routes.profile: (context) => const ProfileView(),
  };
}
