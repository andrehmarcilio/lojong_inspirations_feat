import 'package:flutter/material.dart';

import '../../utils/mixins/test_mixin.dart';

class LoadingPlaceholder extends StatelessWidget with TestMixin {
  const LoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: isTesting ? 0 : null,
    );
  }
}
