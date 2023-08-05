import 'package:get/get.dart';

import '../services/data_services.dart';


class DataController extends GetxController {
  var list = [].obs;

  final service = DataServices();
  final _loading = false.obs;

  get loading => _loading.value;

  get newList {
    return list.where((c) => c['status']).map((e) => e).toList();
  }

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  _loadData() async {
    _loading.value = false;
    try {
      list.clear();
      var info = await service.getUsers();
      list.addAll(info);
    } catch (e) {
      print(e);
    } finally {
      _loading.value = true;
    }
  }

  get loadData => _loadData();
}
