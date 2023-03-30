import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/categories.dart';
import 'package:todo_app/components/todo_property_row.dart';
import 'package:todo_app/providers/todo_provider.dart';

class AddTaskModalBottomSheet extends StatefulWidget {
  const AddTaskModalBottomSheet({super.key});

  @override
  State<AddTaskModalBottomSheet> createState() =>
      _AddTaskModalBottomSheetState();
}

class _AddTaskModalBottomSheetState extends State<AddTaskModalBottomSheet> {
  String date = "";
  String time = "";
  String category = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    ThemeData themeData = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
      child: Column(children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Tiêu đề",
          ),
          style: const TextStyle(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,40,0,40),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Chú thích"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Row( children: [          
          Row( children: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              onPressed: () async {
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => const CategoryBox(),
                ))
                    .then((value) {
                  setState(() {
                    category = value;
                  });
                });
              },
              icon: const Icon(LineIcons.tag),
            ),
            TodoPropertyRow(
                property: category,
                onDelete: () {
                  setState(() {
                    category = "";
                  });
                }),
            IconButton(
              onPressed: () async {
                await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2093),
                        builder: (context, child) =>
                            Theme(data: themeData, child: child!))
                    .then((selectedDate) {
                  if (selectedDate != null) {
                    var formattedDate = DateFormat.yMMMd().format(selectedDate);
                    setState(() {
                      date = formattedDate.toString();
                    });
                  }
                });
              },
              icon: const Icon(LineIcons.calendar),
            ),
            TodoPropertyRow(
                property: date,
                onDelete: () {
                  setState(() {
                    date = "";
                  });
                }),
            IconButton(
               
              onPressed: () async {
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) =>
                      Theme(data: themeData, child: child!),
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    setState(() {
                      time = selectedTime.format(context);
                    });
                  }
                });
              },
              icon: const Icon(LineIcons.clock),
            ),
            TodoPropertyRow(
                property: time,
                onDelete: () {
                  setState(() {
                    time = "";
                  });
                }),
          ]),
          
      ]),
      IconButton(
      
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                provider.addTodo(titleController.text.trim(),
                    descriptionController.text.trim(), date, time, category);
              }
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.add_card_rounded), padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          )
    ],
    ));
  }
}
