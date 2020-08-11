part of 'navigation_bloc.dart';

enum Section {
  LoginScreen,
  CoursesScreen,
  ExpensesScreen,
}

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationDefault extends NavigationState {
  final Section currentSection;

  NavigationDefault(this.currentSection);
  @override
  List<Object> get props => [currentSection];
}