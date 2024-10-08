import 'package:flutter/material.dart';
import 'package:flutter_handson_call_web_api/app_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputForm extends ConsumerStatefulWidget {
  const InputForm({super.key});

  @override
  ConsumerState<InputForm> createState() => _InputFormState();
}

class _InputFormState extends ConsumerState<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController(); // 入力文字を保持する

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: '文章を入力してください'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '文字列が入力されていません';
                } else {
                  return null;
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // GlobalKey経由でFormウィジットのStateを取得してバリデーションを行う
              final formState = _formKey.currentState!;
              if (!formState.validate()) {
                return;
              }
              final sentence = _textEditingController.text;
              await ref.read(appNotifierProvider.notifier).convert(sentence);
            },
            child: const Text('変換'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 不要になったらメモリを解放する(Stateful Widgetの破棄時に破棄される)
    _textEditingController.dispose();
    super.dispose();
  }
}
