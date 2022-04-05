class AppResponse<T>{
  String? message;
  int? result;
  T? data;

  AppResponse.fromJson(Map<String , dynamic> json , Function fromJsonModel){
    result = json['result'];
    data = fromJsonModel(json['data']);
    message = json['message'];
  }
}