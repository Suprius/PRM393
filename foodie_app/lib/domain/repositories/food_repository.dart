import '../models/category.dart';
import '../models/food.dart';

abstract interface class FoodRepository {
  List<Category> getCategories();
  List<Food> getFoods();
  List<Food> getPopularFoods();
  List<Food> getFoodsByCategory(String categoryId);
  List<Food> searchFoods(String query, {String? categoryId});
}
