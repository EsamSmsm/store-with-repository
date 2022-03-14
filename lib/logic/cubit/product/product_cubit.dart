import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/data/models/cart_model.dart';
import 'package:hospital25/data/models/products_list_model.dart';
import 'package:hospital25/data/repositories/products_repository.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InternetCubit connection;
  final ProductsRepository productsRepo;
  ProductCubit(this.connection, this.productsRepo) : super(ProductInitial());

  static ProductCubit get(BuildContext context) => BlocProvider.of(context);

   List<ProductsListModel>? products;
   CartModel? cart;

  Future<void> getAllProducts()async{
    emit(GetAllProductsLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GetAllProductsFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        products = await productsRepo.getAllProducts();
        print(products![0].name);
        emit(GetAllProductsSuccess());
      } catch (e) {
        print('get products error: $e');
        emit(GetAllProductsFailed(error: e.toString()));
      }
    }
  }

  Future<void> getCart()async{
    emit(GetCartLoading());
    if (connection.state is InternetConnectionFail) {
      emit(GetCartFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        cart = await productsRepo.getCart();
        emit(GetCartSuccess());
      } catch (e) {
        print('get cart error: $e');
        emit(GetCartFailed(error: e.toString()));
      }
    }
  }

  Future<void> addToCart({required String? id,required String? quantity})async{
    emit(AddToCartLoading());
    if (connection.state is InternetConnectionFail) {
      emit(AddToCartFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        cart = await productsRepo.addToCart(id: id, quantity: quantity);
        print(cart!.items[1].quantity);
        emit(AddToCartSuccess());
      } catch (e) {
        print('add to cart error: $e');
        emit(AddToCartFailed(error: e.toString()));
      }
    }
  }

  void fetchData(){
    getAllProducts();
    getCart();
  }
  
}
