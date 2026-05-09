import '../../../cart/model/firestore_product.dart';
import '../../../home/data/products_repository/api_result.dart';
import '../../../home/model/api_response/product_model.dart';
import '../../model/user_model.dart';

abstract class UserRepository {
  Future<void> saveUser(UserModel user);
  Future<void> addProductToCart(  FirestoreProduct productId);
  Future<ApiResult<List<FirestoreProduct>>> getCartProducts() ;
}
