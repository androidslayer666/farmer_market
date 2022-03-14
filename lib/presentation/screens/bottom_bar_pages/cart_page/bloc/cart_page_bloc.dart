import 'package:bloc/bloc.dart';

import '../../../../../data/models/product/product.dart';
import '../../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../../data/repository/products/product_repository.dart';
import 'cart_page_event.dart';
import 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  CartPageBloc(
      {required AuthRepository authRepository,
      required ProductRepository productRepository})
      : _productRepository = productRepository,
        _authRepository = authRepository,
        super( CartPageState(productsWithQty: {Product(name: 'product name'): 1})) {
    on<CartPageInit>(_onInit);

  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  void _onInit(
      CartPageInit event,
      Emitter<CartPageState> emit
      ){

  }

}
