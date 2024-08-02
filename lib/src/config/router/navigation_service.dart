abstract class NavigationService {
  void navigateTo(String route);
  void pop();
  void pushNamed(String name, {Object? arguments});
}
