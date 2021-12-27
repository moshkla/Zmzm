class SearchModel {
  SearchModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  dynamic _message;
  Data? _data;

  bool? get status => _status;

  dynamic get message => _message;

  Data? get data => _data;
}

class Data {
  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _productData = [];
      json['data'].forEach((v) {
        _productData?.add(Product.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  dynamic? _currentPage;
  List<Product>? _productData;
  String? _firstPageUrl;
  dynamic? _from;
  dynamic? _lastPage;
  String? _lastPageUrl;
  dynamic _nextPageUrl;
  String? _path;
  dynamic? _perPage;
  dynamic _prevPageUrl;
  dynamic? _to;
  dynamic? _total;

  dynamic? get currentPage => _currentPage;

  List<Product>? get productData => _productData;

  String? get firstPageUrl => _firstPageUrl;

  dynamic? get from => _from;

  dynamic? get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  dynamic get nextPageUrl => _nextPageUrl;

  String? get path => _path;

  dynamic? get perPage => _perPage;

  dynamic get prevPageUrl => _prevPageUrl;

  dynamic? get to => _to;

  dynamic? get total => _total;
}

class Product {
  Product({
    dynamic? id,
    dynamic? price,
    dynamic? oldPrice,
    dynamic? discount,
    String? image,
    String? name,
    String? description,
  }) {
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
    _name = name;
    _description = description;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
    _name = json['name'];
    _description = json['description'];
  }

  dynamic? _id;
  dynamic? _price;
  dynamic? _oldPrice;
  dynamic? _discount;
  String? _image;
  String? _name;
  String? _description;

  dynamic? get id => _id;

  dynamic? get price => _price;

  dynamic? get oldPrice => _oldPrice;

  dynamic? get discount => _discount;

  String? get image => _image;

  String? get name => _name;

  String? get description => _description;
}
