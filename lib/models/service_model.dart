class System {
  final int terminal_id;
  final int tenant_id;
  final DateTime business_date;
  final DateTime latest_load_time;

  System(
      {required this.terminal_id,
      required this.tenant_id,
      required this.business_date,
      required this.latest_load_time});
}

class Users {
  final int user_id;
  final int tenant_id;
  final String username;
  final String password;
  final String first_name;
  final String last_name;
  final String email;
  final DateTime created_date;
  final DateTime updated_date;

  Users(
      {required this.user_id,
      required this.tenant_id,
      required this.username,
      required this.password,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.created_date,
      required this.updated_date});
}

class Terminal {
  final int terminal_id;
  final int tenant_id;
  final String terminal_code;
  final String terminal_name;
  final String serial_number;
  final int rvc_id;
  final DateTime created_date;
  final DateTime updated_date;

  Terminal(
      {required this.terminal_id,
      required this.tenant_id,
      required this.terminal_code,
      required this.terminal_name,
      required this.serial_number,
      required this.rvc_id,
      required this.created_date,
      required this.updated_date});
}

class Uom {
  final int uom_id;
  final String uom_code;
  final String uom_name;
  final String uom_abbrv;
  final DateTime created_date;
  final DateTime updated_date;

  Uom(
      {required this.uom_id,
      required this.uom_code,
      required this.uom_name,
      required this.uom_abbrv,
      required this.created_date,
      required this.updated_date});
}

class Uom_group {
  final int uom_group_id;
  final int tenant_id;
  final String uom_group_code;
  final String uom_group_name;
  final int base_uom_id;
  final DateTime created_date;
  final DateTime updated_date;

  Uom_group({
    required this.uom_group_id,
    required this.tenant_id,
    required this.uom_group_code,
    required this.uom_group_name,
    required this.base_uom_id,
    required this.created_date,
    required this.updated_date,
  });
}

class Uom_group_item {
  final int uom_group_id;
  final int alt_uom_id;
  final double base_qty;

  Uom_group_item({
    required this.uom_group_id,
    required this.alt_uom_id,
    required this.base_qty,
  });
}

class Product_category {
  final int category_id;
  final int tenant_id;
  final String category_code;
  final String category_name;
  final int parent_category_id;
  final String costing_method;
  final String image;
  final DateTime created_date;
  final DateTime updated_date;

  Product_category({
    required this.category_id,
    required this.tenant_id,
    required this.category_code,
    required this.category_name,
    required this.parent_category_id,
    required this.costing_method,
    required this.image,
    required this.created_date,
    required this.updated_date,
  });
}

class Product_barcode {
  final int product_id;
  final String barcode;
  final int uom_id;

  Product_barcode({
    required this.product_id,
    required this.barcode,
    required this.uom_id,
  });
}

class Product {
  final int product_id;
  final int tenant_id;
  final String product_code;
  final String product_name;
  final String product_description;
  final String product_type;
  final int category_id;
  final double fixed_cost;
  final double sales_price;
  final String internal_ref_code;
  final int uom_group_id;
  final bool can_be_sold;
  final bool can_be_expensed;
  final String tracking_status;
  final bool variant_status;
  final DateTime created_date;
  final DateTime updated_date;

  Product({
    required this.product_id,
    required this.tenant_id,
    required this.product_code,
    required this.product_name,
    required this.product_description,
    required this.product_type,
    required this.category_id,
    required this.fixed_cost,
    required this.sales_price,
    required this.internal_ref_code,
    required this.uom_group_id,
    required this.can_be_sold,
    required this.can_be_expensed,
    required this.tracking_status,
    required this.variant_status,
    required this.created_date,
    required this.updated_date,
  });
}

class Sales {
  final int terminal_id;
  final int sales_id;
  final int tenant_id;
  final int check_number;
  final String receipt_number;
  final String sales_type;
  final int? table_id;
  final int? customer_qty;
  final double total_amount;
  final double bill_discount;
  final double item_discount;
  final double subtotal_amount;
  final String vat_type;
  final double vat_rate;
  final double vat_amount;
  final double service_charge_amount;
  final double net_total_amount;
  final int? member_id;
  final int point_earned;
  final DateTime business_date;
  final int paid_terminal_id;
  final DateTime paid_date;
  final int paid_by;
  final String status;
  final DateTime created_date;
  final int created_by;
  final DateTime? voided_date;
  final int? voided_by;
  final int? voided_reason_id;

