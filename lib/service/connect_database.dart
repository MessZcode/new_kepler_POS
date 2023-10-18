import 'package:flutter/cupertino.dart';

import 'config_connection.dart';

class TestServices {
  Future<void> checkDatabase() async {
    final connectDB = ConnectDatabase(databaseName: ConnectDatabase.postgres);
    final connection = connectDB.connection();
//เพิ่มการใช้งาน uuid => CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    try {
      await connection.open();
      final dbExistsResult = await connection.query(
        "SELECT datname FROM pg_catalog.pg_database WHERE datname = @db",
        substitutionValues: {'db': ConnectDatabase.defaultDatabase},
      );
      if (dbExistsResult.isEmpty) {
        await connection.query(
          "CREATE DATABASE ${ConnectDatabase.defaultDatabase}",
        );
      }
      await connection.close();
      final newDBConnection = ConnectDatabase.withDefault();
      final conn = newDBConnection.connection();
      await conn.open();

      await conn.transaction((ctx) async {
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS pages(
              pageId int  PRIMARY KEY,
              PageName VARCHAR(100) UNIQUE,
              PageTitle VARCHAR(255),
              Icon VARCHAR(50)
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS users (
                userId SERIAL PRIMARY KEY,
                fname VARCHAR(50) ,
                lname VARCHAR(50) ,
                lastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
                email VARCHAR(50) ,
                password VARCHAR(50)
            );
          ''');
        await ctx.query('''
            CREATE TABLE category (
                categoryid int  PRIMARY KEY,
                categoryName VARCHAR(50)
            );
            ''');
        await ctx.query('''
            CREATE TABLE products (
                productId SERIAL PRIMARY KEY,
                productName VARCHAR(50) ,
                productPrice DECIMAL(10 , 2),
                ImageUrl VARCHAR(150) ,
                stockQTY int,
                IsSuggest BOOLEAN DEFAULT false,
                IsPromotion BOOLEAN DEFAULT false,
                categoryid int ,
                FOREIGN KEY (categoryid) REFERENCES category(categoryid)
            );
          ''');
        await ctx.query('''
            CREATE TABLE customers (
              customerId SERIAL PRIMARY KEY,
              fname VARCHAR(50) ,
              lname VARCHAR(50) ,
              email VARCHAR(50) ,
              phone VARCHAR(50) ,
              membershipTypeId int DEFAULT 1
            );
          ''');
        await ctx.query('''
            CREATE TABLE orders(
              orderId SERIAL PRIMARY KEY,
              orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              totalAmount DECIMAL(10,2),
              discountAmount DECIMAL(10,2),
              vatAmount DECIMAL(10,2),
              netAmount DECIMAL(10,2),
              billStatus VARCHAR(50),
              customerId int,
              userid int
            );
          ''');
        await ctx.query('''
            CREATE TABLE orderDetail(
              orderId int,
              orderDetailId int,
              productId int,
              productName VARCHAR(50),
              productqty int,
              priceperunit DECIMAL (10,2),
              itemVat DECIMAL (10,2),
              subTotal DECIMAL (10,2),
              discount DECIMAL(10 ,2),
              PRIMARY KEY (orderId, orderDetailId),
              FOREIGN KEY (orderId) REFERENCES orders (orderId)
          );
          ''');
        await ctx.query('''
            --CREATE ORDERPAYMENT
              CREATE TABLE orderpayments (
                  orderid int ,
                  paymentseq int ,
                  paymentid int,
                  paymentvalue DECIMAL(10 , 2),
                  paymentchange DECIMAL(10 , 2),
                  PRIMARY KEY (orderid, paymentseq)
              );
          ''');
        await ctx.query('''
            CREATE TABLE drawerdetail(
              pid integer NOT NULL,
              tenderid integer NOT NULL,
              tenderqty integer NOT NULL,
              tendervalue double precision NOT NULL
            );
          ''');
        await ctx.query('''
            CREATE TABLE drawertender(
              tenderid integer,
              tenderqty integer NOT NULL,
              tendervalue numeric NOT NULL
            );
          ''');
        await ctx.query('''
            CREATE TABLE drawerreason(
              reasonid integer NOT NULL,
              reasonname character(255) COLLATE pg_catalog."default" NOT NULL
            );
          ''');
        await ctx.query('''
            --CREATE DRAWERTYPE
            CREATE TABLE drawertype(
                type integer NOT NULL,
                typename character(255) COLLATE pg_catalog."default" NOT NULL
            );
          ''');
        await ctx.query('''
            --CREATE DRAWER
            CREATE TABLE drawer(
                pid integer NOT NULL,
                systemdate timestamp with time zone NOT NULL,
                type integer NOT NULL,
                cashvalue double precision NOT NULL,
                reasonid character(255) COLLATE pg_catalog."default" NOT NULL,
                CONSTRAINT drawer_pkey PRIMARY KEY (pid)
            );
          ''');
      });
      await conn.transaction((ctx) async {
        await ctx.query(''' 
            INSERT INTO pages (pageId , PageName , PageTitle , Icon) VALUES
              (1,'Dashboard' , '' , 'home.png'),
              (2,'HomePage' , 'Home' , 'gohome.png'),
              (3,'BillPage' , 'Bill' , 'bill.png'),
              (4,'DrawerPage' , 'Drawer' , 'drawable.png'),
              (5,'SettingPage' , 'Setting' ,'setting.png' );
          ''');
        await ctx.query(''' 
             INSERT INTO users (fname , lname , lastLogin , email , password) VALUES
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin1' , '1234'),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin2' , '12345678');
          ''');
        await ctx.query(''' 
             INSERT INTO category (categoryid ,categoryName)VALUES
              (1 ,'All Item'),(2 ,'Promotion'),(3 ,'Suggest Promotion'),(4 ,'Jeans'),(5,'Skirts'),(6,'T-Shirts'),(7,'Blazers');
          ''');
        await ctx.query(''' 
            INSERT INTO products (productName , productPrice , ImageUrl , stockQTY ,IsSuggest,IsPromotion, categoryid)VALUES
              ('Wide Leg Jeans' , 230.00 , 'Image2.png' , 100 , true , false , 4),
              ('Mom Fit Jeans' , 550.00 , 'Image3.png' , 100 , true , true , 4),
              ('Flare Leg Jeans' , 440.00 , 'Image4.png' , 100 , false , true , 4),
              ('Cute Floral Skirt' , 390.00 , 'Image5.png' , 100 , false , false , 5),
              ('High Waisted Skirt' , 490.00 , 'Image6.png' , 100 , true , false , 5),
              ('Mini Skirt' , 530.00 , 'Image7.png' , 100 , false , true , 5),
              ('Plaid Skirt' , 500.00 , 'Image8.png' , 100 , false , false , 5),
              ('Fashionable Blazer' , 499.00 , 'Image9.png' , 100 , true , true , 7),
              ('Fashionable' , 760.00 , 'Image10.png' , 100 , false , false , 7),
              ('T-Shirts No1' , 500.00 , 'Image11.png' , 100 , false , false , 6);
          ''');
        await ctx.query(''' 
           INSERT INTO customers (fname , lname , email , phone)VALUES
            ('testUser' , 'Me' , 'test@email.com' , '000-000-0000');
          ''');
      });
      await conn.close();
      // } else {
      //   await connection.close();
      // }
      debugPrint('Database setup complete');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
