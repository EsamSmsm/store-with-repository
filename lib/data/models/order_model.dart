class OrderModel {
  OrderModel({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.createdVia,
    required this.customerNote,
    required this.dateCompleted,
    required this.datePaid,
    required this.cartHash,
    required this.number,
    required this.metaData,
    required this.lineItems,
    required this.taxLines,
    required this.shippingLines,
    required this.feeLines,
    required this.couponLines,
    required this.refunds,
    required this.dateCreatedGmt,
    required this.dateModifiedGmt,
    required this.dateCompletedGmt,
    required this.datePaidGmt,
    required this.pllSyncPost,
    required this.currencySymbol,
  });
  late final int id;
  late final int parentId;
  late final String status;
  late final String currency;
  late final String version;
  late final bool pricesIncludeTax;
  late final String dateCreated;
  late final String dateModified;
  late final String discountTotal;
  late final String discountTax;
  late final String shippingTotal;
  late final String shippingTax;
  late final String cartTax;
  late final String total;
  late final String totalTax;
  late final int customerId;
  late final String orderKey;
  late final Billing billing;
  late final Shipping shipping;
  late final String paymentMethod;
  late final String paymentMethodTitle;
  late final String transactionId;
  late final String customerIpAddress;
  late final String customerUserAgent;
  late final String createdVia;
  late final String customerNote;
  late final String dateCompleted;
  late final String datePaid;
  late final String cartHash;
  late final String number;
  late final List<MetaData> metaData;
  late final List<LineItems> lineItems;
  late final List<dynamic> taxLines;
  late final List<ShippingLines> shippingLines;
  late final List<dynamic> feeLines;
  late final List<dynamic> couponLines;
  late final List<dynamic> refunds;
  late final String dateCreatedGmt;
  late final String dateModifiedGmt;
  late final String dateCompletedGmt;
  late final String datePaidGmt;
  late final List<dynamic> pllSyncPost;
  late final String currencySymbol;

  OrderModel.fromJson(dynamic json){
    id = json['id'] as int;
    parentId = json['parent_id']as int;
    status = json['status']as String;
    currency = json['currency']as String;
    version = json['version']as String;
    pricesIncludeTax = json['prices_include_tax']as bool;
    dateCreated = json['date_created']as String;
    dateModified = json['date_modified']as String;
    discountTotal = json['discount_total']as String;
    discountTax = json['discount_tax']as String;
    shippingTotal = json['shipping_total']as String;
    shippingTax = json['shipping_tax']as String;
    cartTax = json['cart_tax']as String;
    total = json['total']as String;
    totalTax = json['total_tax']as String;
    customerId = json['customer_id']as int;
    orderKey = json['order_key']as String;
    billing = Billing.fromJson(json['billing']as Map<String, dynamic>);
    shipping = Shipping.fromJson(json['shipping']as Map<String, dynamic>);
    paymentMethod = json['payment_method']as String;
    paymentMethodTitle = json['payment_method_title']as String;
    transactionId = json['transaction_id']as String;
    customerIpAddress = json['customer_ip_address']as String;
    customerUserAgent = json['customer_user_agent']as String;
    createdVia = json['created_via']as String;
    customerNote = json['customer_note']as String;
    dateCompleted = json['date_completed']as String;
    datePaid = json['date_paid']as String;
    cartHash = json['cart_hash']as String;
    number = json['number']as String;
    metaData = List.from(json['meta_data']as List).map((e)=>MetaData.fromJson(e)).toList();
    lineItems = List.from(json['line_items']as List).map((e)=>LineItems.fromJson(e)).toList();
    taxLines = List.castFrom<dynamic, dynamic>(json['tax_lines']as List);
    shippingLines = List.from(json['shipping_lines']as List).map((e)=>ShippingLines.fromJson(e)).toList();
    feeLines = List.castFrom<dynamic, dynamic>(json['fee_lines']as List);
    couponLines = List.castFrom<dynamic, dynamic>(json['coupon_lines']as List);
    refunds = List.castFrom<dynamic, dynamic>(json['refunds']as List);
    dateCreatedGmt = json['date_created_gmt']as String;
    dateModifiedGmt = json['date_modified_gmt']as String;
    dateCompletedGmt = json['date_completed_gmt']as String;
    datePaidGmt = json['date_paid_gmt']as String;
    pllSyncPost = List.castFrom<dynamic, dynamic>(json['pll_sync_post']as List);
    currencySymbol = json['currency_symbol']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['status'] = status;
    _data['currency'] = currency;
    _data['version'] = version;
    _data['prices_include_tax'] = pricesIncludeTax;
    _data['date_created'] = dateCreated;
    _data['date_modified'] = dateModified;
    _data['discount_total'] = discountTotal;
    _data['discount_tax'] = discountTax;
    _data['shipping_total'] = shippingTotal;
    _data['shipping_tax'] = shippingTax;
    _data['cart_tax'] = cartTax;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['customer_id'] = customerId;
    _data['order_key'] = orderKey;
    _data['billing'] = billing.toJson();
    _data['shipping'] = shipping.toJson();
    _data['payment_method'] = paymentMethod;
    _data['payment_method_title'] = paymentMethodTitle;
    _data['transaction_id'] = transactionId;
    _data['customer_ip_address'] = customerIpAddress;
    _data['customer_user_agent'] = customerUserAgent;
    _data['created_via'] = createdVia;
    _data['customer_note'] = customerNote;
    _data['date_completed'] = dateCompleted;
    _data['date_paid'] = datePaid;
    _data['cart_hash'] = cartHash;
    _data['number'] = number;
    _data['meta_data'] = metaData.map((e)=>e.toJson()).toList();
    _data['line_items'] = lineItems.map((e)=>e.toJson()).toList();
    _data['tax_lines'] = taxLines;
    _data['shipping_lines'] = shippingLines.map((e)=>e.toJson()).toList();
    _data['fee_lines'] = feeLines;
    _data['coupon_lines'] = couponLines;
    _data['refunds'] = refunds;
    _data['date_created_gmt'] = dateCreatedGmt;
    _data['date_modified_gmt'] = dateModifiedGmt;
    _data['date_completed_gmt'] = dateCompletedGmt;
    _data['date_paid_gmt'] = datePaidGmt;
    _data['pll_sync_post'] = pllSyncPost;
    _data['currency_symbol'] = currencySymbol;
    return _data;
  }
}

