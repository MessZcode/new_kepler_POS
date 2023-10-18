import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DataViewModel extends ChangeNotifier {
  DataModel _data = DataModel("Initial Data");

  DataModel get data => _data;

  void updateData(String newData) {
    _data = DataModel(newData);
  }
}

class BackgroundService {
  final DataViewModel _dataViewModel;

  BackgroundService(this._dataViewModel);

  Timer? _timer;

  void startService() {
    int i = 0;
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      // Fetch data and send it to the API using _dataViewModel.
      final newData = await fetchData(i);
      _dataViewModel.updateData(newData);
      sendToApi(newData, i);
      finishService(newData);
      i++;
    });
  }

  void stopService() {
    _timer?.cancel();
  }

  Future<String> fetchData(int i) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay.
    return "New Data from Service $i";
  }

  Future<void> sendToApi(String data, int i) async {
    final apiUrl = Uri.parse('https://650290b9a0f2c1f3faea9330.mockapi.io/Kepler_pos/orders');

    // สร้างข้อมูลในรูปแบบ JSON
    final orderData = {
      'orderId': '',
      'orderDate': 'Widget',
      'totalAmount': 300.0,
      'netAmount': 300.0,
      'billStatus': "payment",
      'customerId': 0,
      'userId': 1,
    };

    // แปลงข้อมูล JSON เป็น String
    final jsonString = jsonEncode(orderData);

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonString,
      );

      if (response.statusCode == 201) {
        print('ส่งข้อมูลสำเร็จ');
        print('Response: ${response.body}');
      } else {
        print('ส่งข้อมูลไม่สำเร็จ');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        await deleteAllData();
      }
    } catch (error) {
      print('เกิดข้อผิดพลาดในการส่งข้อมูล: $error');
    }
  }

  Future<void> deleteAllData() async {
    final apiUrl = Uri.parse('https://650290b9a0f2c1f3faea9330.mockapi.io/Kepler_pos/orders');

    try {
      final response = await http.delete(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('กำลังลบข้อมูลทั้งหมด');
      if (response.statusCode == 200) {
        print('ลบข้อมูลทั้งหมดสำเร็จ');
      } else {
        print('เกิดข้อผิดพลาดในการลบข้อมูล: ${response.statusCode}');
      }
    } catch (error) {
      print('เกิดข้อผิดพลาดในการส่งคำขอลบข้อมูล: $error');
    }
  }

  void finishService(String newData) {
    print("Background Service Finished : $newData");
  }
}

class ServicesResponseCallBack {
  bool isWorking;
  DateTime getFromApiLasted;
  DateTime sendToApiLasted;
  DateTime updateToDatabaseLasted;
  String connectionStatus;
  String errorMessage;
  DateTime completionTime;

  ServicesResponseCallBack({
    required this.isWorking,
    required this.getFromApiLasted,
    required this.sendToApiLasted,
    required this.updateToDatabaseLasted,
    this.connectionStatus = "",
    this.errorMessage = "",
    required this.completionTime,
  });
}

class DataModel {
  final String data;
  DataModel(this.data);
}
