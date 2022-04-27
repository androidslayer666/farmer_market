

import '../../data/models/chat/chat.dart';
import '../../data/models/filter/filter.dart';
import '../../data/models/product/product.dart';
import '../../data/models/user/user.dart';

class AddProductArguments{
  Product? product;

  AddProductArguments({required this.product});
}

class UserDetailArguments{
  User? user;

  UserDetailArguments({required this.user});
}

class ChatDetailArguments{
  Chat? chat;

  ChatDetailArguments({required this.chat});
}

class ProductDetailArguments{
  Product? product;

  ProductDetailArguments({required this.product});
}

class FilterArguments{
  Filter? filter;

  FilterArguments({required this.filter});
}