class ProductModel {
  late String id;
  late String name;
  late String address;
  late int price;
  late String img;
  late int quantity;
  late List<String> gallery;

  ProductModel(String? id, String? name, String? address, int? price, String? img, int? quantity, List<String>? gallery) {
    this.id = id ??= "";
    this.name = name ??= "";
    this.address = address ??= "";
    this.price = price ??= -1;
    this.img = img ??= "";
    this.quantity = quantity ??= -1;
    this.gallery = gallery ??= [];
  }
}