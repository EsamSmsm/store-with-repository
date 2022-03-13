class CartModel {
  CartModel({
    required this.coupons,
    required this.shippingRates,
    required this.shippingAddress,
    required this.billingAddress,
    required this.items,
    required this.itemsCount,
    required this.itemsWeight,
    required this.needsPayment,
    required this.needsShipping,
    required this.hasCalculatedShipping,
    required this.fees,
    required this.totals,
    required this.errors,
    required this.paymentRequirements,
    required this.extensions,
  });
  late final List<dynamic> coupons;
  late final List<dynamic> shippingRates;
  late final ShippingAddress shippingAddress;
  late final BillingAddress billingAddress;
  late final List<Items> items;
  late final dynamic itemsCount;
  late final dynamic itemsWeight;
  late final bool needsPayment;
  late final bool needsShipping;
  late final bool hasCalculatedShipping;
  late final List<dynamic> fees;
  late final Totals? totals;
  late final List<dynamic> errors;
  late final List<String> paymentRequirements;
  late final Extensions extensions;

  CartModel.fromJson(dynamic json){
    coupons = List.castFrom<dynamic, dynamic>(json['coupons']as List<dynamic>);
    shippingRates = List.castFrom<dynamic, dynamic>(json['shipping_rates']as List<dynamic>);
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']as Map<String, dynamic>);
    billingAddress = BillingAddress.fromJson(json['billing_address']as Map<String, dynamic>);
    items = List.from(json['items']as List<dynamic>).map((e)=>Items.fromJson(e)).toList();
    itemsCount = json['items_count'];
    itemsWeight = json['items_weight'];
    needsPayment = json['needs_payment'] as bool;
    needsShipping = json['needs_shipping']as bool;
    hasCalculatedShipping = json['has_calculated_shipping']as bool;
    fees = List.castFrom<dynamic, dynamic>(json['fees']as List<dynamic>);
    totals = Totals?.fromJson(json['totals']as Map<String, dynamic>);
    errors = List.castFrom<dynamic, dynamic>(json['errors']as List<dynamic>);
    paymentRequirements = List.castFrom<dynamic, String>(json['payment_requirements']as List<dynamic>);
    extensions = Extensions.fromJson(json['extensions']as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coupons'] = coupons;
    _data['shipping_rates'] = shippingRates;
    _data['shipping_address'] = shippingAddress.toJson();
    _data['billing_address'] = billingAddress.toJson();
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['items_count'] = itemsCount;
    _data['items_weight'] = itemsWeight;
    _data['needs_payment'] = needsPayment;
    _data['needs_shipping'] = needsShipping;
    _data['has_calculated_shipping'] = hasCalculatedShipping;
    _data['fees'] = fees;
    _data['totals'] = totals?.toJson();
    _data['errors'] = errors;
    _data['payment_requirements'] = paymentRequirements;
    _data['extensions'] = extensions.toJson();
    return _data;
  }
}

class ShippingAddress {
  ShippingAddress({
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

  ShippingAddress.fromJson(Map<String, dynamic> json){
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

class BillingAddress {
  BillingAddress({
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

  BillingAddress.fromJson(Map<String, dynamic> json){
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

class Items {
  Items({
    required this.key,
    required this.id,
    required this.quantity,
    required this.quantityLimits,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.sku,
    // this.lowStockRemaining,
    required this.backordersAllowed,
    required this.showBackorderBadge,
    required this.soldIndividually,
    required this.permalink,
    required this.images,
    required this.variation,
    required this.itemData,
    required this.prices,
    required this.totals,
    required this.catalogVisibility,
    required this.extensions,
  });
  late final String key;
  late final int id;
  late final dynamic quantity;
  late final QuantityLimits quantityLimits;
  late final String name;
  late final String shortDescription;
  late final String description;
  late final String sku;
  // late final  lowStockRemaining;
  late final bool backordersAllowed;
  late final bool showBackorderBadge;
  late final bool soldIndividually;
  late final String permalink;
  late final List<Images> images;
  late final List<dynamic> variation;
  late final List<dynamic> itemData;
  late final Prices prices;
  late final Totals? totals;
  late final String catalogVisibility;
  late final Extensions extensions;

  Items.fromJson(dynamic json){
    key = json['key']as String;
    id = json['id']as int;
    quantity = json['quantity'];
    quantityLimits = QuantityLimits.fromJson(json['quantity_limits']as Map<String, dynamic>);
    name = json['name']as String;
    shortDescription = json['short_description']as String;
    description = json['description']as String;
    sku = json['sku']as String;
    // lowStockRemaining = null  ;
    backordersAllowed = json['backorders_allowed']as bool;
    showBackorderBadge = json['show_backorder_badge']as bool;
    soldIndividually = json['sold_individually']as bool;
    permalink = json['permalink']as String;
    images = List.from(json['images']as List<dynamic>).map((e)=>Images.fromJson(e)).toList();
    variation = List.castFrom<dynamic, dynamic>(json['variation']as List);
    itemData = List.castFrom<dynamic, dynamic>(json['item_data']as List);
    prices = Prices.fromJson(json['prices']as Map<String, dynamic>);
    totals = Totals.fromJson(json['totals']as Map<String, dynamic>);
    catalogVisibility = json['catalog_visibility']as String;
    extensions = Extensions.fromJson(json['extensions']as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['id'] = id;
    _data['quantity'] = quantity;
    _data['quantity_limits'] = quantityLimits.toJson();
    _data['name'] = name;
    _data['short_description'] = shortDescription;
    _data['description'] = description;
    _data['sku'] = sku;
    // _data['low_stock_remaining'] = lowStockRemaining;
    _data['backorders_allowed'] = backordersAllowed;
    _data['show_backorder_badge'] = showBackorderBadge;
    _data['sold_individually'] = soldIndividually;
    _data['permalink'] = permalink;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['variation'] = variation;
    _data['item_data'] = itemData;
    _data['prices'] = prices.toJson();
    _data['totals'] = totals?.toJson();
    _data['catalog_visibility'] = catalogVisibility;
    _data['extensions'] = extensions.toJson();
    return _data;
  }
}

class QuantityLimits {
  QuantityLimits({
    required this.minimum,
    required this.maximum,
    required this.multipleOf,
    required this.editable,
  });
  late final int minimum;
  late final int maximum;
  late final int multipleOf;
  late final bool editable;

  QuantityLimits.fromJson(Map<String, dynamic> json){
    minimum = json['minimum']as int;
    maximum = json['maximum']as int;
    multipleOf = json['multiple_of']as int;
    editable = json['editable']as bool;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['minimum'] = minimum;
    _data['maximum'] = maximum;
    _data['multiple_of'] = multipleOf;
    _data['editable'] = editable;
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.src,
    required this.thumbnail,
    required this.srcset,
    required this.sizes,
    required this.name,
    required this.alt,
  });
  late final int id;
  late final String src;
  late final String thumbnail;
  late final String srcset;
  late final String sizes;
  late final String name;
  late final String alt;

  Images.fromJson(dynamic json){
    id = json['id']as int;
    src = json['src']as String;
    thumbnail = json['thumbnail']as String;
    srcset = json['srcset']as String;
    sizes = json['sizes']as String;
    name = json['name']as String;
    alt = json['alt']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['src'] = src;
    _data['thumbnail'] = thumbnail;
    _data['srcset'] = srcset;
    _data['sizes'] = sizes;
    _data['name'] = name;
    _data['alt'] = alt;
    return _data;
  }
}

class Prices {
  Prices({
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    // this.priceRange,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
    required this.rawPrices,
  });
  late final String price;
  late final String regularPrice;
  late final String salePrice;
  // late final Null priceRange;
  late final String currencyCode;
  late final String currencySymbol;
  late final int currencyMinorUnit;
  late final String currencyDecimalSeparator;
  late final String currencyThousandSeparator;
  late final String currencyPrefix;
  late final String currencySuffix;
  late final RawPrices rawPrices;

  Prices.fromJson(Map<String, dynamic> json){
    price = json['price']as String;
    regularPrice = json['regular_price']as String;
    salePrice = json['sale_price']as String;
    // priceRange = null ;
    currencyCode = json['currency_code']as String;
    currencySymbol = json['currency_symbol']as String;
    currencyMinorUnit = json['currency_minor_unit']as int;
    currencyDecimalSeparator = json['currency_decimal_separator']as String;
    currencyThousandSeparator = json['currency_thousand_separator']as String;
    currencyPrefix = json['currency_prefix']as String;
    currencySuffix = json['currency_suffix']as String;
    rawPrices = RawPrices.fromJson(json['raw_prices']as Map<String,dynamic>);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['price'] = price;
    _data['regular_price'] = regularPrice;
    _data['sale_price'] = salePrice;
    // _data['price_range'] = priceRange;
    _data['currency_code'] = currencyCode;
    _data['currency_symbol'] = currencySymbol;
    _data['currency_minor_unit'] = currencyMinorUnit;
    _data['currency_decimal_separator'] = currencyDecimalSeparator;
    _data['currency_thousand_separator'] = currencyThousandSeparator;
    _data['currency_prefix'] = currencyPrefix;
    _data['currency_suffix'] = currencySuffix;
    _data['raw_prices'] = rawPrices.toJson();
    return _data;
  }
}

class RawPrices {
  RawPrices({
    required this.precision,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
  });
  late final int precision;
  late final String price;
  late final String regularPrice;
  late final String salePrice;

  RawPrices.fromJson(Map<String, dynamic> json){
    precision = json['precision']as int;
    price = json['price']as String;
    regularPrice = json['regular_price']as String;
    salePrice = json['sale_price']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['precision'] = precision;
    _data['price'] = price;
    _data['regular_price'] = regularPrice;
    _data['sale_price'] = salePrice;
    return _data;
  }
}

class Totals {
  Totals({
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTotalTax,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
  });
  late final String? lineSubtotal;
  late final String? lineSubtotalTax;
  late final String? lineTotal;
  late final String? lineTotalTax;
  late final String? currencyCode;
  late final String? currencySymbol;
  late final int? currencyMinorUnit;
  late final String? currencyDecimalSeparator;
  late final String? currencyThousandSeparator;
  late final String? currencyPrefix;
  late final String? currencySuffix;

  Totals.fromJson(dynamic json){
    lineSubtotal = json['line_subtotal']as String?;
    lineSubtotalTax = json['line_subtotal_tax']as String?;
    lineTotal = json['line_total']as String?;
    lineTotalTax = json['line_total_tax']as String?;
    currencyCode = json['currency_code']as String?;
    currencySymbol = json['currency_symbol']as String?;
    currencyMinorUnit = json['currency_minor_unit']as int?;
    currencyDecimalSeparator = json['currency_decimal_separator']as String?;
    currencyThousandSeparator = json['currency_thousand_separator']as String?;
    currencyPrefix = json['currency_prefix']as String?;
    currencySuffix = json['currency_suffix'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['line_subtotal'] = lineSubtotal;
    _data['line_subtotal_tax'] = lineSubtotalTax;
    _data['line_total'] = lineTotal;
    _data['line_total_tax'] = lineTotalTax;
    _data['currency_code'] = currencyCode;
    _data['currency_symbol'] = currencySymbol;
    _data['currency_minor_unit'] = currencyMinorUnit;
    _data['currency_decimal_separator'] = currencyDecimalSeparator;
    _data['currency_thousand_separator'] = currencyThousandSeparator;
    _data['currency_prefix'] = currencyPrefix;
    _data['currency_suffix'] = currencySuffix;
    return _data;
  }
}

class Extensions {
  Extensions();

  Extensions.fromJson(dynamic json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
