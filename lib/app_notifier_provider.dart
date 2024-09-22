import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_state.dart';
import 'data.dart';

part 'app_notifier_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  AppState build() {
    return const Input();
  }

  void reset() {
    state = const Input();
  }

  // APIとやりとりして、状態にセットするのはProviderの中に記載する
  Future<void> convert(String sentence) async {
    state = const Loading();

    final url = Uri.parse('https://labs.goo.ne.jp/api/hiragana');
    final headers = {'Content-Type': 'application/json'};
    debugPrint(const String.fromEnvironment("appId"));
    final request = Request(
      appId: const String.fromEnvironment('appId'),
      sentence: sentence,
    );

    final result = await http.post(
      url,
      headers: headers,
      body: jsonEncode(request.toJson()),
    );

    final response = Response.fromJson(
      jsonDecode(result.body) as Map<String, Object?>,
    );
    state = Data(response.converted);
  }
}
