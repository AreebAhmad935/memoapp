import 'package:flutter/material.dart';
import 'package:memoapp/controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Controller controller = Get.put(Controller());
  @override
  // ignore: overridden_fields
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  var controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MemoApp',
            style: TextStyle(
                backgroundColor: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Text(controller.list[index].toString()),
                  onLongPress: () {
                    Get.dialog(
                      AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: key,
                              child: TextFormField(
                                controller: controllerText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  controller.list.add(controllerText.text);
                                  controllerText.clear();
                                  Get.back();
                                }
                              },
                              child: const Text('Add Text'),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  leading: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.list.removeAt(index);
                      },
                    ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.dialog(
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: key,
                    child: TextFormField(
                      controller: controllerText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        controller.list.add(controllerText.text);
                        controllerText.clear();
                        Get.back();
                      }
                    },
                    child: const Text('Add TEXT'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
