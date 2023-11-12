import 'package:flutter/material.dart';

class DropdownInfo extends StatefulWidget {
  final String label;
  final double? width;
  final double? height;
  final List<String> dropList;
  final void Function(String?)? onChange;

  const DropdownInfo(
      {super.key,
      this.width,
      this.height,
      required this.label,
      required this.dropList,
      this.onChange});

  @override
  State<DropdownInfo> createState() => _DropdownInfoState();
}

class _DropdownInfoState extends State<DropdownInfo> {
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> dropdownList =
        <DropdownMenuEntry<String>>[];
    for (var item in widget.dropList) {
      dropdownList.add(DropdownMenuEntry<String>(value: item, label: item));
    }
    return DropdownMenu(
      menuHeight: widget.height,
      width: widget.width,
      dropdownMenuEntries: dropdownList,
      label: Text(widget.label),
      onSelected: widget.onChange,
    );
  }
}
