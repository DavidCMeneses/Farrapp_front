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
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Persona',
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 10, 87),
                  fontSize: 14,
                  fontFamily: 'Reem Kufi',
                  fontWeight: FontWeight.w500,
                )),
            leading: Radio<UserType>(
              value: UserType.client,
              groupValue: _type,
              onChanged: (UserType? value) {
                setState(() {
                  _type = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Empresa',
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 10, 87),
                  fontSize: 14,
                  fontFamily: 'Reem Kufi',
                  fontWeight: FontWeight.w500,
                )),
            leading: Radio<UserType>(
              value: UserType.establishment,
              groupValue: _type,
              onChanged: (UserType? value) {
                setState(() {
                  _type = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
