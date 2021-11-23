import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class FireStorage {
  static Future uploadImageToFirebase(BuildContext context, {required File file}) async {
    String fileName = basename(file.path);

    FirebaseStorage.instance.ref('teacher/$fileName').putFile(file).whenComplete(
          () => print('upload done'),
        );
  }
}
