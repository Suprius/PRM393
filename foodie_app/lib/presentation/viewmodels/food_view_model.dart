import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/mock_food_repository.dart';
import '../../domain/models/category.dart';
import '../../domain/models/food.dart';
import '../../domain/repositories/food_repository.dart';

part 'food_view_model.g.dart';

@riverpod
FoodRepository foodRepository(Ref ref) => MockFoodRepository();

@riverpod
List<Category> categories(Ref ref) =>
    ref.watch(foodRepositoryProvider).getCategories();

@riverpod
List<Food> popularFoods(Ref ref) =>
    ref.watch(foodRepositoryProvider).getPopularFoods();

class FoodFilterState {
  const FoodFilterState({this.categoryId, this.query = ''});
  final String? categoryId;
  final String query;

  FoodFilterState copyWith({
    String? categoryId,
    String? query,
    bool clearCategory = false,
  }) {
    return FoodFilterState(
      categoryId: clearCategory ? null : categoryId ?? this.categoryId,
      query: query ?? this.query,
    );
  }
}

@riverpod
class FoodFilter extends _$FoodFilter {
  @override
  FoodFilterState build() => const FoodFilterState();

  void selectCategory(String categoryId) =>
      state = state.copyWith(categoryId: categoryId, query: '');
  void showAll() => state = state.copyWith(clearCategory: true, query: '');
  void search(String value) => state = state.copyWith(query: value);
}

@riverpod
List<Food> visibleFoods(Ref ref) {
  final filter = ref.watch(foodFilterProvider);
  return ref
      .watch(foodRepositoryProvider)
      .searchFoods(filter.query, categoryId: filter.categoryId);
}

@riverpod
String foodsPageTitle(Ref ref) {
  final selectedId = ref.watch(foodFilterProvider).categoryId;
  if (selectedId == null) return 'All Foods';
  final categories = ref.watch(categoriesProvider);
  return categories
      .firstWhere(
        (category) => category.categoryId == selectedId,
        orElse: () =>
            const Category(categoryId: '', categoryName: 'Foods', image: ''),
      )
      .categoryName;
}
