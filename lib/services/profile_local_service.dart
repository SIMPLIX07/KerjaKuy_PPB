import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../database/db_helper.dart';

class ProfileLocalService {
  static Future<void> saveProfileImage({
    required int userId,
    required File imageFile,
  }) async {
    final dir = await getApplicationDocumentsDirectory();

    final newPath =
        "${dir.path}/profile_${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final savedFile = await imageFile.copy(newPath);

    await DBHelper.updateUserPhoto(userId: userId, photoPath: savedFile.path);
  }
}
