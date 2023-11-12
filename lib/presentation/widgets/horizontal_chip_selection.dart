import 'package:flutter/material.dart';

class ChipList extends StatefulWidget {
  final String label;
  final Set<String> selectedChipList;
  final List<String> chipText;
  final double? width;
  final double? height;

  const ChipList({
    super.key,
    required this.label,
    required this.selectedChipList,
    required this.chipText,
    this.height,
    this.width,
  });

  @override
  State<ChipList> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<ChipList> {
  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(15);

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                      topLeft: borderRadius,
                      topRight: borderRadius,
                      bottomLeft: borderRadius,
                      bottomRight: borderRadius),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
              padding: const EdgeInsets.all(5),
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
                        setState(() {
                          if (selected) {
                            widget.selectedChipList.add(item);
                          } else {
                            widget.selectedChipList.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                )
              ]),
            ),
          ],
        ));
  }
}
