import 'package:flutter/cupertino.dart';

import '../resources/colors.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          color: HOME_SCREEN_LIST_TITLE_COLOR,
          fontWeight: FontWeight.bold,
        ));
  }
}
