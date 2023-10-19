import 'package:flutter/material.dart';

import '../../../../ViewModel/base_viewmodel.dart';
import '../../../../service/service.dart';

class SettingUserViewModel with ChangeNotifier {
  final services = Services();

  List<UserModels> userAll = [];

  Future<UserModels> getUserByOne({required int userId}) async {
    UserModels user = UserModels.initial();
    try {
      final results = await services.getUserByOne(userId: userId);
      if(results!.isEmpty){
        throw Exception("something went wong");
      }
      user = UserModels(
          userId: results.first[0],
          fname: results.first[1],
          lname: results.first[2],
          lastlogin: results.first[3],
          email: results.first[4],
          password: results.first[5],
          permissionLv: results.first[6]
      );
      notifyListeners();
      return user;
    } catch (e) {
      throw Exception("something went wong");
    }
  }
  Future<void> saveEditUser({required UserModels newUserModel}) async{
    try{
      await services.saveEditUser(newUserModel: newUserModel);
      await getUserAll();
    }catch(e){
      print(e);
    }
  }
  Future<void> deleteUserById({required int userId})async{
    try{
      await services.deleteUserById(userId: userId);
      await getUserAll();
    }catch(e){
      print(e);
    }
  }
  Future<List<UserModels>> getUserAll() async {
    userAll.clear();
    try{
      final results = await services.fetchDataFromTable('users');

      if(results == null){
        return userAll;
      }
      // await Future.delayed(const Duration(seconds: 3));
      userAll.addAll(
          results.map((row) {
            return UserModels(
                userId: row[0],
                fname: row[1],
                lname: row[2],
                lastlogin: row[3],
                email: row[4],
                password: row[5],
                permissionLv: row[6]
            );
          }),
      );
      userAll.sort((a, b) => a.userId.compareTo(b.userId),);
      notifyListeners();
      return userAll;
    }catch(e){
      throw Exception(e);
    }
  }
  Future<void> createNewUser({required UserModels newUser}) async{
    try{
      await services.createNewUser(newUserModel: newUser);
      await getUserAll();
    }catch(e){
      print(e);
    }
  }
}