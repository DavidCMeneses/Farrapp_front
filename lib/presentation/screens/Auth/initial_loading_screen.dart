import 'package:flutter/material.dart';

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: color.background ,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox( height: 80 ),
            Text('FARRAP', style: TextStyle(color: color.primary, fontSize: 40) ),
            Text('SFP 2023', style: TextStyle(color: color.secondary, fontSize: 20)),
        
          ],
        ),
      ),
    );
  }
}