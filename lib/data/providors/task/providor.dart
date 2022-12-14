import 'dart:convert';
import 'package:get/get.dart';
import 'package:todo_app/core/utils/keys.dart';
import 'package:todo_app/services/storage/services.dart';
import '../../models/task.dart';

//Read and write to the local storage file
class TaskProvidor {
  final StorageService _storage = Get.find<StorageService>();

  List<Task> readTask() {
    var task = <Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach(
      (e) => task.add(
        Task.fromJson(e),
      ),
    );
    return task;
  }

  void writeTask(List<Task> task) {
    _storage.write(taskKey, jsonEncode(task));
  }
}
