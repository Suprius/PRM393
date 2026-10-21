import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_view_model.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() => 0;
  void select(int index) => state = index;
}
