import 'package:flutter/material.dart';

import '../services/data_services.dart';

class YourScreen extends StatelessWidget {
  final DataServices _services = DataServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _services.getUsers(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                final user = snapshot.data![index];
                return ListTile(
                  leading: Image.network(user['imageUrl']),
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Text(user['age'].toString()),
                  onTap: () {
                    // Handle onTap event
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
