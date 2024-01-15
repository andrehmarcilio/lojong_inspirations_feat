import 'package:flutter/material.dart';

import '../../assets.dart';
import 'svg_widget.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: SvgWidget(
        width: 32,
        height: 32,
        assetPath: IconPaths.icBack,
      ),
    );
  }
}
