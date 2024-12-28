import 'package:get/get.dart';
import '../models/fotocopy_model.dart';

class FotocopyProvider extends GetConnect {
  Future<List<FotocopyModel>> fetchFotocopies() async {
    final response = await get('https://api.example.com/fotocopy');
    if (response.statusCode == 200) {
      List data = response.body;
      return data.map((item) => FotocopyModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load fotocopies');
    }
  }
}
