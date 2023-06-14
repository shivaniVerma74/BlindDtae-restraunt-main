/// error : false
/// message : "Tables data found"
/// data : [{"id":"1","name":"High Top Table","res_id":"76","benifits":"AC, POOL, WiFi","price":"100","total_tables":"5","image":"","created_at":"2023-04-26 19:11:30"},{"id":"2","name":"Roof Toop","res_id":"76","benifits":"AC, POOL, WiFi","price":"100","total_tables":"5","image":"","created_at":"2023-04-26 19:14:52"}]

class TablesListModel {
  TablesListModel({
      bool? error, 
      String? message, 
      List<TablesList>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  TablesListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TablesList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<TablesList>? _data;
TablesListModel copyWith({  bool? error,
  String? message,
  List<TablesList>? data,
}) => TablesListModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<TablesList>? get data => _data;

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
/// name : "High Top Table"
/// res_id : "76"
/// benifits : "AC, POOL, WiFi"
/// price : "100"
/// total_tables : "5"
/// image : ""
/// created_at : "2023-04-26 19:11:30"

class TablesList {
  TablesList({
      String? id, 
      String? name, 
      String? resId, 
      String? benifits, 
      String? price, 
      String? totalTables, 
      String? image, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _resId = resId;
    _benifits = benifits;
    _price = price;
    _totalTables = totalTables;
    _image = image;
    _createdAt = createdAt;
}

  TablesList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _resId = json['res_id'];
    _benifits = json['benifits'];
    _price = json['price'];
    _totalTables = json['total_tables'];
    _image = json['image'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _name;
  String? _resId;
  String? _benifits;
  String? _price;
  String? _totalTables;
  String? _image;
  String? _createdAt;
TablesList copyWith({  String? id,
  String? name,
  String? resId,
  String? benifits,
  String? price,
  String? totalTables,
  String? image,
  String? createdAt,
}) => TablesList(  id: id ?? _id,
  name: name ?? _name,
  resId: resId ?? _resId,
  benifits: benifits ?? _benifits,
  price: price ?? _price,
  totalTables: totalTables ?? _totalTables,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get resId => _resId;
  String? get benifits => _benifits;
  String? get price => _price;
  String? get totalTables => _totalTables;
  String? get image => _image;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['res_id'] = _resId;
    map['benifits'] = _benifits;
    map['price'] = _price;
    map['total_tables'] = _totalTables;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    return map;
  }

}