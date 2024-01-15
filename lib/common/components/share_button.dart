import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/style_helpers.dart';
import 'svg_widget.dart';

enum ShareButtonStyle {
  standart,
  blue;

  Color getColor(BuildContext context) {
    return switch (this) {
      standart => AppColors(context).primaryContainer,
      blue => const Color.fromRGBO(64, 103, 171, 1),
    };
  }

  Color getFontColor(BuildContext context) {
    return switch (this) {
      standart => AppColors(context).onPrimaryContainer,
      blue => Colors.white,
    };
  }

  String get iconPath {
    return switch (this) {
      standart => IconPaths.icShareGrey,
      blue => IconPaths.icShareWhite,
    };
  }
}

class ShareButton extends StatelessWidget {
  final VoidCallback? onTap;
  final ShareButtonStyle style;

  const ShareButton({
    super.key,
    this.onTap,
    this.style = ShareButtonStyle.standart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: style.getColor(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget(
              width: 10,
              height: 10,
              assetPath: style.iconPath,
            ),
            const SizedBox(width: 6),
            Text(
              context.l10n.commonsShareActionInputLabel,
              style: AppFonts(context).titleSmall?.copyWith(
                    color: style.getFontColor(context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
