import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pageapi/screen/page/model/page_model.dart';

class ApiHelper {
  static ApiHelper helper = ApiHelper._();

  ApiHelper._();

  Future<PageModel?> pageApi(int page) async {
    String api = "https://pixabay.com/api/?key=41719809-bfbc15734e5fd2f31cfcb2f83&q=nature&page=$page";
    var respons = await http.get(Uri.parse(api));
    if(respons.statusCode == 200){
      var json= jsonDecode(respons.body);
      PageModel pageModel = PageModel.mapToModel(json);
      return pageModel;
    }
    return null;
  }
}
