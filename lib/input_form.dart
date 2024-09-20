import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
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
            onPressed: () {
              // GlobalKey経由でFormウィジットのStateを取得してバリデーションを行う
              final formState = _formKey.currentState!;
              formState.validate();
              debugPrint(_textEditingController.text);
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
