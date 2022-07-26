import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'views.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());
  var orientation;
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      buildInputOutputView(),
                      const Divider(
                        height: 5,
                        thickness: 3,
                        color: Colors.blue,
                      ),
                      buildInputColumn(c.data),
                    ])
              : Row(
                  children: [
                    buildInputColumn(c.dataL),
                    buildInputOutputView(),
                    const Divider(
                      height: 5,
                      thickness: 3,
                      color: Colors.blue,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Container buildInputOutputView() {
    return Container(
      //height: double.infinity,
      width: orientation == Orientation.portrait ? double.infinity : 350,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() => SelectableText(
                c.ans.value,
                style: TextStyle(fontSize: c.outputSize.value.toDouble()),
              )),
          const SizedBox(
            height: 5,
          ),
          Obx(() => SelectableText(
                c.inp.value,
                style: TextStyle(fontSize: c.inputSize.value.toDouble()),
              )),
        ],
      ),
    );
  }

  Widget buildInputColumn(List data) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      height: 450,
      width: orientation == Orientation.portrait ? 350 : 420,
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
        ),
        itemBuilder: ((context, index) {
          Color color = c.isOperator(data[index]) &&
                  data[index] != "C" &&
                  data[index] != "="
              ? Colors.redAccent
              : data[index] == "C"
                  ? Colors.white
                  : data[index] == "="
                      ? Colors.black
                      : Colors.black;
          return InputButton(
            onPressed: () {
              c.input(data[index]);
            },
            title: data[index] == "Del"
                ? const Icon(
                    FontAwesomeIcons.deleteLeft,
                    color: Colors.red,
                  )
                : Text(
                    data[index],
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
            t: data[index],
          );
        }),
      ),
    );
  }
}
