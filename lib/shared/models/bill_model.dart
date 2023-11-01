// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BillModel {
  final String? name;
  final String? dueDate;
  final double? value;
  final String? barcode;
  BillModel({
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
  });

  BillModel copyWith({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    return BillModel(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      name: map['name'] != null ? map['name'] as String : null,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      value: map['value'] != null ? map['value'] as double : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) => BillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BillModel(name: $name, dueDate: $dueDate, value: $value, barcode: $barcode)';
  }

  @override
  bool operator ==(covariant BillModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.dueDate == dueDate &&
      other.value == value &&
      other.barcode == barcode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dueDate.hashCode ^
      value.hashCode ^
      barcode.hashCode;
  }
}
