import 'dart:convert';
import 'package:frontend/global_variables.dart';
import 'package:frontend/model/banner.dart';

import 'package:http/http.dart' as http;

class BannerController {
  Future<List<BannerModel>> loadbanner() async {
    try {
      // send http request to fetch banners
      http.Response bannerResponse = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );


      if (bannerResponse.statusCode == 200) {
        List<dynamic> data = jsonDecode(bannerResponse.body);
        List<BannerModel> banners =
            data.map((banners) => BannerModel.fromJson(banners)).toList();
        return banners;
      } else {
        throw Exception("Unable to load banners!");
      }
    } catch (e) {
      throw Exception("Failed to load banners!");
    }
  }
}
