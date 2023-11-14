import 'package:flutter/material.dart';

class ChipList extends StatefulWidget {
  final String label;
  final List<String> selectedChipList;
  final List<String> chipText;
  final double? width;
  final double? height;
  final Function(List<String>) onSelectChanged;

  const ChipList({
    super.key,
    required this.label,
    required this.selectedChipList,
    required this.chipText,
    this.height,
    this.width, 
    required this.onSelectChanged,
  });

  @override
  State<ChipList> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<ChipList> {
  @override
  Widget build(BuildContext context) {

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: widget.height,
              width: widget.width,
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Wrap(
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
                  )
                ]),
              ),
            ),
          ],
        );
  }
}
