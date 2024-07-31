import 'package:flutter/material.dart';

class HistoricEmptyWidget extends StatelessWidget {
  const HistoricEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("O histórico está vazio",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    );
  }
}
