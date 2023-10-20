import 'package:kepler_pos/models/main_model.dart';
import 'package:postgres/postgres.dart';

import '../ViewModel/base_viewmodel.dart';
import '../ViewModel/payment_viewModel.dart';

//
//service.dart
class Services {
  Future<PostgreSQLConnection?> connectToDatabase() async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'kepler_main',
      username: 'postgres',
      password: '12345678',
    );
    // final connection = ConnectDatabase.withDefault().connection();
    try {
      await connection.open();
      return connection;
    } catch (e) {
      print('Connection Failed: $e');
      return null;
    }
  }

  // getData by TableName
  Future<PostgreSQLResult?> fetchDataFromTable(String tableName) async {
    final connection = await connectToDatabase();
    if (connection == null) {
      return null;
    }
    try {
      final results = await connection.query('SELECT * FROM $tableName');
      return results;
    } catch (e) {
      print("Error : $e");
      return null;
    } finally {
      await connection.close();
    }
  }

  //Delete data byId
  Future<void> deleteDataFromTable(String tableName, String columnName, int id) async {
    final connection = await connectToDatabase();
    if (connection == null) {
      return;
    }
    try {
      await connection.query('DELETE FROM $tableName WHERE $columnName = @id', substitutionValues: {'id': id});
      print('Data deleted successfully');
    } catch (e) {
      print("Error : $e");
    } finally {
      await connection.close();
    }
  }

  //Check Database ?
  Future<PostgreSQLConnection?> checkDatabase() async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'postgres',
      username: 'postgres',
      password: '1234',
    );
    try {
      await connection.open();
      final dbExistsResult = await connection.query(
        "SELECT datname FROM pg_catalog.pg_database WHERE datname = @db",
        substitutionValues: {'db': 'MainKepler'},
      );
      if (dbExistsResult.isEmpty) {
        await connection.query(
          "CREATE DATABASE MainKepler",
        );
        // await createTable();
      }
      return connection;
    } catch (e) {
      print('Connection Failed: $e');
      return null;
    }
  }

  Future<int> createOrder({required BillOrderModels order}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        final result = await connection.transaction((t) async {
          return await t.query(
            'INSERT INTO ${TableString.orders} (orderdate, totalamount, discountamount, vatamount, netamount, billstatus, customerid, userid) VALUES (@orderDate, @totalAmount, @discountAmount, @vatAmount, @netAmount, @billStatus, @customerId, @userId) RETURNING OrderId',
            substitutionValues: {
              'orderDate': DateTime.now(),
              'totalAmount': order.totalAmount,
              'discountAmount': order.discountAmount,
              'vatAmount': order.vatAmount,
              'netAmount': order.netAmount,
              'billStatus': order.billStatus,
              'customerId': order.customerId,
              'userId': order.userId,
            },
          );
        });
        final orderId = result.first[0] as int;
        return orderId;
      }
    } catch (e) {
      print("Error creating order: $e");
    } finally {
      await connection!.close();
    }
    return -1;
  }

  Future<bool> addbillDetail({required List<BillDetailModel> billDetails, required int billOrder}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        await connection.transaction((t) async {
          for (var billDetail in billDetails) {
            billDetail.orderId = billOrder;
          }
          int id = 1;
          for (var billDetail in billDetails) {
            await t.query(
              'INSERT INTO ${TableString.orderdetails} (orderid, orderdetailid, productid, productname, productqty, priceperunit, itemvat, subtotal,discount) VALUES (@orderId, @orderDetailId, @productId, @productName, @quantity, @priceperunit, @itemvat, @subtotal , @discount)',
              substitutionValues: {
                'orderId': billDetail.orderId,
                'orderDetailId': id,
                'productId': billDetail.productId,
                'productName': billDetail.productName,
                'quantity': billDetail.productQty,
                'priceperunit': billDetail.priceperunit,
                'itemvat': billDetail.itemVat,
                'subtotal': billDetail.subTotal,
                'discount': billDetail.discount,
              },
            );
            id++;
          }
        });
        return true;
        print("Add Bill Success");
      }
    } catch (e) {
      print("Add Bill Failed: $e");
    } finally {
      await connection!.close();
    }
    return false;
  }

  Future<void> updateOrder({required int orderId, required String newStatus}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        await connection.transaction((t) async {
          await t.query(
            'UPDATE ${TableString.orders} SET billstatus = @newStatus WHERE OrderId = @orderId',
            substitutionValues: {
              'newStatus': newStatus,
              'orderId': orderId,
            },
          );
        });
      }
    } catch (e) {
      print("Error updating order: $e");
    } finally {
      await connection!.close();
    }
  }

  Future<void> createTable(String tableName, List<String> columns) async {
    final connection = await connectToDatabase();
    if (connection == null) {
      return;
    }
    final columnsString = columns.join(', ');
    final dataTableString = 'CREATE TABLE IF NOT EXISTS $tableName ($columnsString)';
    try {
      await connection.query(dataTableString);
      print('Table $dataTableString created successfully');
    } catch (e) {
      print("Error : $e");
    } finally {
      await connection.close();
    }
  }

  Future<PostgreSQLResult?> getUsers() async {
    final connection = await connectToDatabase();
    if (connection == null) {
      return null;
    }
    try {
      final result = await connection.query('SELECT * FROM users ORDER BY lastlogin DESC LIMIT 2');
      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {
      await connection.close();
    }
  }

  Future<UserProfile?> checkLogin(String username, String password) async {
    final connection = await connectToDatabase();
    UserProfile? userProfile;

    if (connection == null) {
      return null;
    }

    try {
      final result = await connection.query(
        'SELECT * FROM ${TableString.users} WHERE email = @username AND password = @password',
        substitutionValues: {'username': username, 'password': password},
      );

      if (result.isNotEmpty) {
        final userRow = result.first;

        int userId = userRow[0] as int;
        String fname = userRow[1] as String;
        String lname = userRow[2] as String;
        String email = userRow[4] as String;

        userProfile = UserProfile(userId: userId, fname: fname, lname: lname, email: email);
      }

      return userProfile;
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {
      await connection.close();
    }
  }

  Future<CustomerModels?> checkCustomer(String phoneString) async {
    final connection = await connectToDatabase();
    CustomerModels? profile;
    if (connection == null) {
      return profile;
    }
    try {
      final customerProfile = await connection.query(
          'SELECT * FROM ${TableString.customers} '
          'WHERE phone = @phone',
          substitutionValues: {'phone': phoneString});
      if (customerProfile.isNotEmpty) {
        final row = customerProfile.first;
        profile = CustomerModels(
          customerId: row[0] as int,
          fname: row[1] as String,
          lname: row[2] as String,
          email: row[3] as String,
          phone: row[4] as String,
          membershiptypeId: row[5] as int,
        );
      }
      return profile;
    } catch (e) {
      print("Get customer Error");
      return profile;
    }
  }

  Future<CustomerModels?> checkCustomerByCustomerId(int customerId) async {
    final connection = await connectToDatabase();
    CustomerModels? profile;
    if (connection == null) {
      return profile;
    }
    try {
      final customerProfile = await connection.query(
          'SELECT * FROM ${TableString.customers} '
          'WHERE customerId = @customerId',
          substitutionValues: {'customerId': customerId});
      if (customerProfile.isNotEmpty) {
        final row = customerProfile.first;
        profile = CustomerModels(
          customerId: row[0] as int,
          fname: row[1] as String,
          lname: row[2] as String,
          email: row[3] as String,
          phone: row[4] as String,
          membershiptypeId: row[5] as int,
        );
      }
      return profile;
    } catch (e) {
      print("Get customer Error");
      return profile;
    }
  }

  Future<ModelCreate> createOrderAndAddBillDetail(
      {required BillOrderModels order,
      required List<BillDetailModel> billDetails,
      required String paymentStatus}) async {
    ModelCreate status = ModelCreate();
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        return await connection.transaction((t) async {
          final result = await t.query(
            'INSERT INTO ${TableString.orders} (orderdate, totalamount, discountamount, vatamount, netamount, billstatus, customerid, userid) VALUES (@orderDate, @totalAmount, @discountAmount, @vatAmount, @netAmount, @billStatus, @customerId, @userId) RETURNING OrderId',
            substitutionValues: {
              'orderDate': DateTime.now(),
              'totalAmount': order.totalAmount,
              'discountAmount': order.discountAmount,
              'vatAmount': order.vatAmount,
              'netAmount': order.netAmount,
              'billStatus': paymentStatus,
              'customerId': order.customerId,
              'userId': order.userId,
            },
          );
          final orderId = result.first[0] as int;
          status.orderId = orderId;
          int id = 1;
          for (var billDetail in billDetails) {
            billDetail.orderId = orderId;
            await t.query(
              'INSERT INTO ${TableString.orderdetails} (orderid, orderdetailid, productid, productname, productqty, priceperunit, itemvat, subtotal, discount) VALUES (@orderId, @orderDetailId, @productId, @productName, @quantity, @priceperunit, @itemvat, @subtotal, @discount)',
              substitutionValues: {
                'orderId': billDetail.orderId,
                'orderDetailId': id++,
                'productId': billDetail.productId,
                'productName': billDetail.productName,
                'quantity': billDetail.productQty,
                'priceperunit': billDetail.priceperunit,
                'itemvat': billDetail.itemVat,
                'subtotal': billDetail.subTotal,
                'discount': billDetail.discount,
              },
            );
          }
          status.status = true;
          return status;
        });
      }
    } catch (e) {
      print("Error creating order and adding bill detail: $e");
    } finally {
      await connection!.close();
    }
    return status;
  }

  Future<ModelCreate> updateAndAddAllBill(
      {required BillOrderModels order,
      required List<BillDetailModel> billDetails,
      required String paymentStatus}) async {
    ModelCreate status = ModelCreate();
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        return await connection.transaction((t) async {
          // ตรวจสอบว่ามีบิลที่ต้องการอัปเดตหรือไม่
          status.orderId = order.orderId;
          final existingBill = await t.query(
            'SELECT * FROM ${TableString.orders} WHERE OrderId = @orderId',
            substitutionValues: {
              'orderId': order.orderId,
            },
          );

          if (existingBill.isEmpty) {
            print('ไม่พบบิลที่ต้องการอัปเดต');
            return status;
          }

          // ทำการอัปเดตรายละเอียดของบิล
          await t.query(
            'UPDATE ${TableString.orders} SET orderdate = @orderDate, totalamount = @totalAmount, discountamount = @discountAmount, vatamount = @vatAmount, netamount = @netAmount, billstatus = @billStatus, customerid = @customerId, userid = @userId WHERE OrderId = @orderId',
            substitutionValues: {
              'orderId': order.orderId,
              'orderDate': DateTime.now(),
              'totalAmount': order.totalAmount,
              'discountAmount': order.discountAmount,
              'vatAmount': order.vatAmount,
              'netAmount': order.netAmount,
              'billStatus': paymentStatus,
              'customerId': order.customerId,
              'userId': order.userId,
            },
          );

          // ลบรายละเอียดบิลเก่าทั้งหมด
          await t.query(
            'DELETE FROM ${TableString.orderdetails} WHERE orderid = @orderId',
            substitutionValues: {
              'orderId': order.orderId,
            },
          );

          // เพิ่มรายละเอียดบิลใหม่
          int id = 1;
          for (var billDetail in billDetails) {
            billDetail.orderId = order.orderId;
            await t.query(
              'INSERT INTO ${TableString.orderdetails} (orderid, orderdetailid, productid, productname, productqty, priceperunit, itemvat, subtotal, discount) VALUES (@orderId, @orderDetailId, @productId, @productName, @quantity, @priceperunit, @itemvat, @subtotal, @discount)',
              substitutionValues: {
                'orderId': billDetail.orderId,
                'orderDetailId': id++,
                'productId': billDetail.productId,
                'productName': billDetail.productName,
                'quantity': billDetail.productQty,
                'priceperunit': billDetail.priceperunit,
                'itemvat': billDetail.itemVat,
                'subtotal': billDetail.subTotal,
                'discount': billDetail.discount,
              },
            );
          }

          status.status = true;
          return status;
        });
      }
    } catch (e) {
      print("Error updating and adding bill details: $e");
    } finally {
      await connection!.close();
    }
    return status;
  }

  Future<List<ShowOrderPaymentSuccessModel>> getShowPaymentSuccess({required BillOrderModels order}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        final result = await connection.query(
          'SELECT * FROM orderpayments WHERE orderid = @orderId',
          substitutionValues: {'orderId': order.orderId},
        );
        List<ShowOrderPaymentSuccessModel> paymentList = [];

        for (final row in result) {
          final orderId = row[0] as int;
          final paymentSeq = row[1] as int;
          final paymentId = row[2] as int;
          final paymentValue = double.parse(row[3]);
          final paymentChange = double.parse(row[4]);

          final showOrderPaymentSuccessModel = ShowOrderPaymentSuccessModel(
            orderId: orderId,
            paymentSeq: paymentSeq,
            paymentId: paymentId,
            paymentValue: paymentValue,
            paymentChange: paymentChange,
            paymentString: '',
          );
          paymentList.add(
              ShowOrderPaymentSuccessModel.filterPaymentString(showOrderPaymentValue: showOrderPaymentSuccessModel));
        }
        return paymentList;
      }
    } catch (e) {
      return [];
    } finally {
      await connection!.close();
    }
    return [];
  }

  Future<double> checkPaymentByOrderId({required BillOrderModels order}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        final result = await connection.query(
          'SELECT SUM(paymentvalue) AS totalpayment FROM orderpayments WHERE orderid = @orderId',
          substitutionValues: {'orderId': order.orderId},
        );

        if (result.isNotEmpty) {
          final totalPayment = double.parse(result.first.first);
          return totalPayment;
        } else {
          return 0.0;
        }
      }
    } catch (e) {
      // จัดการข้อผิดพลาดที่เกิดขึ้น
      return 0.0;
    } finally {
      // ปิดการเชื่อมต่อฐานข้อมูลหรือทำอย่างอื่นตามความต้องการ
      await connection!.close();
    }
    return 0.0; // หากไม่มีข้อมูลหรือเกิดข้อผิดพลาดในการเชื่อมต่อฐานข้อมูล
  }

  Future<void> deleteAllHoldBill() async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        await connection.transaction((t) async {
          await t.query(
              "DELETE FROM orderDetail WHERE orderid IN (SELECT orderid FROM orders WHERE billstatus = 'Hold');");
          await t.query("DELETE FROM orders WHERE billstatus = 'Hold';");
        });
      }
    } catch (e) {
      print("Error : $e");
    } finally {
      await connection!.close();
    }
  }

  Future<bool> addSubmitPayment({required PaymentStatusDetail orderPayment}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        await connection.transaction((t) async {
          var objPaymentSeq = await t.query(
              'select COALESCE(max(paymentseq),0)+1 as paymentSeq FROM orderpayments where orderid=' +
                  orderPayment.orderId.toString());
          int? newPaymentSeq = 0;
          newPaymentSeq = int.tryParse(objPaymentSeq[0][0].toString());
          //todo แก้ไข changeAmount
          final paymentValue = orderPayment.paymentValue - orderPayment.changeAmount;
          await t.query(
              'INSERT INTO ${TableString.orderPayment} (orderId , paymentseq , paymentid , paymentvalue , paymentchange) '
              'VALUES (@orderId , @paymentseq , @paymentId , @paymentValue , @paymentChange)',
              substitutionValues: {
                'orderId': orderPayment.orderId,
                'paymentseq': newPaymentSeq,
                'paymentId': orderPayment.paymentId,
                'paymentValue': paymentValue,
                'paymentChange': 0,
              });
        });
        return true;
      }
      return false;
    } catch (e) {
      print("Error : $e");
      return false;
    } finally {
      await connection!.close();
    }
  }

  Future<PostgreSQLResult?> checkOrder({required int orderId}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        // await connection.transaction((t) async{
        var res = await connection.query(
            'SELECT * FROM orders JOIN orderdetail ON orders.orderId = orderdetail.orderId Where orders.orderId = $orderId');
        if (res.isNotEmpty) {
          return res;
        }
        // });
      }
      // return null;
    } catch (e) {
      print("Error : $e");
      return null;
    } finally {
      await connection!.close();
    }
  }

  Future<void> addCurrentCash({required int type, required double cashValue}) async {
    final connection = await connectToDatabase();
    try {
      if (connection != null) {
        await connection.transaction((t) async {
          var pid = await t.query('Select Coalesce(max(pid),0)+1 as pid From ${TableString.drawers}');
          await t.query(
              'INSERT INTO ${TableString.drawers} (pid,systemdate , type , cashvalue , reasonid) VALUES (@pid,@systemDate , @type , @cashValue , @reasonId)',
              substitutionValues: {
                'pid': pid[0][0],
                'systemDate': DateTime.now(),
                'type': type,
                'cashValue': cashValue,
                'reasonId': '',
              });
        });
      }
    } catch (e) {
      print("Error : $e");
    } finally {
      await connection!.close();
    }
  }
}

class TableString {
  static const String category = "category";
  static const String customers = "customers";
  static const String drawers = "drawer";
  static const String drawerDetail = "drawerdetail";
  static const String drawerReason = "drawerreason";
  static const String drawerTender = "drawertender";
  static const String drawerType = "drawertype";
  static const String orderdetails = "orderdetail";
  static const String orderPayment = "orderpayments";
  static const String orders = "orders";
  static const String pages = "pages";
  static const String products = "products";
  static const String users = "users";
}

class UserProfile {
  final int userId;
  final String fname;
  final String lname;
  final String email;

  UserProfile({required this.userId, required this.fname, required this.lname, required this.email});
}

class ModelCreate {
  int orderId;
  bool status;
  ModelCreate({this.orderId = 0, this.status = false});
}

class AddCurrentCashModel {
  final int pid;
  final DateTime systemDate;
  final int type;
  final double cashValue;
  final String reasonId;

  AddCurrentCashModel(
      {required this.pid,
      required this.systemDate,
      required this.type,
      required this.cashValue,
      required this.reasonId});
}
