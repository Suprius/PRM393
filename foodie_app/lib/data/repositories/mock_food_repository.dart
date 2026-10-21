import '../../domain/models/category.dart';
import '../../domain/models/food.dart';
import '../../domain/repositories/food_repository.dart';

class MockFoodRepository implements FoodRepository {
  static const _categories = <Category>[
    Category(
      categoryId: 'burger',
      categoryName: 'Burgers',
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
    ),
    Category(
      categoryId: 'pizza',
      categoryName: 'Pizza',
      image:
          'https://images.unsplash.com/photo-1579751626657-72bc17010498?w=500',
    ),
    Category(
      categoryId: 'noodles',
      categoryName: 'Noodles',
      image:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
    ),
    Category(
      categoryId: 'salad',
      categoryName: 'Salads',
      image:
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500',
    ),
    Category(
      categoryId: 'dessert',
      categoryName: 'Desserts',
      image: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=500',
    ),
  ];

  static const _foods = <Food>[
    Food(
      foodId: 'f01',
      foodName: 'Classic Cheese Burger',
      price: 6.99,
      star: 4.8,
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=900',
    ),
    Food(
      foodId: 'f02',
      foodName: 'Double Beef Burger',
      price: 9.49,
      star: 4.6,
      image: 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=900',
    ),
    Food(
      foodId: 'f03',
      foodName: 'Margherita Pizza',
      price: 8.99,
      star: 4.7,
      image:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=900',
    ),
    Food(
      foodId: 'f04',
      foodName: 'Pepperoni Pizza',
      price: 11.50,
      star: 4.4,
      image:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=900',
    ),
    Food(
      foodId: 'f05',
      foodName: 'Spicy Ramen',
      price: 7.75,
      star: 4.9,
      image:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=900',
    ),
    Food(
      foodId: 'f06',
      foodName: 'Chicken Noodles',
      price: 7.25,
      star: 4.3,
      image: 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=900',
    ),
    Food(
      foodId: 'f07',
      foodName: 'Avocado Garden Salad',
      price: 6.50,
      star: 4.6,
      image:
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=900',
    ),
    Food(
      foodId: 'f08',
      foodName: 'Caesar Salad',
      price: 6.25,
      star: 4.2,
      image: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=900',
    ),
    Food(
      foodId: 'f09',
      foodName: 'Chocolate Donut',
      price: 3.25,
      star: 4.8,
      image: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=900',
    ),
    Food(
      foodId: 'f10',
      foodName: 'Berry Pancakes',
      price: 5.95,
      star: 4.5,
      image:
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=900',
    ),
  ];

  static const _categoryFoodIds = <String, Set<String>>{
    'burger': {'f01', 'f02'},
    'pizza': {'f03', 'f04'},
    'noodles': {'f05', 'f06'},
    'salad': {'f07', 'f08'},
    'dessert': {'f09', 'f10'},
  };

  @override
  List<Category> getCategories() => List.unmodifiable(_categories);
  @override
  List<Food> getFoods() => List.unmodifiable(_foods);
  @override
  List<Food> getPopularFoods() =>
      _foods.where((food) => food.star >= 4.5).toList(growable: false);
  @override
  List<Food> getFoodsByCategory(String categoryId) {
    final foodIds = _categoryFoodIds[categoryId] ?? const <String>{};
    return _foods
        .where((food) => foodIds.contains(food.foodId))
        .toList(growable: false);
  }

  @override
  List<Food> searchFoods(String query, {String? categoryId}) {
    final source = categoryId == null || categoryId.isEmpty
        ? _foods
        : getFoodsByCategory(categoryId);
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return List.unmodifiable(source);
    return source
        .where((food) => food.foodName.toLowerCase().contains(normalizedQuery))
        .toList(growable: false);
  }
}
