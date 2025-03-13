import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/screen/home_page.dart';
import 'package:quiz_app/screen/login_page.dart';
import 'package:quiz_app/screen/signup_page.dart';
import 'package:quiz_app/servise/pocketbase_service.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

Page<void> noTransitionPageBuilder(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // No animation
    },
  );
}

final router = GoRouter(
  initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = pocketBaseService.isAuthenticated();
      final isLoggingIn = state.matchedLocation == '/login';
      final isSigningUp = state.matchedLocation == '/signup';

      if (!isAuthenticated && !isLoggingIn && !isSigningUp) {
        return '/login'; // Redirect to login if not authenticated and not on login/signu
      }
      if (isAuthenticated && (isLoggingIn || isSigningUp)) {
        return '/'; // Redirect authenticated users away from login/signup pages
      }
      return null;
    },
    routes: [
  
      GoRoute(path: '/', builder: (context, state) =>  HomePage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    ]);
