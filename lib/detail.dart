import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DetailNegara extends StatefulWidget {
  final String negara;
  const DetailNegara(this.negara, {super.key});

  @override
  _DetailNegaraState createState() => _DetailNegaraState();
}

class _DetailNegaraState extends State<DetailNegara> {
  var cacheManager = DefaultCacheManager();
  List _data = [
    {
      "name": {"common": "", "official": ""},
      "independent": true,
      "currencies": {
        "EUR": {"name": "", "symbol": ""}
      },
      "capital": [""],
      "region": "",
      "subregion": "",
      "languages": {"bar": ""},
      "area": "",
      "maps": {"googleMaps": "", "openStreetMaps": ""},
      "population": "",
      "car": {"signs": [], "side": ""},
      "timezones": [],
      "continents": [],
      "flags": {"png": "https://flagcdn.com/w320/id.png", "svg": ""},
      "coatOfArms": {"png": "", "svg": ""}
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    var file = await cacheManager.getSingleFile('data');
    var iii = jsonDecode(file.readAsStringSync()) as List;
    iii.sort((a, b) => a['name']['common']
        .toString()
        .compareTo(b['name']['common'].toString()));
    setState(() {
      _data = iii.where((e) => e['cca2'] == widget.negara).toList();
    });

    _data.forEach((element) {
      var mataUang = element['currencies'];
      if (mataUang != null) {
        mataUang.forEach((key, value) {
          setState(() {
            _data[0]['currencies'] = {
              'name': value['name'],
              'symbol': value['symbol']
            };
          });
        });
      } else {
        setState(() {
          _data[0]['currencies'] = {
            'name': "tidak ada data",
            'symbol': "tidak ada data"
          };
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Informasi Negara',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Center(
              child: Column(children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 30, top: 30),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ]),
                  child: Image.network(_data[0]['flags']['png'].toString()),
                ),
                Text(
                  _data[0]['name']['common'].toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.all(10),
                  child: Table(
                    children: [
                      (TableRow(children: [
                        const Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                Text('Nama Resmi :', textAlign: TextAlign.end)),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(_data[0]['name']['official'] != null
                                ? _data[0]['name']['official'].toString()
                                : "tidak ada data")),
                      ])),
                      TableRow(children: [
                        const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Status Kemerdekaan :',
                                textAlign: TextAlign.end)),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_data[0]['independent'] != null
                              ? 'merdeka'
                              : 'belum merdeka'),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Mata Uang Utama :',
                                textAlign: TextAlign.end)),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              _data[0]['currencies']['name'].toString() +
                                  " (" +
                                  _data[0]['currencies']['symbol'].toString() +
                                  ") "),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Ibukota Negara :',
                              textAlign: TextAlign.end),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_data[0]['capital'] != null
                              ? _data[0]['capital'][0].toString()
                              : 'tidak ada data'),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Benua :', textAlign: TextAlign.end),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text((_data[0]['region'] != null
                                  ? _data[0]['region'].toString()
                                  : 'tidak ada data') +
                              " (" +
                              (_data[0]['subregion'] != null
                                  ? _data[0]['subregion'].toString()
                                  : 'tidak ada subregion') +
                              ")"),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Populasi :', textAlign: TextAlign.end),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text((_data[0]['population'] != null
                                  ? _data[0]['population'].toString()
                                  : '0') +
                              " jiwa"),
                        ),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        )));
  }
}
