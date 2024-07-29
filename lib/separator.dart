import 'package:flutter/material.dart';

extension WidgetIterableExtension on Iterable<Widget> {
  Iterable<Widget> separator(Widget separator) => expand((item) sync* {
        yield separator;
        yield item;
      }).skip(1);
}
