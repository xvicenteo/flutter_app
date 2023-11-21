import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutterapps/user_services/storage.dart';



// to use it

final client = InterceptedClient.build(
  interceptors: [],
);
    