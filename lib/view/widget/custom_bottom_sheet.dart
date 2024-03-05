import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/controller/note_screen_controller.dart';
import 'package:noteapp/utils/constants/color_constants.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    this.onSavePressed,
    this.isEdit = false,
  });

  final void Function()? onSavePressed;
  final bool isEdit;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  List colorsList = [
    ColorConstants.redNote,
    ColorConstants.blueNote,
    ColorConstants.greenNote,
    ColorConstants.yellowNote,
  ];

  int selectedColorIndex = 0;

  // global key

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, bottomSetState) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: ColorConstants.mainDarkGrey,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: NoteScreenController.titleController,
                  decoration: const InputDecoration(
                      label: Text("Title"),
                      border: OutlineInputBorder(),
                      fillColor: ColorConstants.mainLightGrey,
                      filled: true),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "Enter a valid title";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  controller: NoteScreenController.desController,
                  decoration: const InputDecoration(
                      label: Text("Description"),
                      border: OutlineInputBorder(),
                      fillColor: ColorConstants.mainLightGrey,
                      filled: true),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "Enter a valid description";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: NoteScreenController.dateController,
                  decoration: InputDecoration(
                      label: const Text("Date"),
                      border: const OutlineInputBorder(),
                      fillColor: ColorConstants.mainLightGrey,
                      filled: true,
                      suffixIcon: InkWell(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));

                            if (pickedDate != null) {
// to format date
                              String formatedDate =
                                  DateFormat("dd/MM/yyyy").format(pickedDate);
// to assign the formated date to controller
                              NoteScreenController.dateController.text =
                                  formatedDate;
                            }
                          },
                          child: const Icon(Icons.calendar_month))),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "select a valid date";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        var obj = NoteScreenController();

                        selectedColorIndex = index;

                        obj.onColorSelection(colorsList[selectedColorIndex]);
                        bottomSetState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: selectedColorIndex == index
                              ? Border.all(
                                  width: 2, color: ColorConstants.mainRed)
                              : null,
                          color: colorsList[index],
                        ),
                        width: 60,
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          NoteScreenController.clearControllers();

                          Navigator.pop(context);

                          // bottomSetState(() {});
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.mainLightGrey,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: const Center(child: Text("Cancel"))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            widget.onSavePressed!();
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.mainLightGrey,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Center(
                                child:
                                    Text(widget.isEdit ? "Update" : "Save"))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
