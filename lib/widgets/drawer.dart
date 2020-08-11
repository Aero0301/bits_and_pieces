import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authenthicaton_bloc/authentication_bloc.dart';
import '../blocs/navigation_bloc/navigation_bloc.dart';

class SideDrawer extends StatelessWidget {
  void showDevInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          'About Dev',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.black,
              ),
        ),
        children: <Widget>[
          Column(
            children: <Widget>[],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentScreen =
        (BlocProvider.of<NavigationBloc>(context).state as NavigationDefault)
            .currentSection;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: ThemeData.dark().canvasColor,
          ),
          child: Drawer(
            elevation: 20,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (authState is Authenticated)
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).padding.top + 20.0),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(authState.firebaseUser.photoUrl),
                          ),
                          ExpansionTile(
                            title: Text(
                              authState.firebaseUser.displayName,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            subtitle: Text(
                              authState.firebaseUser.email,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Logout',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                trailing: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<NavigationBloc>(context)
                                      .add(NavigateToLoginScreen());
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ListTile(
                    title: Text(
                      'Courses',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: currentScreen == Section.CoursesScreen
                                ? Theme.of(context).accentColor
                                : Colors.white,
                          ),
                    ),
                    trailing: Icon(
                      Icons.book,
                      color: currentScreen == Section.CoursesScreen
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToCoursesList());
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Expense Tracker',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: currentScreen == Section.ExpensesScreen
                                ? Theme.of(context).accentColor
                                : Colors.white,
                          ),
                    ),
                    trailing: Icon(
                      Icons.attach_money,
                      color: currentScreen == Section.ExpensesScreen
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToExpenses());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
