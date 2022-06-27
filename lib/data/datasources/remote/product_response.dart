/// _id : "622db2b4e9bbf47a1bc735fa"
/// name : "A Chảy - Mì Sủi Cảo & Cơm Chiên Gà Xối Mỡ - Shop Online"
/// address : "58/11 Nguyễn Văn Săng, P. Tân Sơn Nhì, Tân Phú, TP. HCM"
/// price : 30000
/// img : "assets/images/achay/banner.jpg"
/// quantity : 0
/// gallery : ["assets/images/achay/img1.jpg","assets/images/achay/img2.jpg","assets/images/achay/img3.jpg"]
/// date_created : "2022-03-13T09:00:30.888Z"
/// date_updated : null
/// __v : 0

class ProductResponse {
  ProductResponse(
      {String? id,
      String? name,
      String? address,
      int? price,
      String? img,
      int? quantity,
      List<String>? gallery}) {
    _id = id;
    _name = name;
    _address = address;
    _price = price;
    _img = img;
    _quantity = quantity;
    _gallery = gallery;
  }

  ProductResponse.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _address = json['address'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
  }

  String? _id;
  String? _name;
  String? _address;
  int? _price;
  String? _img;
  int? _quantity;
  List<String>? _gallery;

  String? get id => _id;

  String? get name => _name;

  String? get address => _address;

  int? get price => _price;

  String? get img => _img;

  int? get quantity => _quantity;

  List<String>? get gallery => _gallery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['price'] = _price;
    map['img'] = _img;
    map['quantity'] = _quantity;
    map['gallery'] = _gallery;
    return map;
  }


  @override
  String toString() {
    return 'ProductResponse{_id: $_id, _name: $_name, _address: $_address, _price: $_price, _img: $_img, _quantity: $_quantity, _gallery: $_gallery}';
  }

  static List<ProductResponse> pareJsonModelToList(List lst){
    List<ProductResponse> data = lst.map((json) => ProductResponse.fromJson(json)).toList();
    return data;
  }
}
