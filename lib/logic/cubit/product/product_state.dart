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
