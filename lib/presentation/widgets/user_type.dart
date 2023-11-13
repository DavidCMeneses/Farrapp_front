import 'package:flutter/material.dart';

class UserRadio extends StatefulWidget {
  final UserType type;
  final Function(UserType) onChanged;

  const UserRadio({super.key, required this.type, required this.onChanged});

  @override
  State<UserRadio> createState() => _UserRadioState();
}

enum UserType { client, establishment }

class _UserRadioState extends State<UserRadio> {

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              title: const Text('Persona'),
              value: UserType.client,
              groupValue: widget.type,
              onChanged: (value) => widget.onChanged(value?? widget.type)
            ),
        ),
        Expanded(
          child: RadioListTile(
              title: const Text('Empresa'),
              value: UserType.establishment,
              groupValue: widget.type,
              onChanged: (value) => widget.onChanged(value?? widget.type)
            ),
        )
        
      ],
    );
  }
}