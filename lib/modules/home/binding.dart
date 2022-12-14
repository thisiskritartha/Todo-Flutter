import 'package:get/get.dart';
import 'package:todo_app/modules/home/controller.dart';
import '../../data/providors/task/providor.dart';
import '../../services/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvidor: TaskProvidor(),
        ),
      ),
    );
  }
}