class Billing {
  Billing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });
  late final String firstName;
  late final String lastName;
  late final String company;
  late final String address_1;
  late final String address_2;
  late final String city;
  late final String state;
  late final String postcode;
  late final String country;
  late final String email;
  late final String phone;

  Billing.fromJson(Map<String, dynamic> json){
    firstName = json['first_name']as String;
    lastName = json['last_name']as String;
    company = json['company']as String;
    address_1 = json['address_1']as String;
    address_2 = json['address_2']as String;
    city = json['city']as String;
    state = json['state']as String;
    postcode = json['postcode']as String;
    country = json['country']as String;
    email = json['email']as String;
    phone = json['phone']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['company'] = company;
    _data['address_1'] = address_1;
    _data['address_2'] = address_2;
    _data['city'] = city;
    _data['state'] = state;
    _data['postcode'] = postcode;
    _data['country'] = country;
    _data['email'] = email;
    _data['phone'] = phone;
    return _data;
  }
}

class Shipping {
  Shipping({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
  });
  late final String firstName;
  late final String lastName;
  late final String company;
  late final String address_1;
  late final String address_2;
  late final String city;
  late final String state;
  late final String postcode;
  late final String country;
  late final String phone;

  Shipping.fromJson(Map<String, dynamic> json){
    firstName = json['first_name']as String;
    lastName = json['last_name']as String;
    company = json['company']as String;
    address_1 = json['address_1']as String;
    address_2 = json['address_2']as String;
    city = json['city']as String;
    state = json['state']as String;
    postcode = json['postcode']as String;
    country = json['country']as String;
    phone = json['phone']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['company'] = company;
    _data['address_1'] = address_1;
    _data['address_2'] = address_2;
    _data['city'] = city;
    _data['state'] = state;
    _data['postcode'] = postcode;
    _data['country'] = country;
    _data['phone'] = phone;
    return _data;
  }
}

class MetaData {
  MetaData({
    required this.id,
    required this.key,
    required this.value,
  });
  late final int id;
  late final String key;
  late final String value;

  MetaData.fromJson(dynamic json){
    id = json['id']as int;
    key = json['key']as String;
    value = json['value']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['key'] = key;
    _data['value'] = value;
    return _data;
  }
}

class LineItems {
  LineItems({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    this.sku,
    required this.price,
    this.parentName,
  });
  late final int id;
  late final String name;
  late final int productId;
  late final int variationId;
  late final int quantity;
  late final String taxClass;
  late final String subtotal;
  late final String subtotalTax;
  late final String total;
  late final String totalTax;
  late final List<dynamic> taxes;
  late final List<dynamic> metaData;
  late final Null sku;
  late final int price;
  late final Null parentName;

  LineItems.fromJson(dynamic json){
    id = json['id']as int;
    name = json['name']as String;
    productId = json['product_id']as int;
    variationId = json['variation_id']as int;
    quantity = json['quantity']as int;
    taxClass = json['tax_class']as String;
    subtotal = json['subtotal']as String;
    subtotalTax = json['subtotal_tax']as String;
    total = json['total']as String;
    totalTax = json['total_tax']as String;
    taxes = List.castFrom<dynamic, dynamic>(json['taxes']as List);
    metaData = List.castFrom<dynamic, dynamic>(json['meta_data']as List);
    sku = null;
    price = json['price']as int;
    parentName = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['product_id'] = productId;
    _data['variation_id'] = variationId;
    _data['quantity'] = quantity;
    _data['tax_class'] = taxClass;
    _data['subtotal'] = subtotal;
    _data['subtotal_tax'] = subtotalTax;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['taxes'] = taxes;
    _data['meta_data'] = metaData;
    _data['sku'] = sku;
    _data['price'] = price;
    _data['parent_name'] = parentName;
    return _data;
  }
}

class ShippingLines {
  ShippingLines({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.instanceId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
  });
  late final int id;
  late final String methodTitle;
  late final String methodId;
  late final String instanceId;
  late final String total;
  late final String totalTax;
  late final List<dynamic> taxes;
  late final List<dynamic> metaData;

  ShippingLines.fromJson(dynamic json){
    id = json['id']as int;
    methodTitle = json['method_title']as String;
    methodId = json['method_id']as String;
    instanceId = json['instance_id']as String;
    total = json['total']as String;
    totalTax = json['total_tax']as String;
    taxes = List.castFrom<dynamic, dynamic>(json['taxes']as List);
    metaData = List.castFrom<dynamic, dynamic>(json['meta_data']as List);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['method_title'] = methodTitle;
    _data['method_id'] = methodId;
    _data['instance_id'] = instanceId;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['taxes'] = taxes;
    _data['meta_data'] = metaData;
    return _data;
  }
}

