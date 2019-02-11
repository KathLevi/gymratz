import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';

class StorageAPI {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image, String gymId, String routeName) async{
    //TO DO: Generate random string for file name  and ID
    StorageReference ref = _storage.ref().child(gymId).child(routeName+'.jpg');
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}