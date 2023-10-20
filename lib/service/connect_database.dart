import 'package:flutter/cupertino.dart';

import 'config_connection.dart';

class TestServices {
  Future<void> checkDatabase() async {
    final connectDB = ConnectDatabase(databaseName: ConnectDatabase.postgres);
    final connection = connectDB.connection();

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
                password VARCHAR(50),
                permissionLv int
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS category (
                categoryid int  PRIMARY KEY,
                categoryName VARCHAR(50),
                workingStatus BOOLEAN
            );
            ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS products (
                productId SERIAL PRIMARY KEY,
                productName VARCHAR(50) ,
                productPrice DECIMAL(10 , 2),
                ImageUrl VARCHAR(150),
                stockQTY int,
                IsSuggest BOOLEAN DEFAULT false,
                IsPromotion BOOLEAN DEFAULT false
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS slu_item (
              slu_group_id int,
              item_seq int,
              productId int,
              Primary Key (slu_group_id ,item_seq),
              FOREIGN KEY (productId) REFERENCES products(productId)
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS customers (
              customerId SERIAL PRIMARY KEY,
              fname VARCHAR(50) ,
              lname VARCHAR(50) ,
              email VARCHAR(50) ,
              phone VARCHAR(50) ,
              membershipTypeId int DEFAULT 1
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS orders(
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
            CREATE TABLE IF NOT EXISTS orderDetail(
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
            --CREATE  ORDERPAYMENT
              CREATE TABLE IF NOT EXISTS orderpayments (
                  orderid int ,
                  paymentseq int ,
                  paymentid int,
                  paymentvalue DECIMAL(10 , 2),
                  paymentchange DECIMAL(10 , 2),
                  PRIMARY KEY (orderid, paymentseq)
              );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS drawerdetail(
              pid integer NOT NULL,
              tenderid integer NOT NULL,
              tenderqty integer NOT NULL,
              tendervalue double precision NOT NULL
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS drawertender(
              tenderid integer,
              tenderqty integer NOT NULL,
              tendervalue numeric NOT NULL
            );
          ''');
        await ctx.query('''
            CREATE TABLE IF NOT EXISTS drawerreason(
              reasonid integer NOT NULL,
              reasonname character(255) COLLATE pg_catalog."default" NOT NULL
            );
          ''');
        await ctx.query('''
            --CREATE DRAWERTYPE
            CREATE TABLE IF NOT EXISTS drawertype(
                type integer NOT NULL,
                typename character(255) COLLATE pg_catalog."default" NOT NULL
            );
          ''');
        await ctx.query('''
            --CREATE DRAWER
            CREATE TABLE IF NOT EXISTS drawer(
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
             INSERT INTO users (fname , lname , lastLogin , email , password , permissionLv) VALUES
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin1' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin2' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin3' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin4' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin5' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin6' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin7' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin8' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin9' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin10' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin11' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin12' , '12345678' ,1),
              ('Poramet' , 'DADADA' , CURRENT_TIMESTAMP , 'admin13' , '1234' , 1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin14' , '12345678' ,1),
              ('Suphisara' , 'BABABA' , CURRENT_TIMESTAMP , 'admin15' , '12345678' ,1);
          ''');
        await ctx.query(''' 
             INSERT INTO category (categoryid ,categoryName , workingStatus)VALUES
              (1 ,'All Item',true),(2 ,'Promotion',true),(3 ,'Suggest Promotion', true),
              (4 ,'Jeans',true),(5,'Skirts',true),(6,'T-Shirts',true),(7,'Blazers' ,true);
          ''');
        await ctx.query(''' 
            INSERT INTO products (productName , productPrice , ImageUrl , stockQTY ,IsSuggest,IsPromotion)VALUES
              ('Wide Leg Jeans' , 230.00 , 'Image2.png' , 100 , true , false ),
              ('Mom Fit Jeans' , 550.00 , 'Image3.png' , 100 , true , true ),
              ('Flare Leg Jeans' , 440.00 , 'Image4.png' , 100 , false , true ),
              ('Cute Floral Skirt' , 390.00 , 'Image5.png' , 100 , false , false ),
              ('High Waisted Skirt' , 490.00 , 'Image6.png' , 100 , true , false ),
              ('Mini Skirt' , 530.00 , 'Image7.png' , 100 , false , true ),
              ('Plaid Skirt' , 500.00 , 'Image8.png' , 100 , false , false),
              ('Fashionable Blazer' , 499.00 , 'Image9.png' , 100 , true , true),
              ('Fashionable' , 760.00 , 'Image10.png' , 100 , false , false),
              ('T-Shirts No1' , 500.00 , 'Image11.png' , 100 , false , false );
          ''');
        await ctx.query(''' 
           INSERT INTO customers (fname , lname , email , phone)VALUES
            ('testUser' , 'Me' , 'test@email.com' , '000-000-0000');
          ''');
      });
      await conn.close();
      debugPrint('Database setup complete');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
