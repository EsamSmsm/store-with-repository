import 'package:equatable/equatable.dart';
import 'package:hospital25/data/models/address_model.dart';

class CustomerModel extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  final String avatarUrl;
  final bool isPayingCustomer;
  final AddressModel billing;
  final AddressModel shipping;

  const CustomerModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.avatarUrl,
    required this.isPayingCustomer,
    required this.billing,
    required this.shipping,
  });

  @override
  List<Object> get props {
    return [
      id,
      email,
      firstName,
      lastName,
      role,
      username,
      avatarUrl,
      isPayingCustomer,
      billing,
      shipping,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'billing': billing.toMap(isBilling: true),
      'shipping': shipping.toMap(isBilling: false),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      role: map['role'] as String,
      username: map['username'] as String,
      avatarUrl: map['avatar_url'] as String,
      isPayingCustomer: map['is_paying_customer'] as bool,
      billing: AddressModel.fromMap(map['billing'] as Map<String, dynamic>),
      shipping: AddressModel.fromMap(map['shipping'] as Map<String, dynamic>),
    );
  }

  CustomerModel copyWith({
    String? firstName,
    String? lastName,
    AddressModel? billing,
    AddressModel? shipping,
  }) {
    return CustomerModel(
      id: id,
      email: email,
      role: role,
      username: username,
      avatarUrl: avatarUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isPayingCustomer: isPayingCustomer,
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
    );
  }
}
