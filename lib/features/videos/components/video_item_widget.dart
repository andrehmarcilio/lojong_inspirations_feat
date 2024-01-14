import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../common/components/content_section_widget.dart';
import '../../../common/components/svg_widget.dart';
import '../models/video.dart';

class VideoItemWidget extends StatelessWidget {
  final Video video;

  const VideoItemWidget({
    required this.video,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContentSectionWidget(
      title: video.name,
      imageUrl: video.imageUrl,
      description: video.description,
      foregroundImageIcon: SvgWidget(
        width: 52,
        height: 52,
        assetPath: IconPaths.icPlayWhite,
      ),
    );
  }
}
