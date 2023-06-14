/// error : false
/// message : "Table Types"
/// data : [{"id":"1","table_type":"High Top Table","price":"500","no_of_table":"30","created_at":"2023-04-26 15:46:11"},{"id":"2","table_type":"Sofas & Coffee Table","price":"300","no_of_table":"5","created_at":"2023-04-26 15:46:31"},{"id":"4","table_type":"Bar Seating","price":"500","no_of_table":"21","created_at":"2023-04-26 15:47:07"}]

class TableTypeModel {
  TableTypeModel({
      bool? error, 
      String? message, 
      List<TableType>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  TableTypeModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TableType.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<TableType>? _data;
TableTypeModel copyWith({  bool? error,
  String? message,
  List<TableType>? data,
}) => TableTypeModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<TableType>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// table_type : "High Top Table"
/// price : "500"
/// no_of_table : "30"
/// created_at : "2023-04-26 15:46:11"

class TableType {
  TableType({
      String? id, 
      String? tableType, 
      String? price, 
      String? noOfTable, 
      String? createdAt,}){
    _id = id;
    _tableType = tableType;
    _price = price;
    _noOfTable = noOfTable;
    _createdAt = createdAt;
}

  TableType.fromJson(dynamic json) {
    _id = json['id'];
    _tableType = json['table_type'];
    _price = json['price'];
    _noOfTable = json['no_of_table'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _tableType;
  String? _price;
  String? _noOfTable;
  String? _createdAt;
TableType copyWith({  String? id,
  String? tableType,
  String? price,
  String? noOfTable,
  String? createdAt,
}) => TableType(  id: id ?? _id,
  tableType: tableType ?? _tableType,
  price: price ?? _price,
  noOfTable: noOfTable ?? _noOfTable,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get tableType => _tableType;
  String? get price => _price;
  String? get noOfTable => _noOfTable;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['table_type'] = _tableType;
    map['price'] = _price;
    map['no_of_table'] = _noOfTable;
    map['created_at'] = _createdAt;
    return map;
  }

}