import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/data/models/address_model.dart';
import 'package:hospital25/data/models/cart_model.dart';
import 'package:hospital25/data/models/order_model.dart';
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
  OrderModel? order;

  Future<void> getAllProducts() async {
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

  Future<void> getCart() async {
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

  Future<void> deleteCart() async {
    emit(DeleteCartLoading());
    if (connection.state is InternetConnectionFail) {
      emit(DeleteCartFailed(error: LanguageAr().connectionFailed));
    } else {
      try {
        final String result = await productsRepo.deleteCart();
        result == '200'?emit(DeleteCartSuccess()):emit(DeleteCartFailed(error: 'get cart error: $result'));
      } catch (e) {
        print('get cart error: $e');
        emit(DeleteCartFailed(error: e.toString()));
      }
    }
  }

  Future<void> addToCart(
      {required String? id, required String? quantity}) async {
    emit(AddToCartLoading());
    if (connection.state is InternetConnectionFail) {
      emit(AddToCartFailed(error: LanguageAr().connectionFailed));
    } else {
      deleteCart().then((value) async {
        try {
          cart = await productsRepo.addToCart(id: id, quantity: quantity);
          print(cart!.totals!.totalPrice);
          emit(AddToCartSuccess());
        } catch (e) {
          print('add to cart error: $e');
          emit(AddToCartFailed(error: e.toString()));
        }
      });
      // try {
      //   cart = await productsRepo.addToCart(id: id, quantity: quantity);
      //   print(cart!.totals!.totalPrice);
      //   emit(AddToCartSuccess());
      // } catch (e) {
      //   print('add to cart error: $e');
      //   emit(AddToCartFailed(error: e.toString()));
      // }
    }
  }

  List lineItems = [];
  void fillCart(){
    for (final item in cart!.items) {
      print (item.name);
      lineItems.add({
        "product_id": item.id,
        "quantity": item.quantity,
        "subtotal": item.totals!.lineSubtotal,
        "subtotal_tax": item.totals!.lineSubtotalTax,
        "total": item.totals!.lineTotal,
        "total_tax": item.totals!.lineTotalTax
      });
    }
  }
  Future<void> checkOut({
    required AddressModel billing,
    required AddressModel shipping,
    required String paymentMethod,
    required String paymentTitle,
    required String customerId,
  }) async {
    emit(CheckOutLoading());
    if (connection.state is InternetConnectionFail) {
      emit(CheckOutFailed(error: LanguageAr().connectionFailed));

    } else {
      try {
        order = await productsRepo.checkOut(
            billing: billing,
            shipping: shipping,
            paymentMethod: paymentMethod,
            paymentTitle: paymentTitle,
            customerId: customerId,
            cart: lineItems);
        print(order!.number);
        emit(CheckOutSuccess(order!));
      } catch (e) {
        print('Checkout error: $e');
        emit(CheckOutFailed(error: e.toString()));
      }
    }
  }

  void fetchData() {
    getAllProducts();
    // getCart();
  }
}
