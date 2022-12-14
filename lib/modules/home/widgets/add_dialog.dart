import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final controller = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.textController.clear();
                        controller.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.task.value == null) {
                            EasyLoading.showError(
                                'Please Select the Task Type');
                          } else {
                            var success = controller.updateTask(
                              controller.task.value!,
                              controller.textController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess(
                                  'ToDo Item Added Successfully.');
                              Get.back();
                              controller.changeTask(null);
                            } else {
                              EasyLoading.showError(
                                  'ToDo Item Already Existed.');
                            }
                            controller.textController.clear();
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'New Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter your Task';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 5.0.wp, top: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...controller.tasks.map((element) => Obx(
                    () => InkWell(
                      onTap: () {
                        controller.task.value = element;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 5.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(element.icon,
                                      fontFamily: 'MaterialIcons'),
                                  color: HexColor.fromHex(element.color),
                                ),
                                SizedBox(width: 3.0.wp),
                                Text(
                                  element.title,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (controller.task.value == element)
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
