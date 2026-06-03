import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final GetStorage _storage = GetStorage();

  static const String _firstTimeKey = 'is_first_time';


  bool isFirstTime() {
    return _storage.read<bool>(_firstTimeKey) ?? true;
  }

  Future<void> setFirstTimeComplete() async {
    await _storage.write(_firstTimeKey, false);
  }
}