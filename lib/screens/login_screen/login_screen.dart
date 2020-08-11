import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import '../../blocs/authenthicaton_bloc/authentication_bloc.dart';
import '../../blocs/navigation_bloc/navigation_bloc.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';
  final UserRepository _userRepository;

  LoginScreen(UserRepository userRepository)
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Logo(120),
              ),
              BlocProvider(
                create: (_) => LoginBloc(userRepository: _userRepository),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedIn());
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToCoursesList());
                    }
                    if (state is LoginFailed) {
                      Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 4),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Login Failed',
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.error,
                                  color: Theme.of(context).errorColor,
                                )
                              ],
                            ),
                          ),
                        );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return RaisedButton.icon(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginWithGooglePressed());
                        },
                        textColor: Colors.white,
                        label: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Login with Google',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        icon: ImageIcon(
                          AssetImage('assets/images/Google_Logo.png'),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