  Sales({
    required this.terminal_id,
    required this.sales_id,
    required this.tenant_id,
    required this.check_number,
    required this.receipt_number,
    required this.sales_type,
    this.table_id,
    this.customer_qty,
    required this.total_amount,
    required this.bill_discount,
    required this.item_discount,
    required this.subtotal_amount,
    required this.vat_type,
    required this.vat_rate,
    required this.vat_amount,
    required this.service_charge_amount,
    required this.net_total_amount,
    this.member_id,
    required this.point_earned,
    required this.business_date,
    required this.paid_terminal_id,
    required this.paid_date,
    required this.paid_by,
    required this.status,
    required this.created_date,
    required this.created_by,
    this.voided_date,
    this.voided_by,
    this.voided_reason_id,
  });
}

class Sales_discount {
  final int terminal_id;
  final int sales_id;
  final int discount_seq;
  final String discount_type;
  final double discount_rate;
  final double discount_amount;
  final double amount_before;
  final double amount_after;

  Sales_discount({
    required this.terminal_id,
    required this.sales_id,
    required this.discount_seq,
    required this.discount_type,
    required this.discount_rate,
    required this.discount_amount,
    required this.amount_before,
    required this.amount_after,
  });
}

class Sales_item {
  final int terminal_id;
  final int sales_id;
  final int item_seq;
  final String trans_type;
  final int product_id;
  final int qty;
  final int uom_id;
  final double unit_price;
  final double discount_amount;
  final double subtotal_amount;
  final String vat_type;
  final double vat_rate;
  final double vat_amount;
  final double net_total_amount;

  Sales_item({
    required this.terminal_id,
    required this.sales_id,
    required this.item_seq,
    required this.trans_type,
    required this.product_id,
    required this.qty,
    required this.uom_id,
    required this.unit_price,
    required this.discount_amount,
    required this.subtotal_amount,
    required this.vat_type,
    required this.vat_rate,
    required this.vat_amount,
    required this.net_total_amount,
  });
}

class Sales_item_discount {
  final int terminal_id;
  final int sales_id;
  final int item_seq;
  final int discount_seq;
  final String discount_type;
  final double discount_rate;
  final double discount_amount;
  final double amount_before;
  final double amount_after;

  Sales_item_discount({
    required this.terminal_id,
    required this.sales_id,
    required this.item_seq,
    required this.discount_seq,
    required this.discount_type,
    required this.discount_rate,
    required this.discount_amount,
    required this.amount_before,
    required this.amount_after,
  });
}

class Sales_payment {
  final int terminal_id;
  final int sales_id;
  final int payment_seq;
  final int payment_type_id;
  final double amount;
  final String voucher_number;
  final int currency_id;
  final double currency_rate;
  final double currency_charge_amount;
  final String card_number;
  final String card_holder_name;
  final String card_issuer_name;
  final String edc_trace_number;
  final String edc_approval_code;
  final double credit_charge_amount;
  final double tip_amount;

  Sales_payment({
    required this.terminal_id,
    required this.sales_id,
    required this.payment_seq,
    required this.payment_type_id,
    required this.amount,
    required this.voucher_number,
    required this.currency_id,
    required this.currency_rate,
    required this.currency_charge_amount,
    required this.card_number,
    required this.card_holder_name,
    required this.card_issuer_name,
    required this.edc_trace_number,
    required this.edc_approval_code,
    required this.credit_charge_amount,
    required this.tip_amount,
  });
}

class Sales_reason {
  final int reason_id;
  final int tenant_id;
  final String reason_type;
  final String reason_description;
  final DateTime created_date;
  final DateTime updated_date;

  Sales_reason({
    required this.reason_id,
    required this.tenant_id,
    required this.reason_type,
    required this.reason_description,
    required this.created_date,
    required this.updated_date,
  });
}

class Cash_drawer_log {
  final int terminal_id;
  final DateTime log_datetime;
  final int tenant_id;
  final String trans_type;
  final int reason_id;
  final double amount;
  final int user_id;
  final DateTime business_date;

