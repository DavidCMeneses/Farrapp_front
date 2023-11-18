import 'package:flutter/material.dart';

class DropdownInfo extends StatelessWidget {

  final String label;
  final double? width;
  final double? height;
  final String? errorMessage;
  final List<String> dropList;
  final void Function(String?) onChange;

  const DropdownInfo(
      {super.key,
      this.width,
      this.height,
      this.errorMessage,
      required this.label,
      required this.dropList,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> dropdownList =
        <DropdownMenuEntry<String>>[];
    for (var item in dropList) {
      dropdownList.add(DropdownMenuEntry<String>(value: item, label: item));
    }
    return DropdownMenu(
      menuHeight: height,
      width: width,
      dropdownMenuEntries: dropdownList,
      label: Text(label),
      onSelected: onChange,
      errorText: errorMessage,
    );
  }
}
