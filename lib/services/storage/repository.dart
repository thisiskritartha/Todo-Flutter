import 'package:todo_app/data/providors/task/providor.dart';
import '../../data/models/task.dart';

class TaskRepository {
  TaskProvidor taskProvidor;
  TaskRepository({required this.taskProvidor});
  List<Task> readTask() => taskProvidor.readTask();
  void writeTask(List<Task> task) => taskProvidor.writeTask(task);
}
