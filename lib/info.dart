import 'package:flutter/material.dart';
import 'package:tebak_negara/get_data_country.dart';

class InfoNegara extends StatelessWidget {
  const InfoNegara({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Informasi Negara',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
          actions: [
            IconButton(
              icon: const Icon(Icons.anchor_sharp),
              tooltip: 'cari',
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
          ],
        ),
        body: const SafeArea(child: GetDataCountry()));
  }
}
