import 'package:flutter/material.dart';
import 'package:tebak_negara/info.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Ayo Tebak',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    'gamenya malah belum tak buat, hehe',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const InfoNegara();
                          }))
                        },
                    child: const Text(
                      'Info Negara',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ));
  }
}
