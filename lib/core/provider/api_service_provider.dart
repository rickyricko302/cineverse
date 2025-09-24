import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netxlif/core/network/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service_provider.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService(
    baseUrl: dotenv.get('base_url'),
    token: dotenv.get('token'),
  );
}
