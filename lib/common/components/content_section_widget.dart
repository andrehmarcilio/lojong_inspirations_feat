import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/style_helpers.dart';
import 'share_button.dart';

class ContentSectionWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final Widget? foregroundImageIcon;

  const ContentSectionWidget({
    required this.title,
    required this.imageUrl,
    required this.description,
    this.foregroundImageIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: AppFonts(context).titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Material(
          elevation: 1.5,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Center(child: foregroundImageIcon),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: AppFonts(context).bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        const Center(child: ShareButton()),
        const SizedBox(height: 16),
      ],
    );
  }
}
