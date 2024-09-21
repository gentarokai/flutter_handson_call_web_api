import 'package:flutter/material.dart';
import 'package:flutter_handson_call_web_api/app_notifier_provider.dart';
import 'package:flutter_handson_call_web_api/app_state.dart';
import 'package:flutter_handson_call_web_api/convert_result.dart';
import 'package:flutter_handson_call_web_api/input_form.dart';
import 'package:flutter_handson_call_web_api/loading_indicator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 日本語対応
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeWidget(),
    );
  }
}

// 日本語対応
class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('hiragana converter'),
      ),
      body: switch (appState) {
        Loading() => const LoadingIndicator(),
        Input() => const InputForm(),
        Data(sentence: final sentence) => ConvertResult(
            sentence: sentence,
          )
      },
    );
  }
}
