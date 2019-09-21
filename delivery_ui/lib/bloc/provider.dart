import 'package:delivery_ui/model/foodItem.dart';

class CartProvider {
  List<FoodItem> foodItems = [];

  List<FoodItem> addToList(FoodItem foodItem) {
    bool isPresent = false;

    // Logica para aumentar a quantidade de um mesmo ID

    if (foodItems.length > 0) {
      for (var i = 0; i < foodItems.length; i++) {
        if (foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodItem foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(FoodItem foodItem) => foodItem.decrementQuantity();

  List<FoodItem> removeFromList(FoodItem foodItem) {
    foodItems.remove(foodItem);
    return foodItems;
  }
}
