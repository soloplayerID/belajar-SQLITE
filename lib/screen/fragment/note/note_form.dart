// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? turnOn;
  final int? number;
  final String? title;
  final String? description;
  final String? image;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.turnOn = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    this.image = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: turnOn ?? false,
                    onChanged: onChangedImportant,
                  ),
                  turnOn!
                      ? Expanded(
                          child: Slider(
                              value: (number ?? 0).toDouble(),
                              min: 0,
                              max: 2,
                              divisions: 2,
                              onChanged: (number) {
                                onChangedNumber(number.toInt());
                                print(number.toInt());
                                switch (number.toInt()) {
                                  case 0:
                                    Fluttertoast.showToast(
                                        msg:
                                            'alarm akan berdering dalam 1 jam 🔔',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 15);
                                    break;
                                  case 1:
                                    Fluttertoast.showToast(
                                        msg:
                                            'alarm akan berdering dalam 3 jam 🔔',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 15);
                                    break;
                                  case 2:
                                    Fluttertoast.showToast(
                                        msg:
                                            'alarm akan berdering dalam 24 jam 🔔',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 15);
                                    break;
                                  default:
                                }
                              }),
                        )
                      : const Expanded(
                          child: Text('nyalakan alarm'),
                        )
                ],
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
              buildImage()
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.black87),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.black87, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.black87),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildImage() => Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(10),
      child: image != ''
          ? Container(
              child: Image.file(
                File(image!),
                fit: BoxFit.cover,
              ),
            )
          : const Center(
              child: Text(
                'No image',
                style: TextStyle(color: Colors.grey, fontSize: 24),
              ),
            ));
}
