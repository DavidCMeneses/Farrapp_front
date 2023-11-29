import 'package:flutter/material.dart';

class CustomWrapChip extends StatefulWidget {
  final String label;
  final List<String> selectedChipList;
  final List<String> chipText;
  final double? width;
  final double? height;
  final Function(List<String>) onSelectChanged;

  const CustomWrapChip({
    super.key, 
    required this.label, 
    required this.selectedChipList, 
    required this.chipText, 
    this.width, 
    this.height, 
    required this.onSelectChanged});

  @override
  State<CustomWrapChip> createState() => _CustomWrapChipState();
}

class _CustomWrapChipState extends State<CustomWrapChip> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.label,
        style: const TextStyle(
                color: Colors.black,
                //fontWeight: FontWeight.bold
                ),
        ),
      children: [Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: widget.height,
            width: widget.width,
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 15.0,
                children: widget.chipText.map((String item) {
                  return FilterChip(
                    
                    label: Text(
                      item,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.black54),
                    ),
                    selected: widget.selectedChipList.contains(item),
                    onSelected: (bool selected) {
                      List<String> newSelectedChipList = [...widget.selectedChipList];
              
                      setState(() {
                        if (selected) {
                          newSelectedChipList.add(item);
                        } else {
                          newSelectedChipList.remove(item);
                        }
                        widget.onSelectChanged(newSelectedChipList);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    ]);
  }
}