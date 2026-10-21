import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_app/data/repositories/mock_food_repository.dart';

void main() {
  final repository = MockFoodRepository();

  test('popular foods have rating at least 4.5', () {
    final popularFoods = repository.getPopularFoods();

    expect(popularFoods, isNotEmpty);
    expect(popularFoods.every((food) => food.star >= 4.5), isTrue);
  });

  test('foods can be filtered by category', () {
    final burgers = repository.getFoodsByCategory('burger');

    expect(burgers.map((food) => food.foodId), containsAll(['f01', 'f02']));
    expect(burgers, hasLength(2));
  });

  test('search respects selected category', () {
    final result = repository.searchFoods('pepperoni', categoryId: 'pizza');

    expect(result, hasLength(1));
    expect(result.single.foodName, 'Pepperoni Pizza');
  });
}
