import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

class StarDisplay extends StatelessWidget {
  final int value;
  final void Function(int index) onChanged;

  const StarDisplay({Key key, this.value = 0, this.onChanged})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return InkWell(
          onTap: onChanged != null
              ? () {
                  onChanged(value == index + 1 ? index : index + 1);
                }
              : null,
          child: Icon(
            index < value ? Icons.star : Icons.star_border,
            size: xsIcon,
            color: index < value ? teal : null,
          ),
        );
      }),
    );
  }
}
