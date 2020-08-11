import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './simple_bloc_delegate.dart';
import './wrapper.dart';
import './blocs/authenthicaton_bloc/authentication_bloc.dart';
import './repositories/user_repository.dart';
import './blocs/courses_bloc/courses_bloc.dart';
import './blocs/navigation_bloc/navigation_bloc.dart';
import './screens/add_course_screen/add_course_screen.dart';
import './screens/course_detail_screen/course_detail_screen.dart';
import './screens/courses_screen/courses_screen.dart';
import './screens/login_screen/login_screen.dart';
import './screens/expenses_screen/expenses_screen.dart';
import './blocs/expenses_bloc/expenses_bloc.dart';
import './screens/expenses_info_screen/expenses_info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: const Color(0xFF002DCA),
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(userRepository: _userRepository)
            ..add(AppStarted()),
        ),
        BlocProvider(
          create: (_) => CoursesBloc(),
        ),
        BlocProvider(
          create: (_) => NavigationBloc(_navigatorKey),
        ),
        BlocProvider(
          create: (_) => ExpensesBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BITS AIO',
        navigatorKey: _navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (_) => Wrapper(),
          LoginScreen.routeName: (_) => LoginScreen(_userRepository),
          AddCourseScreen.routeName: (_) => AddCourseScreen(),
          CourseDetailScreen.routeName: (_) => CourseDetailScreen(),
          CoursesScreen.routeName: (_) => CoursesScreen(),
          ExpensesScreen.routeName: (_) => ExpensesScreen(),
          ExpensesInfoScreen.routeName: (_) => ExpensesInfoScreen(),
        },
        theme: ThemeData(
          appBarTheme: ThemeData().appBarTheme.copyWith(
                elevation: 10,
              ),
          fontFamily: 'Futura',
          textTheme: Typography.englishLike2018.copyWith(
            headline5: Typography.englishLike2018.headline5.copyWith(
              fontFamily: 'Futura',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            bodyText1: Typography.englishLike2018.bodyText1.copyWith(
              fontFamily: 'Futura',
              color: Colors.white,
            ),
            headline6: Typography.englishLike2018.headline6.copyWith(
              fontFamily: 'Futura',
              color: Colors.white,
            ),
            caption: Typography.englishLike2018.caption.copyWith(
              fontFamily: 'Futura',
              color: Colors.white,
            ),
          ),
          applyElevationOverlayColor: true,
          unselectedWidgetColor: Colors.white,
          scaffoldBackgroundColor: ThemeData.dark().canvasColor,
          primaryColor: const Color(0xFF0055FF),
          accentColor: const Color(0xFFFFAA00),
          buttonTheme: ThemeData().buttonTheme.copyWith(
                buttonColor: const Color(0xFF0055FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 20,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
            backgroundColor: const Color(0xFFFFAA00),
          ),
          cardTheme: ThemeData().cardTheme.copyWith(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              ),
          snackBarTheme: SnackBarThemeData(
            actionTextColor: const Color(0xFF0055FF),
            backgroundColor: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentTextStyle: ThemeData().textTheme.bodyText1.copyWith(
                  fontFamily: 'Futura',
                  fontSize: 16,
                ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(10),
            labelStyle: ThemeData().textTheme.caption.copyWith(
                  fontFamily: 'Futura',
                  fontSize: 12,
                ),
            hintStyle: ThemeData().textTheme.caption.copyWith(
                  fontFamily: 'Futura',
                  fontSize: 12,
                ),
          ),
          bottomSheetTheme: ThemeData().bottomSheetTheme.copyWith(
                backgroundColor: ThemeData().bottomSheetTheme.backgroundColor,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
        ),
      ),
    );
  }
}
