import 'package:flutter/material.dart';

class BirthdayForm extends StatelessWidget {

  final String birthDateInString;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final String? Function(String?)? validator;


  const BirthdayForm({
    super.key, 
    required this.birthDateInString, 
    this.hint, 
    this.errorMessage, 
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged, 
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(40)
        );
    const borderRadius = Radius.circular(15);

    return GestureDetector(
        child: Wrap(
          spacing: 10,
          children: [
            const Text(
              "Fecha de nacimiento",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0,5)
                  )
                ]
              ),
              child: TextFormField(
                enabled: false,
                onChanged: onChanged,
                validator: validator,
                obscureText: obscureText,
                keyboardType: TextInputType.datetime,
                style: const TextStyle( fontSize: 20, color: Colors.black87 ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all( 10),
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
                  focusedErrorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
                  isDense: true,
                  label: Text(birthDateInString),
                  errorText: errorMessage,
                  focusColor: colors.primary,
                  // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
                ),
              ),
            ),
            

          ],
        ),
        onTap: () async {
          final datePick = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (datePick != null ) {
            String newBirthDateInString ="${datePick.year}-${datePick.month.toString().padLeft(2, '0')}-${datePick.day.toString().padLeft(2, '0')}"; // 08/14/2019
            if(birthDateInString!=newBirthDateInString) {

              onChanged(newBirthDateInString);
            }
            
          }
        });
  }
}

