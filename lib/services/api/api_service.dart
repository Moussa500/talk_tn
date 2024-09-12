import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio=Dio();
  Future<void> sendPushNotification({
    required String title,
    required String message,
    required String fcmToken,
  })async{
    const String url='http://10.0.2.2:4000/api/sendNotification';
    try {
      Response response=await _dio.post(
        url,data: {
          'title':title,
          'message':message,
          'fcm_token':fcmToken,
        }
      );
      print('Notification sent:${response.data}');
    }on DioException catch (e) {
      if (e.response!=null) {
        print('Error sending notification:${e.response?.data}');
      }else{
        print('Error sending notification: ${e.message}');
      }
    }
  }
}