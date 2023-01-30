import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tebak_negara/detail.dart';

class GetDataCountry extends StatefulWidget {
  const GetDataCountry({super.key});

  @override
  _GetDataCountryState createState() => _GetDataCountryState();
}

class _GetDataCountryState extends State<GetDataCountry> {
  var cacheManager = DefaultCacheManager();
  List _data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Future<void> _loadData() async {
  //   var response =
  //       await http.get(Uri.parse('https://restcountries.com/v3.1/all/'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _data = jsonDecode(response.body);
  //     });
  //   } else {
  //     // handle error
  //     print('responnya adalah ' + response.statusCode.toString());
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<void> _loadData() async {
    var file = await cacheManager.getSingleFile('data');
    var iii = jsonDecode(file.readAsStringSync()) as List;
    iii.sort((a, b) => a['name']['common']
        .toString()
        .compareTo(b['name']['common'].toString()));
    setState(() {
      _data = iii;
    });
  }

  @override
  Widget build(BuildContext context) {
    int ukuranLayar = 2;
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width.floor() < 600) {
      ukuranLayar = 2;
    } else if (screenSize.width.floor() < 900) {
      ukuranLayar = 3;
    } else if (screenSize.width.floor() < 1200) {
      ukuranLayar = 4;
    } else {
      ukuranLayar = 6;
    }

    return (Container(
        margin: const EdgeInsets.all(10),
        child: GridView.count(
            crossAxisCount: ukuranLayar,
            children: _data.map((e) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailNegara(e['cca2']);
                    }));
                  },
                  child: Card(
                      child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Image.network(e['flags']['png']),
                        ),
                        Text(e['name']['common'])
                      ],
                    ),
                  )));
            }).toList())));
  }
}
