
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp"

    CREATE TABLE IF NOT EXISTS system (
      terminal_id UUID DEFAULT uuid_generate_v4() UNIQUE,
      tenant_id UUID DEFAULT uuid_generate_v4() UNIQUE,
      business_date TIMESTAMP,
      latest_load_time TIMESTAMP,
      PRIMARY KEY (terminal_id, tenant_id)
    );

    CREATE TABLE IF NOT EXISTS users(
      user_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      username VARCHAR(50),
      password VARCHAR(50),
      first_name VARCHAR(50),
      last_name VARCHAR(50),
      email VARCHAR(50),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (user_id),
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id)
    );

    CREATE TABLE IF NOT EXISTS revenue_center (
      rvc_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      rvc_code VARCHAR(10),
      rvc_name VARCHAR(50),
      branch_id UUID DEFAULT uuid_generate_v4(),
      local_currency_code VARCHAR(3),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (rvc_id),
      FOREIGN KEY (tenant_id)  REFERENCES system (tenant_id )
      -- FOREIGN KEY branch_id REFERENCES branch (branch_id),
      --todo revenue_center finish
    );

    CREATE TABLE IF NOT EXISTS terminal ( --FINISH
      terminal_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      terminal_code VARCHAR(10),
      terminal_name VARCHAR(20),--NVARCHAR
      serial_number VARCHAR(30),
      rvc_id UUID DEFAULT uuid_generate_v4(),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (terminal_id),
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id),
      FOREIGN KEY (rvc_id) REFERENCES revenue_center(rvc_id)
    );

    CREATE TABLE IF NOT EXISTS uom ( --FINISH
      uom_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      uom_code VARCHAR(10), --รหัสหน่วยสินค้า
      uom_name VARCHAR(20), --ชื่อหน่วยสินค้า NVARCHAR ไม่มี
      uom_abbrv VARCHAR(5), --ชื่อย่อหน่วยสินค้า
      created_date TIMESTAMP, --วันที่สร้างข้อมูล
      updated_date TIMESTAMP, --วันที่อัพเดทข้อมูล
      PRIMARY KEY (uom_id),
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id)
    );

    CREATE TABLE IF NOT EXISTS uom_group (--FINISH
      uom_group_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(), -- Id ผู้สมัครใช้ระบบ FK
      uom_group_code VARCHAR(50), -- รหัสกลุ่มของหน่วยสินค้า
      uom_group_name VARCHAR(255), --ชื่อกลุ่มของหน่วยสินค้า
      base_uom_id UUID DEFAULT uuid_generate_v4(), -- Id หน่วยฐานของสินค้า FK
      created_date TIMESTAMP, --วันที่สร้างข้อมูล
      updated_date TIMESTAMP,  --วันที่อัพเดทข้อมูล
      PRIMARY KEY (uom_group_id),
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id)
      --FOREIGN KEY (base_uom_id) REFERENCES
    );

    CREATE TABLE IF NOT EXISTS uom_group_item ( --FINISH
      uom_group_id UUID DEFAULT uuid_generate_v4(),
      alt_uom_id UUID DEFAULT uuid_generate_v4(),
      base_qty INT,
      PRIMARY KEY (uom_group_id, alt_uom_id),
      FOREIGN KEY (uom_group_id) REFERENCES uom_group (uom_group_id),
      FOREIGN KEY (alt_uom_id) REFERENCES uom (uom_id)
    );

    CREATE TABLE IF NOT EXISTS product_category (
      category_id UUID DEFAULT uuid_generate_v4() UNIQUE,
      tenant_id UUID DEFAULT uuid_generate_v4(),
      category_code VARCHAR(20),
      category_name VARCHAR(50), --NVARCHAR
      parent_category_id UUID DEFAULT uuid_generate_v4(),
      costing_method VARCHAR(2),
      image text,
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id)
      --FOREIGN KEY (parent_category_id) REFERENCES
    );

    CREATE TABLE IF NOT EXISTS product_barcode( --FINISH
      product_id UUID DEFAULT uuid_generate_v4(),
      barcode VARCHAR(30),
      uom_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (product_id),
      FOREIGN KEY (uom_id) REFERENCES uom(uom_id)
    );

    CREATE TABLE IF NOT EXISTS sales_reason (
      reason_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      reason_type VARCHAR(1),
      reason_description VARCHAR(50),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (reason_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id)
    );

    CREATE TABLE IF NOT EXISTS sales (
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT UNIQUE,
      tenant_id UUID DEFAULT uuid_generate_v4(),
      check_number INT,
      receipt_number VARCHAR(20),
      sales_type VARCHAR(1),
      table_id UUID DEFAULT null,
      customer_qty Smallint DEFAULT null,
      total_amount DECIMAL(10, 2),
      bill_discount DECIMAL(8, 2),
      item_discount DECIMAL(8, 2),
      subtotal_amount DECIMAL(10, 2),
      vat_type VARCHAR(1),
      vat_rate DECIMAL(5, 2),
      vat_amount DECIMAL(8, 2),
      service_charge_amount DECIMAL(8, 2),
      net_total_amount DECIMAL(10, 2),
      member_id UUID DEFAULT uuid_generate_v4(),
      point_earned Smallint,
      business_date TIMESTAMP,
      paid_terminal_id UUID DEFAULT uuid_generate_v4(),
      paid_date TIMESTAMP,
      paid_by UUID DEFAULT uuid_generate_v4(),
      status VARCHAR(1),
      created_date TIMESTAMP,
      created_by UUID DEFAULT uuid_generate_v4(),
      voided_date TIMESTAMP,
      voided_by UUID DEFAULT uuid_generate_v4(),
      voided_reason_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (terminal_id , sales_id),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      -- FOREIGN KEY (table_id) REFERENCES
      -- FOREIGN KEY (member_id) REFERENCES
      FOREIGN KEY (created_by) REFERENCES users(user_id),
      FOREIGN KEY (voided_by) REFERENCES users(user_id),
      FOREIGN KEY (voided_reason_id) REFERENCES sales_reason(reason_id)
    );

    CREATE TABLE IF NOT EXISTS product (--FINISH
      product_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      product_code VARCHAR(30),
      product_name VARCHAR(100), --NVARCHAR
      product_description text,
      product_type VARCHAR(1),
      category_id UUID DEFAULT uuid_generate_v4(),
      fixed_cost DECIMAL(10, 2),
      sales_price DECIMAL(10, 2),
      internal_ref_code VARCHAR(30),
      uom_group_id UUID DEFAULT uuid_generate_v4(),
      can_be_sold BIT, -- 0 = No | 1 =Yes
      can_be_expensed BIT,
      tracking_status VARCHAR(1), --N – No tracking  L – Lot S – Serial Number
      variant_status BIT,-- 0 = No | 1 =Yes
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (product_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      FOREIGN KEY (category_id) REFERENCES product_category(category_id),
      FOREIGN KEY (uom_group_id) REFERENCES uom_group(uom_group_id)
    );

    CREATE TABLE IF NOT EXISTS sales_discount( --FINISH
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT ,
      discount_seq Smallint,
      discount_type Varchar(1),
      discount_rate Decimal(5,2),
      discount_amount Decimal(8,2),
      amount_before Decimal(10,2),
      amount_after DECIMAL (18,2),
      PRIMARY KEY (terminal_id , sales_id , discount_seq),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales (sales_id)
    );

    CREATE TABLE IF NOT EXISTS slu_group (
      slu_group_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      slu_group_name VARCHAR(20),
      seq SMALLINT,
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (slu_group_id),
      --FOREIGN KEY (slu_group_id) REFERENCES,
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id)
    );

    CREATE TABLE IF NOT EXISTS slu_item (
      slu_group_id UUID DEFAULT uuid_generate_v4(),
      item_seq SMALLINT UNIQUE,
      product_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (slu_group_id , item_seq),
      FOREIGN KEY (slu_group_id) REFERENCES slu_group (slu_group_id),
      FOREIGN KEY (product_id) REFERENCES product_barcode (product_id)
    );

    CREATE TABLE IF NOT EXISTS sales_item (--FINISH
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT,
      item_seq SMALLINT UNIQUE,
      trans_type INT,
      product_id UUID DEFAULT uuid_generate_v4(),
      qty INT,
      uom_id UUID DEFAULT uuid_generate_v4(),
      unit_price DECIMAL(10, 2),
      discount_amount DECIMAL(8, 2),
      subtotal_amount DECIMAL(10, 2),
      vat_type VARCHAR(1),
      vat_rate DECIMAL(5, 2),
      vat_amount DECIMAL(8, 2),
      net_total_amount DECIMAL(10, 2),
      PRIMARY KEY (terminal_id , sales_id),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales(sales_id),
      FOREIGN KEY (item_seq) REFERENCES slu_item (item_seq),
      FOREIGN KEY (product_id) REFERENCES product_barcode (product_id),
      FOREIGN KEY (uom_id) REFERENCES uom (uom_id)
    );

    CREATE TABLE IF NOT EXISTS sales_item_discount (--FINISH
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT,
      item_seq Smallint,
      discount_seq Smallint,
      discount_type VARCHAR(1),
      discount_rate DECIMAL(5, 2),
      discount_amount DECIMAL(8, 2),
      amount_before DECIMAL(10, 2),
      amount_after DECIMAL(18, 2),
      PRIMARY KEY (terminal_id , sales_id , item_seq , discount_seq),
      FOREIGN KEY(terminal_id ) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales(sales_id),
      FOREIGN KEY (item_seq) REFERENCES sales_item (item_seq)
    );

    CREATE TABLE IF NOT EXISTS payment_type (
      payment_type_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      payment_type VARCHAR(3),
      payment_type_name VARCHAR(50),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (payment_type_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id)
    );

    CREATE TABLE IF NOT EXISTS currency(
      currency_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      currency_code VARCHAR(3),
      currency_name VARCHAR(30),
      exchange_rate DECIMAL(10,2),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (currency_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id)
    );

    CREATE TABLE IF NOT EXISTS sales_payment (
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT,
      payment_seq Smallint,
      payment_type_id UUID DEFAULT uuid_generate_v4(),
      amount DECIMAL(10, 2),
      voucher_number VARCHAR(20),
      currency_id UUID DEFAULT uuid_generate_v4(),
      currency_rate DECIMAL(5, 2),
      currency_charge_amount DECIMAL(8, 2),
      card_number VARCHAR(20),
      card_holder_name VARCHAR(50),
      card_issuer_name VARCHAR(50),
      edc_trace_number VARCHAR(10),
      edc_approval_code VARCHAR(10),
      credit_charge_amount DECIMAL(8, 2),
      tip_amount DECIMAL(8, 2),
      PRIMARY KEY (terminal_id , sales_id , payment_seq),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales (sales_id),
      --FOREIGN KEY (payment_seq) REFERENCES sales_payment(payment_seq),
      FOREIGN KEY (payment_type_id) REFERENCES payment_type(payment_type_id),
      FOREIGN KEY (currency_id) REFERENCES currency (currency_id)
    );

    CREATE TABLE IF NOT EXISTS cash_drawer_log(
      terminal_id UUID DEFAULT uuid_generate_v4(),
      log_datetime TIMESTAMP,
      tenant_id UUID DEFAULT uuid_generate_v4(),
      trans_type VARCHAR(1),
      reason_id UUID DEFAULT uuid_generate_v4(),
      amount DECIMAL(10,2),
      user_id UUID DEFAULT uuid_generate_v4(),
      business_date TIMESTAMP,
      PRIMARY KEY (terminal_id , log_datetime),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      FOREIGN KEY (reason_id) REFERENCES sales_reason (reason_id),
      FOREIGN KEY (user_id) REFERENCES users (user_id)
    );

    CREATE TABLE IF NOT EXISTS refund (
     terminal_id UUID DEFAULT uuid_generate_v4() UNIQUE,
     refund_id INT UNIQUE,
     tenant_id UUID DEFAULT uuid_generate_v4(),
     refund_number INT ,
     receipt_number VARCHAR(20),
     sales_terminal_id UUID DEFAULT uuid_generate_v4(),
     sales_id INT,
     total_amount DECIMAL(10,2),
     bill_discount DECIMAL(8,2),
     item_discount DECIMAL(8,2),
     subtotal_amount DECIMAL(10,2),
     vat_type VARCHAR(1),
     vat_rate DECIMAL(5,2),
     vat_amount DECIMAL(8,2),
     service_charge_amount DECIMAL(8,2),
     net_total_amount DECIMAL(10,2),
     refund_reason_id UUID DEFAULT uuid_generate_v4(),
     member_id UUID DEFAULT uuid_generate_v4(),
     point_burned SMALLINT,
     business_date TIMESTAMP,
     status  VARCHAR(1),
     created_date TIMESTAMP,
     created_by UUID DEFAULT uuid_generate_v4(),
     voided_date TIMESTAMP,
     voided_by UUID DEFAULT uuid_generate_v4(),
     voided_reason_id UUID DEFAULT uuid_generate_v4(),
     PRIMARY KEY (terminal_id , refund_id),
     FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id),
     FOREIGN KEY (tenant_id) REFERENCES system(tenant_id),
     FOREIGN KEY (refund_reason_id) REFERENCES sales_reason(reason_id),
     -- FOREIGN KEY (member_id) REFERENCES ,
     FOREIGN KEY (created_by) REFERENCES users(user_id),
     FOREIGN KEY (voided_by) REFERENCES users(user_id),
     FOREIGN KEY (voided_reason_id) REFERENCES sales_reason(reason_id)
    );

    CREATE TABLE IF NOT EXISTS refund_item (
      terminal_id UUID DEFAULT uuid_generate_v4(),
      refund_id INT,
      item_seq SMALLINT,
      sales_terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT,
      sales_item_seq SMALLINT,
      product_id UUID DEFAULT uuid_generate_v4(),
      qty INT,
      uom_id UUID DEFAULT uuid_generate_v4(),
      unit_price  DECIMAL(10,2),
      discount_amount DECIMAL(8,2),
      subtotal_amount DECIMAL(10,2),
      vat_type VARCHAR(1),
      vat_rate DECIMAL(5,2),
      vat_amount DECIMAL(8,2),
      net_total_amount DECIMAL(10,2),
      PRIMARY KEY (terminal_id , refund_id),
      FOREIGN KEY (terminal_id) REFERENCES system(terminal_id),
      FOREIGN KEY (refund_id) REFERENCES refund (refund_id),
      FOREIGN KEY (item_seq) REFERENCES slu_item (item_seq),
      FOREIGN KEY (sales_terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales (sales_id),
      --FOREIGN KEY (sales_item_seq) REFERENCES ,
      FOREIGN KEY (product_id) REFERENCES product_barcode (product_id),
      FOREIGN KEY (uom_id) REFERENCES uom (uom_id)
    );

    CREATE TABLE IF NOT EXISTS refund_item_discount (
      terminal_id UUID DEFAULT uuid_generate_v4(),
      refund_id INT,
      item_seq SMALLINT,
      discount_seq SMALLINT,
      discount_type VARCHAR(1),
      discount_rate DECIMAL(5,2),
      discount_amount DECIMAL(8,2),
      amount_before DECIMAL(10,2),
      amount_after DECIMAL(18,2),
      PRIMARY KEY (terminal_id, refund_id, item_seq, discount_seq),
      FOREIGN KEY (terminal_id ) REFERENCES refund (terminal_id),
      FOREIGN KEY (refund_id) REFERENCES refund (refund_id),
      FOREIGN KEY (item_seq) REFERENCES slu_item (item_seq)
    );

    CREATE TABLE IF NOT EXISTS refund_discount (
      terminal_id UUID DEFAULT uuid_generate_v4(),
      refund_id INT,
      discount_seq SMALLINT,
      discount_type VARCHAR(1),
      discount_rate DECIMAL(5,2),
      discount_amount DECIMAL(8,2),
      amount_before DECIMAL(10,2),
      amount_after DECIMAL(18,2),
      PRIMARY KEY (terminal_id, refund_id, discount_seq),
      FOREIGN KEY (terminal_id) REFERENCES terminal(terminal_id),
      FOREIGN KEY (refund_id) REFERENCES refund(refund_id)
    );

    CREATE TABLE IF NOT EXISTS credit_note (
      rvc_id UUID DEFAULT uuid_generate_v4(),
      cn_number VARCHAR(20),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      terminal_id UUID DEFAULT uuid_generate_v4(),
      refund_id INT,
      cn_date TIMESTAMP,
      customer_type VARCHAR(1),
      customer_name VARCHAR(100),
      address VARCHAR(200),
      subdistrict VARCHAR(30),
      district VARCHAR(30),
      province VARCHAR(30),
      country VARCHAR(30),
      zipcode VARCHAR(5),
      tax_id VARCHAR(15),
      phone_number VARCHAR(10),
      branch_type VARCHAR(2),
      branch_name VARCHAR(1),
      created_date TIMESTAMP,
      created_by UUID DEFAULT uuid_generate_v4(),
      updated_date TIMESTAMP,
      updated_by UUID DEFAULT uuid_generate_v4(),
      voided_date TIMESTAMP,
      voided_by UUID DEFAULT uuid_generate_v4(),
      voided_reason_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (rvc_id , cn_number),
      FOREIGN KEY (rvc_id) REFERENCES revenue_center(rvc_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (refund_id) REFERENCES refund(refund_id),
      FOREIGN KEY (created_by) REFERENCES users(user_id),
      FOREIGN KEY (updated_by) REFERENCES users(user_id),
      FOREIGN KEY (voided_by) REFERENCES users(user_id),
      FOREIGN KEY (voided_reason_id) REFERENCES sales_reason(reason_id)
      --todo credit_note finish
    );

    CREATE TABLE IF NOT EXISTS expense(
      expense_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      expense_name VARCHAR(30),
      amount DECIMAL(10,2),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (expense_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id)
    );

    CREATE TABLE IF NOT EXISTS full_receipt(
      rvc_id UUID DEFAULT uuid_generate_v4(),
      invoice_number VARCHAR(20),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      terminal_id UUID DEFAULT uuid_generate_v4(),
      sales_id INT,
      invoice_date TIMESTAMP,
      customer_type VARCHAR(1),
      customer_name VARCHAR(100),
      address VARCHAR(200),
      subdistrict VARCHAR(30),
      district VARCHAR(30),
      province VARCHAR(30),
      country VARCHAR(30),
      zipcode VARCHAR(5),
      tax_id VARCHAR(15),
      phone_number VARCHAR(10),
      branch_type VARCHAR(2),
      branch_name VARCHAR(1),
      created_date TIMESTAMP,
      created_by UUID DEFAULT uuid_generate_v4(),
      updated_date TIMESTAMP,
      updated_by UUID DEFAULT uuid_generate_v4(),
      voided_date TIMESTAMP,
      voided_by UUID DEFAULT uuid_generate_v4(),
      voided_reason_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY(rvc_id , invoice_number),
      FOREIGN KEY (rvc_id) REFERENCES revenue_center (rvc_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (sales_id) REFERENCES sales (sales_id),
      FOREIGN KEY (created_by) REFERENCES users (user_id),
      FOREIGN KEY (updated_by) REFERENCES users (user_id),
      FOREIGN KEY (voided_by) REFERENCES users (user_id),
      FOREIGN KEY (voided_reason_id) REFERENCES sales_reason(reason_id)
    );

    CREATE TABLE IF NOT EXISTS revenue_center_product (
      rvc_id UUID DEFAULT uuid_generate_v4(),
      product_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (rvc_id, product_id),
      FOREIGN KEY (rvc_id) REFERENCES revenue_center(rvc_id),
      FOREIGN KEY (product_id) REFERENCES product_barcode(product_id)
    );

    CREATE TABLE IF NOT EXISTS cash_denomination(
      denomination_id UUID DEFAULT uuid_generate_v4(),
      tenant_id UUID DEFAULT uuid_generate_v4(),
      denomination_name VARCHAR(20),
      denomination_value DECIMAL(10,2),
      created_date TIMESTAMP,
      updated_date TIMESTAMP,
      PRIMARY KEY (denomination_id),
      FOREIGN KEY (tenant_id) REFERENCES system(tenant_id)
    );

    CREATE TABLE IF NOT EXISTS shift(
      terminal_id UUID DEFAULT uuid_generate_v4(),
      business_date TIMESTAMP,
      shift_seq SMALLINT,
      tenant_id UUID DEFAULT uuid_generate_v4(),
      open_datetime TIMESTAMP,
      open_user_id UUID DEFAULT uuid_generate_v4(),
      close_datetime TIMESTAMP,
      close_user_id UUID DEFAULT uuid_generate_v4(),
      PRIMARY KEY (terminal_id, business_date, shift_seq),
      FOREIGN KEY (terminal_id) REFERENCES system (terminal_id),
      FOREIGN KEY (tenant_id) REFERENCES system (tenant_id),
      FOREIGN KEY (open_user_id) REFERENCES users (user_id),
      FOREIGN KEY (close_user_id) REFERENCES users (user_id)
    );

    CREATE TABLE IF NOT EXISTS product_image (
      product_id UUID DEFAULT uuid_generate_v4(),
      image_seq SMALLINT,
      image_url text,
      PRIMARY KEY (product_id , image_seq),
      FOREIGN KEY (product_id) REFERENCES product_barcode(product_id)
    );
