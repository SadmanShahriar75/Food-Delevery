import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _updateController = TextEditingController();

  Box? contactBox;
  @override
  void initState() {
    contactBox = Hive.box('contact-list');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
        child: Column(
          children: [
            TextField(
              controller: _contactController,
              decoration: InputDecoration(hintText: 'write contact number'),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: () async {
                    final userInput = _contactController.text;
                    print(userInput);
                    await contactBox!.add(userInput);
                    Get.snackbar('Success', 'Contact Added Suceessfully');
                    _contactController.clear();
                  },
                  child: Text('Add new contact')),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('contact-list').listenable(),
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: contactBox!.keys.toList().length,
                      itemBuilder: (_, index) {
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(contactBox!.getAt(index)),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Dialog(
                                                child: Container(
                                                  height: 200,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              _updateController,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      'Updated contact number'),
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          child: ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                final input =
                                                                    _updateController
                                                                        .text;
                                                                contactBox!
                                                                    .putAt(
                                                                        index,
                                                                        input);
                                                                        _updateController.clear();
                                                                        Get.back();
                                                              },
                                                              child: Text(
                                                                  'Update contact')),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.green)),
                                  IconButton(
                                      onPressed: () async {
                                        await contactBox!.deleteAt(index);
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
      
    );

  }
}
