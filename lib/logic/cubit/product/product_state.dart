part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetAllProductsLoading extends ProductState {}

class GetAllProductsSuccess extends ProductState {}

class GetAllProductsFailed extends ProductState {
  final String error;

  GetAllProductsFailed({required this.error});

}

class GetCartLoading extends ProductState {}

class GetCartSuccess extends ProductState {}

class GetCartFailed extends ProductState {
  final String error;

  GetCartFailed({required this.error});

}

class AddToCartLoading extends ProductState {}

class AddToCartSuccess extends ProductState {}

class AddToCartFailed extends ProductState {
  final String error;

  AddToCartFailed({required this.error});

}

class CheckOutLoading extends ProductState {}

class CheckOutSuccess extends ProductState {}

class CheckOutFailed extends ProductState {
  final String error;

  CheckOutFailed({required this.error});

}
