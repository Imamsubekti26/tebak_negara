import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tebak_negara/game.dart';
import 'package:tebak_negara/info.dart';

class ShowWelcome extends StatelessWidget {
  const ShowWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat Datang di',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
              ),
              const Text(
                'Tebak Bendera Negara',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/all-national-flags-world-background-style_18981-512.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                height: 40,
                width: 250,
                child: ElevatedButton(
                    onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Game();
                          }))
                        },
                    child: const Text(
                      'Mulai Game',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 40,
                width: 250,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const InfoNegara();
                          }))
                        },
                    child: const Text(
                      'Info Negara',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w400),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpinnerLoading extends StatelessWidget {
  const SpinnerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.blue,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text('Sedang Memuat Data'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text('Semoga servernya tidak bermasalah'),
        ),
      ],
    ));
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<WelcomeScreen> {
  var cacheManager = DefaultCacheManager();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    if (response.statusCode == 200) {
      await cacheManager.putFile('data', response.bodyBytes);
      setState(() {
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const SpinnerLoading() : const ShowWelcome(),
    );
  }
}
