import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<String> data = [
    "C",
    "CE",
    "Del",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "%",
    "0",
    ".",
    "="
  ];
  List<String> dataL = [
    "CE",
    "7",
    "8",
    "9",
    "*",
    "Del",
    "4",
    "5",
    "6",
    "-",
    "C",
    "1",
    "2",
    "3",
    "+",
    "%",
    "0",
    ".",
    "=",
    "/"
  ];
  String initValue = '';
  RxString ans = "".obs;
  RxString inp = "".obs;
  RxInt inputSize = 40.obs;
  RxInt outputSize = 30.obs;

  void input(String value) {
    inputSize.value = 40;
    outputSize.value = 25;
    initValue = inp.value;
    if (!isOperator(value)) {
      calculate(initValue);
    }
    inputValidations(value);
    if (value == "=") {
      inputSize.value = 30;
      outputSize.value = 40;
      calculate(inp.value);
    } else if (value == "Del") {
      //Delete
      deleteAtLast();
    } else if (value == "C") {
      //Clear All
      inp.value = "";
      ans.value = "";
    } else if (value == "CE") {
      //Clear Current
      inp.value = "";
    } else if (value == "%") {
      if (ans.isNotEmpty) {
        var val = double.parse(ans.value) / 100;
        ans.value = val.toString();
        return;
      }
      calculate(inp.value);
      var val = double.parse(ans.value) / 100;
      ans.value = val.toString();
    }
    //handle operators Input
    else if (initValue.isNotEmpty &&
        isOperator(value) &&
        isOperator(
            inp.value.substring(inp.value.length - 1, inp.value.length))) {
      initValue = inp.value.substring(0, inp.value.length - 1);
      inp.value = initValue + value;
      return;
    } else if (value == ".") {
      //
      handleDotInput(value);
    } else {
      inp.value = initValue + value;
    }
  }

  bool isOperator(String value) {
    if (value.contains(RegExp(r'[0-9]')) || value.contains('.')) {
      return false;
    }
    return true;
  }

  inputValidations(String value) {
    // inp.value;

    // if (inp.value.length > 2) {
    //   var f = NumberFormat("###,###", "en_US");
    //   print(f.format(int.parse(inp.value)));
    //   inp.value = f.format(int.parse(inp.value));
    // }
    // final numberDigits = List.from(initValue.split(''));
    // print(numberDigits);
    // for (int i = 0; i < numberDigits.length; i++) {

    //   inp.value = inp.value+ numberDigits[i];

    // }
  }

  calculate(String exp) {
    try {
      String a = exp.interpret().toString();
      print(a);
      String b = a.substring(a.length - 2, a.length);
      if (b == ".0") {
        ans.value = a.substring(0, a.length - 2);
      } else {
        ans.value = exp.interpret().toStringAsFixed(5);
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteAtLast() {
    if (inp.value.isNotEmpty) {
      if (inp.value.length == 1) {
        inp.value = "";
        ans.value = "";
        return;
      }
      inp.value = inp.value.substring(0, inp.value.length - 1);
      String a = inp.substring(inp.value.length - 1, inp.value.length);
      if (!isOperator(a)) {
        calculate(inp.value);
      }
    } else {
      return;
    }
  }

  void handleDotInput(String value) {
    if (initValue.isEmpty) {
      inp.value = "0.";
      return;
    } else if (inp.value.contains('.')) {
      if (value.contains(RegExp(r'[0-9]'))) {
        return;
      }
      if (isOperator(
          inp.value.substring(inp.value.length - 1, inp.value.length))) {
        inp.value = "${initValue}0.";
        return;
      }
      final regExp = RegExp(r'[,.?!“”()]|[^,?!“-”-*+/()\s]+');
      List<String> matches =
          regExp.allMatches(initValue).map((m) => m[0]!).toList();
      if (matches.length > 1 && !matches[matches.length - 1].contains('.')) {
        inp.value = initValue + value;
      }
    } else {
      inp.value = initValue + value;
    }
  }
}
