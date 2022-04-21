class AddOrderRequest{
  late String id_product;

  AddOrderRequest({required String id_product}){
    this.id_product = id_product;
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.id_product;
    return data;
  }
}