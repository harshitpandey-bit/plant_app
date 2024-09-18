import 'package:get/get.dart';

import '../models/cart.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addItem(CartItem item) {
    final existingItem = cartItems.firstWhereOrNull((element) => element.id == item.id);
    if (existingItem != null) {
      existingItem.quantity += item.quantity;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  void removeItem(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }


  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
}
