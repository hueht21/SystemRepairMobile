import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:systemrepair/base_utils/repository_base/base_request.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../modules/register_account/model/account_model.dart';

late Box HIVE_APP;

class AppController extends GetxController {
  RxBool isLogin = false.obs;

  @override
  Future<void> onInit() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryprionKey = await secureStorage.read(key: 'key');
    if (encryprionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);

    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(appDocumentDirectory.path);

    Hive.registerAdapter(AccountModelAdapter());
    HIVE_APP = await Hive.openBox("hive_app_project",
        encryptionCipher: HiveAesCipher(encryptionKey));


    Get.put(BaseRequest(), permanent: true);

    await FirebaseMessaging.instance.getToken().then((token) {

      log(token??"");
    });
    super.onInit();
  }
}
