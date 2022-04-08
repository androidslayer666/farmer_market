import 'package:equatable/equatable.dart';

import '../../../../data/models/product/product.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailOnInit extends ProductDetailEvent {
  final Product? product;

  const ProductDetailOnInit(this.product);
}

class ProductDetailReviewTextChanged extends ProductDetailEvent {
  const ProductDetailReviewTextChanged({required this.text});

  final String text;
}

class ProductDetailReviewRateChanged extends ProductDetailEvent {
  const ProductDetailReviewRateChanged({required this.rate});

  final double rate;
}

class ProductDetailToggleReview extends ProductDetailEvent {
  const ProductDetailToggleReview();
}

class ProductDetailAddReviewClicked extends ProductDetailEvent {
  const ProductDetailAddReviewClicked();
}
