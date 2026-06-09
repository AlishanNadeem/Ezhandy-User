class HomeModel {
  bool? isSuccess;
  int? statusCode;
  String? message;
  List<dynamic>? data;

  HomeModel({this.isSuccess, this.statusCode, this.message, this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      isSuccess: json['isSuccess'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'],
    );
  }
}