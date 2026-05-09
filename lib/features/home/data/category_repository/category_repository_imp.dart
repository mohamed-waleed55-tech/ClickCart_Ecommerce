import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/home/model/categorey/category_model.dart';

import 'category_repository.dart';

class CategoryRepositoryImp extends CategoryRepository {

  final CollectionReference<CategoryModel> _categoryCollection =
      FirebaseFirestore.instance
          .collection('categories')
          .withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) =>
                CategoryModel.fromJson(snapshot.data()!),
            toFirestore: (category, _) => category.toJson(),
          );

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final querySnapshot = await _categoryCollection.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Failed to load categories");
    }
  }
}

//   Future<void> addCategory() async {
//     try {
//       await Future.wait(
//         // CategoryModel.categories.map(
//         //   (category) => _categoryCollection.doc(category.id).set(category),
//         ),
//       );
//     } catch (e) {
//       throw Exception("Failed to add categories");
//     }
//   }
// }
