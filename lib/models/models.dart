// class MembershipType {
//   final int membershipTypeID;
//   final String membershipTypeName;
//   final String description;
//   final String discount;
//
//   MembershipType({
//     required this.membershipTypeID,
//     required this.membershipTypeName,
//     required this.description,
//     required this.discount,
//   });
// }
//
// class Categories {
//   final int categoryID;
//   final String categoryName;
//   final String description;
//   final bool isActive;
//
//   Categories({
//     required this.categoryID,
//     required this.categoryName,
//     required this.description,
//     required this.isActive,
//   });
// }
//
// class Colors {
//   final int colorID;
//   final String colorName;
//
//   Colors({
//     required this.colorID,
//     required this.colorName,
//   });
// }
//
// class Size {
//   final int sizeID;
//   final String sizeName;
//
//   Size({
//     required this.sizeID,
//     required this.sizeName,
//   });
// }
//
// class AppPage {
//   final int pageID;
//   final String pageName;
//   final String pageTitle;
//   final String pageContent;
//   final String icon;
//
//   AppPage({
//     required this.pageID,
//     required this.pageName,
//     required this.pageTitle,
//     required this.pageContent,
//     required this.icon,
//   });
// }
//
// class Role {
//   final int roleID;
//   final String roleName;
//   final String description;
//
//   Role({
//     required this.roleID,
//     required this.roleName,
//     required this.description,
//   });
// }
//
// // class ProductX extends Product with ProductDetail {}
//
// class Product {
//   final int productID;
//   final String productName;
//   final String price;
//   final String description;
//   final String imageURL;
//   final int stockQuantity;
//   final int categoryID;
//   final bool isPromotion;
//   final bool isSuggested;
//
//   Product({
//     required this.productID,
//     required this.productName,
//     required this.price,
//     required this.description,
//     required this.imageURL,
//     required this.stockQuantity,
//     required this.categoryID,
//     required this.isPromotion,
//     required this.isSuggested,
//   });
// }
//
// class ProductDetail {
//   final int productDetailID;
//   final int productID;
//   final int colorID;
//   final int sizeID;
//   final int stockQuantity;
//
//   ProductDetail({
//     required this.productDetailID,
//     required this.productID,
//     required this.colorID,
//     required this.sizeID,
//     required this.stockQuantity,
//   });
// }
//
// class Customer {
//   final int customerID;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final DateTime dateOfBirth;
//   final String gender;
//   final String password;
//   final DateTime registrationDate;
//   final DateTime lastLogin;
//   final bool isActive;
//   final int loyaltyPoints;
//   final String profileImageURL;
//   final int membershipTypeID;
//
//   Customer({
//     required this.customerID,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.password,
//     required this.registrationDate,
//     required this.lastLogin,
//     required this.isActive,
//     required this.loyaltyPoints,
//     required this.profileImageURL,
//     required this.membershipTypeID,
//   });
// }
//
// class User {
//   final int userID;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final DateTime dateOfBirth;
//   final String gender;
//   final String password;
//   final DateTime registrationDate;
//   final DateTime lastLogin;
//   final bool isActive;
//   final String profileImageURL;
//   final int roleID;
//
//   User({
//     required this.userID,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.password,
//     required this.registrationDate,
//     required this.lastLogin,
//     required this.isActive,
//     required this.profileImageURL,
//     required this.roleID,
//   });
// }
//
// class OrderCreateModel {
//   // final int orderID;
//   final int customerID;
//   final DateTime orderDate;
//   final double totalAmount;
//   final double discount;
//   final String paymentStatus;
//   final bool isPaid;
//
//   OrderCreateModel({
//     // required this.orderID,
//     required this.customerID,
//     required this.orderDate,
//     required this.totalAmount,
//     required this.discount,
//     required this.paymentStatus,
//     required this.isPaid,
//   });
// }
//
// class OrderModel {
//   final int orderID;
//   final int customerID;
//   final DateTime orderDate;
//   final String totalAmount;
//   final String discount;
//   final String paymentStatus;
//   final bool isPaid;
//
//   OrderModel({
//     required this.orderID,
//     required this.customerID,
//     required this.orderDate,
//     required this.totalAmount,
//     required this.discount,
//     required this.paymentStatus,
//     required this.isPaid,
//   });
// }
//
// class OrderCreateDetail {
//   // final int orderDetailID;
//   final int orderID;
//   final int productID;
//   final int quantity;
//   final String pricePerUnit;
//   final String subtotal;
//   final String color;
//   final String size;
//
//   OrderCreateDetail({
//     // required this.orderDetailID,
//     required this.orderID,
//     required this.productID,
//     required this.quantity,
//     required this.pricePerUnit,
//     required this.subtotal,
//     required this.color,
//     required this.size,
//   });
// }
//
// class OrderDetailModel {
//   final int orderDetailID;
//   final int orderID;
//   final int productID;
//   final int quantity;
//   final String pricePerUnit;
//   final String subtotal;
//   final String color;
//   final String size;
//
//   OrderDetailModel({
//     required this.orderDetailID,
//     required this.orderID,
//     required this.productID,
//     required this.quantity,
//     required this.pricePerUnit,
//     required this.subtotal,
//     required this.color,
//     required this.size,
//   });
// }
//
// class Payment {
//   final int paymentID;
//   final int orderID;
//   final double paymentAmount;
//   final DateTime paymentDate;
//   final String paymentStatus;
//
//   Payment({
//     required this.paymentID,
//     required this.orderID,
//     required this.paymentAmount,
//     required this.paymentDate,
//     required this.paymentStatus,
//   });
// }
//
// class ProductCategories {
//   final int productCategoryID;
//   final int productID;
//   final int categoryID;
//
//   ProductCategories({
//     required this.productCategoryID,
//     required this.productID,
//     required this.categoryID,
//   });
// }
//
// class BillProducts {
//   final double total;
//   final double itemDiscount;
//   final double vat;
//   final double payAmount;
//
//   BillProducts({
//     required this.total,
//     required this.itemDiscount,
//     required this.vat,
//     required this.payAmount,
//   });
// }
//
// //New
// class SelectProduct {
//   int productId;
//   int productQTY;
//   String productName;
//   double productPrice;
//   double discount;
//   String size;
//   String color;
//
//   SelectProduct({
//     required this.productId,
//     required this.productQTY,
//     required this.productName,
//     required this.productPrice,
//     required this.discount,
//     required this.size,
//     required this.color,
//   });
// }
//
// class showBilDetailModel {
//   final int productID;
//   final int orderDetailID;
//   final int orderID;
//   final String productName;
//   final int discount;
//   final int quantity;
//   final String pricePerUnit;
//   final String subtotal;
//   final String color;
//   final String size;
//
//   showBilDetailModel(
//     this.orderDetailID,
//     this.orderID,
//     this.productID,
//     this.productName,
//     this.discount,
//     this.quantity,
//     this.pricePerUnit,
//     this.subtotal,
//     this.color,
//     this.size,
//   );
// }
//
// class TotalBill {
//   double total;
//   double discount;
//   double vat;
//   double payamount;
//
//   TotalBill({
//     required this.total,
//     required this.discount,
//     required this.vat,
//     required this.payamount,
//   });
// }
