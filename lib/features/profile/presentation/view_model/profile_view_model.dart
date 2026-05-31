import 'package:ecommerce_app/features/authentication/model/user_model.dart';
import 'package:ecommerce_app/features/profile/data/repo/profile_repo.dart';
import 'package:ecommerce_app/features/profile/models/profile_result_state.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../authentication/data/auth_repository/auth_repositroy.dart';
import '../../../checkout/model/order.dart';
import '../../../home/data/api_error_handling/network_exceptions.dart';

class ProfileViewModel extends GetxController {
  final AuthRepository _authRepository;
  final ProfileRepo _profileRepo;

  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isLoading = false.obs;
  final RxBool orderIsLoading = false.obs;
  late RxList<OrderModel> orders=<OrderModel>[].obs;
  RxString errorMessage = ''.obs;

  ProfileViewModel(this._authRepository, this._profileRepo);

  @override
  void onInit() {
    super.onInit();
    getUserData();
    fetchOrders();
  }

  void signOut() async {
    await _authRepository.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      final userData = await _profileRepo.fetchUserDataFromFirebase();
      user.value = userData;
    } catch (e) {
      final exception = NetworkExceptions.getDioException(e);
      errorMessage = NetworkExceptions.getErrorMessage(exception).obs;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrders() async {
    try {
      orderIsLoading.value = true;
      final fetchedOrders = await _profileRepo.getOrders();

      fetchedOrders.when(
        success: (ordersList) {


          ordersList.sort((a, b) => b.orderDate.compareTo(a.orderDate));

          this.orders.assignAll(ordersList);
        },
        error: (networkExceptions) {

          errorMessage.value = NetworkExceptions.getErrorMessage(networkExceptions);
        },
      );
    } catch (e) {


      final exception = NetworkExceptions.getDioException(e);
      errorMessage.value = NetworkExceptions.getErrorMessage(exception);
    } finally {
      orderIsLoading.value = false;
    }
  }
}
