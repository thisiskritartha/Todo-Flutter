import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/modules/home/controller.dart';
import '../../../data/models/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../details/veiw.dart';

class TaskCard extends StatelessWidget {
  TaskCard({Key? key, required this.task}) : super(key: key);
  final controller = Get.find<HomeController>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);

    return GestureDetector(
      onTap: () {
        controller.changeTask(task);
        controller.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        height: squareWidth / 2,
        width: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              offset: const Offset(0, 7),
              blurRadius: 7.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: controller.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: controller.isTodoEmpty(task)
                  ? 0
                  : controller.getDoneTodos(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.7), color],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.wp),
                  Text(
                    '${task.todos?.length ?? 0} Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
