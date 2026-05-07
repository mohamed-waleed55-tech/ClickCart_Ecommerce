import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/ecommerce_app.dart';
import 'features/home/data/category_repository/category_repository_imp.dart';
import 'features/home/data/products_repository/products_repository_imp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(EcommerceApp());
}
