

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

class ProductDetailArguments{
  Product? product;

  ProductDetailArguments({required this.product});
}