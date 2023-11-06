import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect {
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();


  static const imageUrl2= 'http://lucknowichikankari.in/';
  static const baseAppUrl = 'http://lucknowichikankari.in/backend/api/';
  static const uniqueKey = '9|X7hWJKiyKDvdeJAnlGTQuoXa8eQ4kui0cmRAJergef4f44e5';


  @override
  void onInit() {
    //baseUrl = baseAppUrl;
    ///Authenticator will be called 3 times if HttpStatus is
    ///HttpStatus.unauthorized
    //httpClient.maxAuthRetries = 3;
  }
  String? tempToken;


  // Future<String> getMethod({
  //   required String method,
  //   required var body,
  //   Map<String, String>? header,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tempToken= prefs.getString('temp_token');
  //   try {
  //     var headers = header ?? {};
  //     headers.addAll({
  //       'Authorization': 'Bearer $tempToken',
  //       'Cookie':
  //       'XSRF-TOKEN=eyJpdiI6ImtZOXljTjV5STRhZFo1UCtFVkNtM1E9PSIsInZhbHVlIjoid1ZubmxqNER6cGhTQUdIY2g2OUZaWlM0aW5sQ013VVMzVC9BMzVNREw0Nkx3S2JFbDdFVFpuNXFadENqb2ZTbXg0UXgrSmc2VnF6dzEvMTNiZmZHcGZSVXUxNTl4d01KQ2plSUNJb2lWbTA3TEV5cGg4VTFPQVBqMDBCeVJ4bEoiLCJtYWMiOiI2ODNiNmI1MTMxZTEwMTc1YjdmZGUxYjk2ZjgyYjAyMTIzMjQ2MzUyOTI3YzUxN2ZiYTFkMDMxYzZjOTJiOWFlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1GMmxGSVA0dTN0NGNtd0FUNWVXQ0E9PSIsInZhbHVlIjoiTHlrTmhBNEpZSStIWktGS2RWYlhXc0ltakVENVF5elBzaHFYQ2thanhhcnl4VnVSYmc0Z0l3MVZTdXF1d3QwaUtyQll2TmJCMTM3WDNPVFd5Rm0yclBzK1pjaHBsVVNodHRoUm9aUEFFRUVaY2pzWGhKRnhmbU1BeE11ZCtjRm8iLCJtYWMiOiI5NDc4OGUwZjkzNWM5NGI5ZjM0M2NiN2FhNzRlMzQxZGEwN2EzMzYzYTk5MzVkNjA5NWNjNzY4MjFmMDEyMjJkIiwidGFnIjoiIn0%3D',
  //     });
  //      print('-----------------------jjj---${tempToken}');
  //     log('$baseAppUrl$method');
  //     if (headers.isNotEmpty) {
  //       log(headers.toString());
  //
  //     }
  //     final response = await http.get(
  //       Uri.parse('$baseAppUrl$method'),
  //       headers: headers,
  //
  //     );
  //
  //     log(response.body);
  //     final jsonData = jsonDecode(response.body);
  //     return response.body;
  //   } catch (e) {
  //     log('______ getMethod error ${e.toString()}');
  //     return '';
  //   }
  // }

  // Future<String> postMethod({
  //   required method,
  //   required var body,
  //   Map<String, String>? header,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tempToken= prefs.getString('temp_token');
  //   try {
  //     var headers = header ?? {};
  //     headers.addAll({
  //       'Authorization': 'Bearer$tempToken',
  //       'Cookie': 'XSRF-TOKEN=eyJpdiI6ImtZOXljTjV5STRhZFo1UCtFVkNtM1E9PSIsInZhbHVlIjoid1ZubmxqNER6cGhTQUdIY2g2OUZaWlM0aW5sQ013VVMzVC9BMzVNREw0Nkx3S2JFbDdFVFpuNXFadENqb2ZTbXg0UXgrSmc2VnF6dzEvMTNiZmZHcGZSVXUxNTl4d01KQ2plSUNJb2lWbTA3TEV5cGg4VTFPQVBqMDBCeVJ4bEoiLCJtYWMiOiI2ODNiNmI1MTMxZTEwMTc1YjdmZGUxYjk2ZjgyYjAyMTIzMjQ2MzUyOTI3YzUxN2ZiYTFkMDMxYzZjOTJiOWFlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1GMmxGSVA0dTN0NGNtd0FUNWVXQ0E9PSIsInZhbHVlIjoiTHlrTmhBNEpZSStIWktGS2RWYlhXc0ltakVENVF5elBzaHFYQ2thanhhcnl4VnVSYmc0Z0l3MVZTdXF1d3QwaUtyQll2TmJCMTM3WDNPVFd5Rm0yclBzK1pjaHBsVVNodHRoUm9aUEFFRUVaY2pzWGhKRnhmbU1BeE11ZCtjRm8iLCJtYWMiOiI5NDc4OGUwZjkzNWM5NGI5ZjM0M2NiN2FhNzRlMzQxZGEwN2EzMzYzYTk5MzVkNjA5NWNjNzY4MjFmMDEyMjJkIiwidGFnIjoiIn0%3D',
  //     });
  //     print("------786---------${headers}");
  //     log('$baseAppUrl$method');
  //     if (header != null) {
  //       log(header.toString());
  //
  //     }
  //     log(body.toString());
  //     final response = await http.post(
  //       Uri.parse('$baseAppUrl$method'),
  //       body: body,
  //       headers: header,
  //     );
  //     final json = jsonDecode(response.body);
  //     log(response.body);
  //     // return json;
  //     return response.body;
  //   } catch (e) {
  //     log('______ post Method error ${e.toString()}');
  //     return '';
  //   }
  // }

  Future<String> postMethod({
    required method,
    required var body,
    Map<String, String>? header,

  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    tempToken= prefs.getString('temp_token');
    var headers = header ?? {};
    headers.addAll({
      'Authorization': 'Bearer $tempToken',
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6ImtZOXljTjV5STRhZFo1UCtFVkNtM1E9PSIsInZhbHVlIjoid1ZubmxqNER6cGhTQUdIY2g2OUZaWlM0aW5sQ013VVMzVC9BMzVNREw0Nkx3S2JFbDdFVFpuNXFadENqb2ZTbXg0UXgrSmc2VnF6dzEvMTNiZmZHcGZSVXUxNTl4d01KQ2plSUNJb2lWbTA3TEV5cGg4VTFPQVBqMDBCeVJ4bEoiLCJtYWMiOiI2ODNiNmI1MTMxZTEwMTc1YjdmZGUxYjk2ZjgyYjAyMTIzMjQ2MzUyOTI3YzUxN2ZiYTFkMDMxYzZjOTJiOWFlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1GMmxGSVA0dTN0NGNtd0FUNWVXQ0E9PSIsInZhbHVlIjoiTHlrTmhBNEpZSStIWktGS2RWYlhXc0ltakVENVF5elBzaHFYQ2thanhhcnl4VnVSYmc0Z0l3MVZTdXF1d3QwaUtyQll2TmJCMTM3WDNPVFd5Rm0yclBzK1pjaHBsVVNodHRoUm9aUEFFRUVaY2pzWGhKRnhmbU1BeE11ZCtjRm8iLCJtYWMiOiI5NDc4OGUwZjkzNWM5NGI5ZjM0M2NiN2FhNzRlMzQxZGEwN2EzMzYzYTk5MzVkNjA5NWNjNzY4MjFmMDEyMjJkIiwidGFnIjoiIn0%3D',
    });

    try {
      log('$baseAppUrl$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      final response = await http.post(
        Uri.parse('$baseAppUrl$method'),
        body: body,
        headers: headers,
      );
      print('=========$headers');
      final json = jsonDecode(response.body);
      log(response.body);
      // return json;
      return response.body;
    } catch (e) {

      log('______ post Method error ${e.toString()}');
      return '';
    }
  }




  Future<String> postMethodMultipart(http.MultipartRequest request) async {
    log(request.fields.toString());
    if (request.files.isNotEmpty) {
      for (var element in request.files) {
        log('___ file ${element.field.toString()} length = ${element.length}');
      }
    } else {
      log('___ file empty');
    }
    http.Response response =
    await http.Response.fromStream(await request.send());
    log(response.body.toString());
    final data = jsonDecode(response.body);
    if (data['code'].toString() == '401') {
      //token expired
      /*Get.offAndToNamed(
        'AppRoutes.login',
        arguments: 'Session expired!!!\nPlease login again.',
      );*/
      return '';
    } else {
      return response.body;
    }
  }




  Future<String> getMethod({
    required String method,
    required var body,
    Map<String, String>? header,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      tempToken= prefs.getString('temp_token');
      var headers = header ?? {};
      headers.addAll({
        'Authorization': 'Bearer $tempToken',
        'Cookie':
        'XSRF-TOKEN=eyJpdiI6ImtZOXljTjV5STRhZFo1UCtFVkNtM1E9PSIsInZhbHVlIjoid1ZubmxqNER6cGhTQUdIY2g2OUZaWlM0aW5sQ013VVMzVC9BMzVNREw0Nkx3S2JFbDdFVFpuNXFadENqb2ZTbXg0UXgrSmc2VnF6dzEvMTNiZmZHcGZSVXUxNTl4d01KQ2plSUNJb2lWbTA3TEV5cGg4VTFPQVBqMDBCeVJ4bEoiLCJtYWMiOiI2ODNiNmI1MTMxZTEwMTc1YjdmZGUxYjk2ZjgyYjAyMTIzMjQ2MzUyOTI3YzUxN2ZiYTFkMDMxYzZjOTJiOWFlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1GMmxGSVA0dTN0NGNtd0FUNWVXQ0E9PSIsInZhbHVlIjoiTHlrTmhBNEpZSStIWktGS2RWYlhXc0ltakVENVF5elBzaHFYQ2thanhhcnl4VnVSYmc0Z0l3MVZTdXF1d3QwaUtyQll2TmJCMTM3WDNPVFd5Rm0yclBzK1pjaHBsVVNodHRoUm9aUEFFRUVaY2pzWGhKRnhmbU1BeE11ZCtjRm8iLCJtYWMiOiI5NDc4OGUwZjkzNWM5NGI5ZjM0M2NiN2FhNzRlMzQxZGEwN2EzMzYzYTk5MzVkNjA5NWNjNzY4MjFmMDEyMjJkIiwidGFnIjoiIn0%3D',
      });

      final response = await http.get(
        Uri.parse('$baseAppUrl$method'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          final jsonData = jsonDecode(response.body);
          return response.body;
        } else {
          // Handle non-JSON response here
          return 'Non-JSON response: ${response.body}';
        }
      } else {
        // Handle non-200 status code
        return 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      // Handle other exceptions
      print('______ getMethod error ${e.toString()}');
      return '';
    }
  }



}