  Cash_drawer_log({
    required this.terminal_id,
    required this.log_datetime,
    required this.tenant_id,
    required this.trans_type,
    required this.reason_id,
    required this.amount,
    required this.user_id,
    required this.business_date,
  });
}

class Refund {
  final int terminal_id;
  final int refund_id;
  final int tenant_id;
  final int refund_number;
  final String receipt_number;
  final int sales_terminal_id;
  final int sales_id;
  final double total_amount;
  final double bill_discount;
  final double item_discount;
  final double subtotal_amount;
  final String vat_type;
  final double vat_rate;
  final double vat_amount;
  final double service_charge_amount;
  final double net_total_amount;
  final int refund_reason_id;
  final int member_id;
  final int point_burned;
  final DateTime business_date;
  final String status;
  final DateTime created_date;
  final int created_by;
  final DateTime voided_date;
  final int voided_by;
  final int voided_reason_id;

  Refund({
    required this.terminal_id,
    required this.refund_id,
    required this.tenant_id,
    required this.refund_number,
    required this.receipt_number,
    required this.sales_terminal_id,
    required this.sales_id,
    required this.total_amount,
    required this.bill_discount,
    required this.item_discount,
    required this.subtotal_amount,
    required this.vat_type,
    required this.vat_rate,
    required this.vat_amount,
    required this.service_charge_amount,
    required this.net_total_amount,
    required this.refund_reason_id,
    required this.member_id,
    required this.point_burned,
    required this.business_date,
    required this.status,
    required this.created_date,
    required this.created_by,
    required this.voided_date,
    required this.voided_by,
    required this.voided_reason_id,
  });
}

class Refund_item {
  final int terminal_id;
  final int refund_id;
  final int item_seq;
  final int sales_terminal_id;
  final int sales_id;
  final int sales_item_seq;
  final int product_id;
  final int qty;
  final int uom_id;
  final double unit_price;
  final double discount_amount;
  final double subtotal_amount;
  final String vat_type;
  final double vat_rate;
  final double vat_amount;
  final double net_total_amount;

  Refund_item({
    required this.terminal_id,
    required this.refund_id,
    required this.item_seq,
    required this.sales_terminal_id,
    required this.sales_id,
    required this.sales_item_seq,
    required this.product_id,
    required this.qty,
    required this.uom_id,
    required this.unit_price,
    required this.discount_amount,
    required this.subtotal_amount,
    required this.vat_type,
    required this.vat_rate,
    required this.vat_amount,
    required this.net_total_amount,
  });
}

class Refund_item_discount {
  final int terminal_id;
  final int refund_id;
  final int item_seq;
  final int discount_seq;
  final String discount_type;
  final double discount_rate;
  final double discount_amount;
  final double amount_before;
  final double amount_after;

  Refund_item_discount({
    required this.terminal_id,
    required this.refund_id,
    required this.item_seq,
    required this.discount_seq,
    required this.discount_type,
    required this.discount_rate,
    required this.discount_amount,
    required this.amount_before,
    required this.amount_after,
  });
}

class Refund_discount {
  final int terminal_id;
  final int refund_id;
  final int discount_seq;
  final String discount_type;
  final double discount_rate;
  final double discount_amount;
  final double amount_before;
  final double amount_after;

  Refund_discount({
    required this.terminal_id,
    required this.refund_id,
    required this.discount_seq,
    required this.discount_type,
    required this.discount_rate,
    required this.discount_amount,
    required this.amount_before,
    required this.amount_after,
  });
}

class Credit_note {
  final int rvc_id;
  final String cn_number;
  final int tenant_id;
  final int terminal_id;
  final int refund_id;
  final DateTime cn_date;
  final String customer_type;
  final String customer_name;
  final String address;
  final String subdistrict;
  final String district;
  final String province;
  final String country;
  final String zipcode;
  final String tax_id;
  final String phone_number;
  final String branch_type;
  final String branch_name;
  final DateTime created_date;
  final int created_by;
  final DateTime updated_date;
  final int updated_by;
  final DateTime voided_date;
  final int voided_by;
  final int voided_reason_id;

