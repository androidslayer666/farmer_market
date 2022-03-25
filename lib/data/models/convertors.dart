
import 'package:farmer_market/data/models/product/category.dart';
import 'package:farmer_market/data/models/user/user.dart';

import 'api/address.dart';
import 'cart/cart_item.dart';
import 'chat/message.dart';

// the functions that is just redirecting to correct json convertors
Address? addressFromJson(Map<String, dynamic>? json) => json != null ? Address.fromJson(json) : null;
Map<String, dynamic>? addressToJson(Address? address) => address?.toJson();


List<Map<String, dynamic>>? listCartItemsToJson(List<CartItem>? listCartItems) {
  if(listCartItems != null) {
    return listCartItems.map((cartItem) => cartItem.toJson()).toList();
  }
  return null;
}

List<Map<String, dynamic>>? listMessagesToJson(List<Message>? listMessages) {
  if(listMessages != null) {
    return listMessages.map((message) => message.toJson()).toList();
  }
  return null;
}

Map<String, dynamic>? userToJson(User? user) => user?.toJson();

Category? categoryFromJson(String? json) {
  switch(json) {
    case 'cheese': return Category.cheese;
    case 'meat': return Category.meat;
    case 'milk': return Category.milk;
    case null: return null;
  }
}
String? categoryToJson(Category? category) {
  switch(category) {
    case Category.cheese: return 'cheese';
    case Category.meat: return 'meat';
    case Category.milk: return 'milk';
    case null: return null;
  }
}

List<String>? listCategoriesToJson(List<Category>? listCategory) {
  if(listCategory != null) {
    return listCategory.map((cartItem) => cartItem.toString()).toList();
  }
  return null;
}

List<Category>? listCategoriesFromJson(List<String>? strings) {
  return strings?.map((e) => categoryFromJson(e)).whereType<Category>().toList();
}