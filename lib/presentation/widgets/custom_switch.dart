import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String label;
  final Function(bool)? onChanged;
  final bool value;

  const CustomSwitch({
    super.key, 
    required this.label, 
    this.onChanged, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.2,
                      //fontWeight: FontWeight.bold
                      ),
              ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Switch(
                  value: value,
                  activeColor: Colors.blue,
                  onChanged: onChanged,
                ),
              ),
            )
          ],
        ),
    );
  }
}
