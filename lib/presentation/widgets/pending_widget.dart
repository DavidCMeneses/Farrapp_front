import 'package:flutter/material.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({Key? key}) : super(key: key);

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}
enum Pending { pendingTrue }

class _PendingWidgetState extends State<PendingWidget> {
  Pending? _pending = Pending.pendingTrue;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("pending"),
      ],
    );
  }
  }