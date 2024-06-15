import 'package:flutter/material.dart';
import 'package:pageapi/screen/page/model/page_model.dart';
import 'package:pageapi/util/api_helper.dart';

class PageProvider with ChangeNotifier {
  Future<PageModel?>? pageModel;
  List<HitsModel> hitsList=[];
  int page = 0;

  void getPage() {
    page++;
    pageModel = ApiHelper.helper.pageApi(page);

    pageModel!.then(
      (value) {
        if (value != null) {
          notifyListeners();
        }
      },
    );
  }
}
