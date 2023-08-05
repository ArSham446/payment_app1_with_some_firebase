import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseController {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Future<void> storeUserData(
      String brand_name, int due, String dueinfo, File? image) async {
    try {
      String newID = databaseReference.child('users').push().key!;
      String imageUrl = '';
      if (image != null) {
        final Reference storageReference =
            FirebaseStorage.instance.ref().child('images/$newID.jpg');
        await storageReference.putFile(image);
        imageUrl = await storageReference.getDownloadURL();
      }
      await databaseReference.child('users/$newID').set({
        'BrandName': brand_name,
        'Due': due,
        'DueInfo': dueinfo,
        'imageUrl': imageUrl,
        'status': false,
        'key': newID,
      });
    } on FirebaseException catch (error) {
      print('Error storing user data: ${error.message}');
      rethrow;
    } catch (error) {
      print('Error storing user data: $error');
      rethrow;
    }
  }
}