  Credit_note({
    required this.rvc_id,
    required this.cn_number,
    required this.tenant_id,
    required this.terminal_id,
    required this.refund_id,
    required this.cn_date,
    required this.customer_type,
    required this.customer_name,
    required this.address,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.country,
    required this.zipcode,
    required this.tax_id,
    required this.phone_number,
    required this.branch_type,
    required this.branch_name,
    required this.created_date,
    required this.created_by,
    required this.updated_date,
    required this.updated_by,
    required this.voided_date,
    required this.voided_by,
    required this.voided_reason_id,
  });
}

class Currency {
  final int currency_id;
  final int tenant_id;
  final String currency_code;
  final String currency_name;
  final double exchange_rate;
  final DateTime created_date;
  final DateTime updated_date;

  Currency({
    required this.currency_id,
    required this.tenant_id,
    required this.currency_code,
    required this.currency_name,
    required this.exchange_rate,
    required this.created_date,
    required this.updated_date,
  });
}

class Expense {
  final int expense_id;
  final int tenant_id;
  final String expense_name;
  final double amount;
  final DateTime created_date;
  final DateTime updated_date;

  Expense({
    required this.expense_id,
    required this.tenant_id,
    required this.expense_name,
    required this.amount,
    required this.created_date,
    required this.updated_date,
  });
}

class Full_receipt {
  final int rvc_id;
  final int invoice_number;
  final int tenant_id;
  final int terminal_id;
  final int sales_id;
  final DateTime invoice_date;
  final String customer_type;
  final String customer_name;
  final String address;
  final String subdistrict;
  final String district;
  final String province;
  final String country;
  final String zipcode;
  final String tax_id;
  final String phone_number;
  final String branch_type;
  final String branch_name;
  final DateTime created_date;
  final int created_by;
  final DateTime updated_date;
  final int updated_by;
  final DateTime voided_date;
  final int voided_by;
  final int voided_reason_id;

  Full_receipt({
    required this.rvc_id,
    required this.invoice_number,
    required this.tenant_id,
    required this.terminal_id,
    required this.sales_id,
    required this.invoice_date,
    required this.customer_type,
    required this.customer_name,
    required this.address,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.country,
    required this.zipcode,
    required this.tax_id,
    required this.phone_number,
    required this.branch_type,
    required this.branch_name,
    required this.created_date,
    required this.created_by,
    required this.updated_date,
    required this.updated_by,
    required this.voided_date,
    required this.voided_by,
    required this.voided_reason_id,
  });
}

class Revenue_center {
  final int rvc_id;
  final int tenant_id;
  final String rvc_code;
  final String rvc_name;
  final int branch_id;
  final String local_currency_code;
  final DateTime created_date;
  final DateTime updated_date;

  Revenue_center({
    required this.rvc_id,
    required this.tenant_id,
    required this.rvc_code,
    required this.rvc_name,
    required this.branch_id,
    required this.local_currency_code,
    required this.created_date,
    required this.updated_date,
  });
}

class Revenue_center_product {
  final int rvc_id;
  final int product_id;

  Revenue_center_product({
    required this.rvc_id,
    required this.product_id,
  });
}

class Cash_denomination {
  final int denomination_id;
  final int tenant_id;
  final String denomination_name;
  final double denomination_value;
  final DateTime created_date;
  final DateTime updated_date;

  Cash_denomination({
    required this.denomination_id,
    required this.tenant_id,
    required this.denomination_name,
    required this.denomination_value,
    required this.created_date,
    required this.updated_date,
  });
}

class Shift {
  final int terminal_id;
  final DateTime business_date;
  final int shift_seq;
  final int tenant_id;
  final DateTime open_datetime;
  final int open_user_id;
  final DateTime close_datetime;
  final int close_user_id;

  Shift({
    required this.terminal_id,
    required this.business_date,
    required this.shift_seq,
    required this.tenant_id,
    required this.open_datetime,
    required this.open_user_id,
    required this.close_datetime,
    required this.close_user_id,
  });
}

class Payment_type {
  final int payment_type_id;
  final int tenant_id;
  final String payment_type;
  final String payment_type_name;
  final DateTime created_date;
  final DateTime updated_date;

  Payment_type({
    required this.payment_type_id,
    required this.tenant_id,
    required this.payment_type,
    required this.payment_type_name,
    required this.created_date,
    required this.updated_date,
  });
}
