import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/style_helpers.dart';
import 'svg_widget.dart';

class ShareButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ShareButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors(context).primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget(
              width: 10,
              height: 10,
              assetPath: IconPaths.icShareGrey,
            ),
            const SizedBox(width: 6),
            Text(
              context.l10n.commonsShareActionInputLabel,
              style: AppFonts(context).titleSmall?.copyWith(
                    color: AppColors(context).onPrimaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
