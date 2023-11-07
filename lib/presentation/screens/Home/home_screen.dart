import 'package:flutter/material.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final passController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  bottom: 3.0, left: 15.0, right: 10.0, top: 100.0),
              //height: 50.0,
              //color: Colors.amber[600],
              child: const Text(
                'Ingresar',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 23.33,
                  fontFamily: 'Reem Kufi',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  bottom: 10.0, left: 15.0, right: 10.0, top: 3.0),
              //height: 30.0,
              //color: Colors.amber[600],
              child: const Text(
                'Hola   ¿Listo para pasarla genial?',
                style: TextStyle(
                  color: Color(0xFF9E95A2),
                  fontSize: 14,
                  fontFamily: 'Reem Kufi',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Center(
              child: UserRadio(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, left: 15.0, right: 15.0, top: 50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: const Text(
                        'Usuario',
                        style: TextStyle(
                          color: Color.fromARGB(255, 63, 10, 87),
                          fontSize: 14,
                          fontFamily: 'Reem Kufi',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: userController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          hintText: 'Nombre de usuario'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0, top: 30.0),
                      child: const Text(
                        'Contraseña',
                        style: TextStyle(
                          color: Color.fromARGB(255, 63, 10, 87),
                          fontSize: 14,
                          fontFamily: 'Reem Kufi',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          hintText: 'Contraseña'),
                    ),
                    Padding(
                        //height: 40,
                        //width: 300,
                        padding: const EdgeInsets.only(top: 50.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFC62EA7)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          '${userController.text} ${passController.text}'),
                                    );
                                  });
                            },
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ))),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
