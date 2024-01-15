import 'package:flutter/material.dart';

import '../../utils/extensions/context_extensions.dart';
import '../../utils/style_helpers.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTryAgainPressed;

  const ErrorPlaceholder({
    required this.title,
    required this.description,
    this.onTryAgainPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 252),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppFonts(context).titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: AppFonts(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onTryAgainPressed != null) ...[
              const SizedBox(height: 14),
              GestureDetector(
                onTap: onTryAgainPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors(context).primaryContainer,
                  ),
                  child: Text(
                    context.l10n.commonsTryAgainActionInputLabel,
                    style: AppFonts(context).titleSmall,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
