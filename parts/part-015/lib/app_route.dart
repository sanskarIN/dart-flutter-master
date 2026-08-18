class AppRoute {
  const AppRoute._(this.itemId);

  const AppRoute.home() : this._(null);

  const AppRoute.item(int id) : this._(id);

  final int? itemId;

  bool get isHome => itemId == null;

  static AppRoute parse(String? location) {
    final uri = Uri.tryParse(location ?? '/') ?? Uri(path: '/');

    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'items') {
      final id = int.tryParse(uri.pathSegments[1]);
      if (id != null && id > 0) return AppRoute.item(id);
    }

    return const AppRoute.home();
  }

  String get location => itemId == null ? '/' : '/items/$itemId';
}
