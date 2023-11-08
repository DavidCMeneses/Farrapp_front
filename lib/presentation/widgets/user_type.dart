import 'package:flutter/material.dart';

class UserRadio extends StatefulWidget {
  const UserRadio({Key? key}) : super(key: key);

  @override
  State<UserRadio> createState() => _UserRadioState();
}

enum UserType { client, establishment }

class _UserRadioState extends State<UserRadio> {
  UserType? _type = UserType.client;

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              title: const Text('Persona'),
              value: UserType.client,
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value;
                });
              },
            ),
        ),
        Expanded(
          child: RadioListTile(
              title: const Text('Empresa'),
              value: UserType.establishment,
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value;
                });
              },
            ),
        )
        
      ],
    );
  }
}