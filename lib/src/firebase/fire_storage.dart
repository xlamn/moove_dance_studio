import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:path/path.dart';

class FireStorage {
  static Future uploadImageToFirebase(
    BuildContext context, {
    required File file,
    required ImageSelectionBloc imageSelectionBloc,
    required String reference,
  }) async {
    String fileName = basename(file.path);

    FirebaseStorage.instance.ref('$reference/$fileName').putFile(file).whenComplete(
          () => imageSelectionBloc.add(ImageSelectionRefreshed()),
        );
  }
}
