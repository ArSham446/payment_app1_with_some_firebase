import 'package:firebase_database/firebase_database.dart';

class DataServices {
  final databaseReference = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> list = [];
  Future<List<Map<String, dynamic>>> getUsers() async {
    DataSnapshot dataSnapshot = await databaseReference
        .child('users')
        .once()
        .then((value) => value.snapshot);

    list.clear();
    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> dataMap =
          dataSnapshot.value as Map<dynamic, dynamic>;
      dataMap.forEach((key, value) {
        Map<String, dynamic> user = Map<String, dynamic>.from(value);
        user['id'] = key;
        list.add(user);
      });
    }

    return Future.delayed(
      const Duration(seconds: 1),
      () => list.map((e) => e).toList(),
    );
  }
}
