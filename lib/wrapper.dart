import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/navigation_bloc/navigation_bloc.dart';
import './screens/splash_screen.dart';
import './blocs/authenthicaton_bloc/authentication_bloc.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        if (authState is Authenticated) {
          BlocProvider.of<NavigationBloc>(context).add(NavigateToCoursesList());
        } else if (authState is Unauthenticated) {
          BlocProvider.of<NavigationBloc>(context).add(NavigateToLoginScreen());
        }
      },
      child: SplashScreen(),
    );
  }
}
