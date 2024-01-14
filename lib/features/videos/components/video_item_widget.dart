import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../common/components/share_button.dart';
import '../../../common/components/svg_widget.dart';
import '../../../utils/style_helpers.dart';
import '../models/video.dart';

class VideoItemWidget extends StatelessWidget {
  final Video video;

  const VideoItemWidget({
    required this.video,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Text(
          video.name,
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
                  CachedNetworkImage(imageUrl: video.imageUrl),
                  Center(
                    child: SvgWidget(
                      width: 52,
                      height: 52,
                      assetPath: IconPaths.icPlayWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          video.description,
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
