import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteScreenController {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController desController = TextEditingController();
  static TextEditingController dateController = TextEditingController();

  static Color selectColor = Colors.white;
  List notesList = [];

  List noteKeys = [];
  // // HIVE step 4
  var myBox = Hive.box("noteBox");

  //function to add data

  void addData() {
    myBox.add(
      {
        "title": titleController.text,
        "des": desController.text,
        "date": dateController.text,
        // "color": selectColor
      },
    );
    noteKeys = myBox.keys.toList();
    print(noteKeys);
    print(myBox.values.toList());

    // notesList.add(
    //   {
    //     "title": titleController.text,
    //     "des": desController.text,
    //     "date": dateController.text,
    //     "color": selectColor
    //   },
    // );
  }

  // function to delete data

  void deleteData(var key) {
    myBox.delete(key);
    noteKeys = myBox.keys.toList();
  }

  // function to edit data

  void editData(int index) {
    notesList[index] = {
      "title": titleController.text,
      "des": desController.text,
      "date": dateController.text,
      "color": selectColor
    };
  }

  //clear controllers

  static void clearControllers() {
    titleController.clear();
    desController.clear();
    dateController.clear();
  }

  // on color seleciton

  void onColorSelection(Color newColor) {
    selectColor = newColor;
  }

  init() {
    noteKeys = myBox.keys.toList();
  }
}
