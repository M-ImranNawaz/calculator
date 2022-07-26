import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List list = [
    {
      'name': 'abc',
      'value': [1, 2, 3]
    },
    {
      'name': 'abc',
      'value': [1, 2, 3]
    },
    {
      'name': 'abc',
      'value': [1, 2, 3, 6]
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  List data1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("List View"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: ((context, index) => Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          list[index]['name'],
                          style:
                              const TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        list[index]['value'].length < 4
                            ? Text(list[index]['value'].toString().substring(
                                1, list[index]['value'].toString().length - 1))
                            : Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: list[index]['value']
                                        .toString()
                                        .substring(1, 8)),
                                TextSpan(
                                    text:
                                        " \n${list[index]['value'].toString().substring(10, list[index]['value'].toString().length - 1)}"),
                              ])),
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}
