import 'package:bloc/bloc.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/data/models/products_list_model.dart';
import 'package:hospital25/data/repositories/products_repository.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';
import 'package:meta/meta.dart';

import '../internet/internet_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InternetCubit connection;
  final ProductsRepository productsRepo;
  ProductCubit(this.connection, this.productsRepo) : super(ProductInitial());

  static ProductCubit get(BuildContext context) => BlocProvider.of(context);

  static List<ProductsListModel>? products;

  Future<void> getAllProducts()async{
    emit(GetAllProductsLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GetAllProductsFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        products = await productsRepo.getAllProducts() as List<ProductsListModel>;
        print(products![0].name);
        emit(GetAllProductsSuccess());
      } catch (e) {
        print('get products error: $e');
        emit(GetAllProductsFailed(error: e.toString()));
      }
    }
  }

}
