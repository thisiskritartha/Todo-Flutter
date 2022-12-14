import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/modules/details/widgets/doing_list.dart';
import 'package:todo_app/modules/details/widgets/done_list.dart';
import 'package:todo_app/modules/home/controller.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final controller = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = controller.task.value!;
    var color = HexColor.fromHex(task.color);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.updateTodos();
                        controller.textController.clear();
                        controller.changeTask(null);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                        color: color),
                    SizedBox(width: 3.0.wp),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    controller.doingTodos.length + controller.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Task',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 3.0.sp),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: controller.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.7), color],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[400]!],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
                child: TextFormField(
                  controller: controller.textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400]!,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          var success = controller
                              .addTodo(controller.textController.text);
                          if (success) {
                            EasyLoading.showSuccess(
                                'Todo Item Added Successfully');
                          } else {
                            EasyLoading.showError('Todo Item Already Exit.');
                          }
                          controller.textController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter the Todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
