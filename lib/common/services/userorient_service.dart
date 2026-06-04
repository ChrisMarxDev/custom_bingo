import 'dart:convert';

import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:userorient_flutter/userorient_flutter.dart';

const userOrientApiKey = 'bdd8a7b8-04dc-4780-862f-d052f74e86e1';

const _userOrientProjectIdKey = 'user_orient_project_id';
const _userOrientUserUuidKey = 'user_orient_user_uuid';
const _userOrientSyncUrl = 'https://api.userorient.com/sdk/user/sync';

Future<void> syncUserOrientUserEmail({
  required String uniqueIdentifier,
  required String email,
}) async {
  final prefs = sharedPrefsBeacon.value;
  final cachedId = prefs.getString(_userOrientUserUuidKey);
  final response = await http.post(
    Uri.parse('$_userOrientSyncUrl?projectId=$userOrientApiKey'),
    body: jsonEncode({
      'userId': cachedId,
      'uniqueIdentifier': uniqueIdentifier,
      'fullName': null,
      'email': email,
      'phoneNumber': null,
      'language': null,
      'extra': null,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception(
      'UserOrient user sync failed with status ${response.statusCode}',
    );
  }

  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final userUuid = body['id'] as String?;
  if (userUuid == null || userUuid.isEmpty) {
    throw const FormatException('UserOrient user sync did not return an id');
  }

  await prefs.setString(_userOrientUserUuidKey, userUuid);
  await prefs.setString(_userOrientProjectIdKey, userOrientApiKey);
  UserOrient.userUuid = userUuid;
}
