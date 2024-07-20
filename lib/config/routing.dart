import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offers_hub/features/authentication/auth_ui.dart';
import 'package:offers_hub/features/home_page.dart';
import 'package:offers_hub/features/share_reward/presentation/ui/profile_page.dart';
import 'package:offers_hub/features/share_reward/presentation/ui/rewards_view.dart';
import 'package:offers_hub/utilis/constants.dart';
import 'package:offers_hub/utilis/snackbar.dart';

bool showLoginMsg = true;

final GoRouter appRoutes = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'auth',
    builder: (context, state) => Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (isGuest) {
            WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) => AppSnackBar.showSnackBar('Logged in as guest.'));
            return HomePage();
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (showLoginMsg) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                    AppSnackBar.showSnackBar('Login Successful.'));
                showLoginMsg = false;
              }

              return HomePage();
            } else if (!snapshot.hasData) {
              return AuthUI();
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  AppSnackBar.showSnackBar(snapshot.error, colorGreen: false));
              return AuthUI();
            } else {
              return AuthUI();
            }
          }
        },
      ),
    ),
  ),
  GoRoute(
      path: '/rewards',
      name: 'rewards',
      builder: (context, state) {
        final key = state.extra as GlobalKey<ScaffoldState>;
        return RewardsPage(rewardDrawerKey: key);
      }),
  GoRoute(
    path: '/profile',
    name: 'profile',
    builder: (context, state) => ProfilePage(),
  ),
]);
