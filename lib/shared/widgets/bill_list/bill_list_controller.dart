import 'package:flutter/material.dart';
import 'package:payflow_project/shared/models/bill_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillListController {
  final boletosNotifier = ValueNotifier<List<BillModel>>(<BillModel>[]);
  List<BillModel> get boletos => boletosNotifier.value;
  set boletos(List<BillModel> value) => boletosNotifier.value = value;

  BillListController() {
    getBoletos();
  }
  void getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("boletos");
      boletos = response!.map((e) => BillModel.fromJson(e)).toList();
    } catch (e) {}
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}