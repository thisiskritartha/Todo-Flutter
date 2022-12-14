import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/modules/home/controller.dart';
import 'package:todo_app/widgets/icons.dart';
import '../../../core/values/colors.dart';
import '../../../data/models/task.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
            title: 'Task Title',
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 20.0,
            content: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: controller.textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please Enter you Task Title.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map(
                            (e) => Obx(() {
                              final index = icons.indexOf(e);
                              return ChoiceChip(
                                selectedColor: Colors.grey[300],
                                backgroundColor: Colors.white,
                                pressElevation: 0.0,
                                label: e,
                                selected: controller.chipIndex.value == index,
                                onSelected: (bool selected) {
                                  controller.chipIndex.value =
                                      selected ? index : 0;
                                },
                              );
                            }),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0.wp),
                      ),
                      minimumSize: const Size(150.0, 40.0),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        int icon =
                            icons[controller.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[controller.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: controller.textController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        controller.textController.clear();
                        controller.addTask(task)
                            ? EasyLoading.showSuccess('Created Successfully')
                            : EasyLoading.showError('Duplicated Task');
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
          controller.textController.clear();
          controller.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.grey,
              size: 10.0.wp,
            ),
          ),
        ),
      ),
    );
  }
}
