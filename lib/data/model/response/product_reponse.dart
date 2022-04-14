class ProductResponse {
  String? id;
  String? name;
  String? address;
  int? price;
  String? img;
  int? quantity;
  List<String>? gallery;

  ProductResponse(
      {this.id,
      this.name,
      this.address,
      this.price,
      this.img,
      this.quantity,
      this.gallery});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['price'] = this.price;
    data['img'] = this.img;
    data['quantity'] = this.quantity;
    data['gallery'] = this.gallery;
    return data;
  }

  @override
  String toString() {
    return 'ProductResponse{id: $id, name: $name, address: $address, price: $price, img: $img, quantity: $quantity, gallery: $gallery}';
  }

  static ProductResponse formJson(Map<String, dynamic> json) {
    return ProductResponse.fromJson(json);
  }
}
