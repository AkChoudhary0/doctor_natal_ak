// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:health_consultant_for_doctor/src/config/app_colors.dart';
import 'package:resize/resize.dart';
import '../config/app_text_styles.dart';

class MultiSelectDropdownFormField extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String labelText;
  final bool isMultiSelect;
  List<int> selectedItems;
  final List<int>? initialValue; // For setting initial values
  final ValueChanged<List<int>>? onChanged; // For changes callback

  MultiSelectDropdownFormField({
    super.key,
    required this.items,
    required this.labelText,
    required this.isMultiSelect,
    this.initialValue,
    this.onChanged,
    required this.selectedItems,
  });

  @override
  State<MultiSelectDropdownFormField> createState() =>
      _MultiSelectDropdownFormFieldState();
}

class _MultiSelectDropdownFormFieldState
    extends State<MultiSelectDropdownFormField> {
  late List<int> selectedItems;

  @override
  void initState() {
    super.initState();
    widget.selectedItems = widget.initialValue ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputDecorator(
              decoration: InputDecoration(
                isDense: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: AppColors.validationRed),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              isEmpty: widget.selectedItems.isEmpty,
              child: InkWell(
                onTap: widget.isMultiSelect
                    ? () => showMultiSelectDialog(context)
                    : () => showSingleSelectDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.isMultiSelect
                            ? widget.selectedItems.isNotEmpty
                                ? widget.selectedItems
                                    .map((id) => widget.items.firstWhere(
                                        (item) => item['id'] == id)['name'])
                                    .join(', ')
                                : widget.labelText
                            : widget.selectedItems.isNotEmpty
                                ? widget.items.firstWhere((item) =>
                                    item['id'] ==
                                    widget.selectedItems.first)['name']
                                : widget.labelText,
                        style: AppTextStyles.bodyTextStyle28,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Image.asset(
                      "assets/icons/arrow-down.png",
                      color: AppColors.primaryColor,
                      height: 8.h,
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  state.errorText!,
                  style: AppTextStyles.errorValidationTextStyle1,
                ),
              ),
          ],
        );
      },
      validator: (value) {
        if (widget.selectedItems.isEmpty) {
          return 'Please select at least one item';
        }
        return null;
      },
    );
  }

  // Method to open the multi-select dialog
  void showMultiSelectDialog(BuildContext context) async {
    final selected = await showDialog<List<int>>(
      context: context,
      builder: (BuildContext context) {
        List<int> tempSelected = List<int>.from(widget.selectedItems);
        return AlertDialog(
          title: Text(
            widget.labelText,
            style: AppTextStyles.subHeadingTextStyle1,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    return CheckboxListTile(
                      value: tempSelected.contains(item['id']),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item['name'],
                        style: AppTextStyles.bodyTextStyle2,
                      ),
                      activeColor: AppColors.primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelected.add(item['id']);
                            log("${item['id']} ITEM ID");
                            log("$tempSelected ITEMIDS");
                          } else {
                            tempSelected.remove(item['id']);
                            log("${item['id']} ITEM ID");
                            log("$tempSelected ITEMIDS");
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.bodyTextStyle6,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.selectedItems = tempSelected;
                  widget.onChanged
                      ?.call(widget.selectedItems); // Notify the parent
                });
                Navigator.of(context).pop(tempSelected);
              },
              child: Text(
                'OK',
                style: AppTextStyles.bodyTextStyle6,
              ),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        widget.selectedItems = selected;
      });
    }
  }

  // Method to open the single-select dialog
  void showSingleSelectDialog(BuildContext context) async {
    final selected = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int? tempSelected =
            widget.selectedItems.isNotEmpty ? widget.selectedItems.first : null;
        return AlertDialog(
          title: Text(
            widget.labelText,
            style: AppTextStyles.subHeadingTextStyle1,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    return RadioListTile<int>(
                      value: item['id'],
                      groupValue: tempSelected,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item['name'],
                        style: AppTextStyles.bodyTextStyle2,
                      ),
                      activeColor: AppColors.primaryColor,
                      onChanged: (int? value) {
                        setState(() {
                          tempSelected = value;
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.bodyTextStyle6,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.selectedItems = [tempSelected!];
                  widget.onChanged?.call([tempSelected!]);
                });
                Navigator.of(context).pop(tempSelected);
              },
              child: Text(
                'OK',
                style: AppTextStyles.bodyTextStyle6,
              ),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        widget.selectedItems = [selected];
        widget.onChanged?.call([selected]);
      });
    }
  }
}
