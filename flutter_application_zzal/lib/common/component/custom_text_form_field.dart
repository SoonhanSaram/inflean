import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/colors.dart';

class CustomTextFoamField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFoamField(
      {required this.onChanged,
      this.obscureText = false,
      this.autofocus = false,
      this.hintText,
      this.errorText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,

      // 비밀번호 입력할 때 사용
      obscureText: obscureText,
      // 화면에 들어왔을 때, 바로 focus 를 둘꺼냐
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
          fillColor: INPUT_BG_COLOR,

          // false - 배경색 없음, true - 배경색 쌓음
          filled: true,
          errorText: errorText,
          // 모든 Input 생태의 기본 스타일 세팅
          border: baseBorder,
          enabledBorder: baseBorder.copyWith(),
          focusedBorder: baseBorder.copyWith(
              borderSide:
                  baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
    );
  }
}
