import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../common/components/share_button.dart';
import '../../../common/components/svg_widget.dart';
import '../../../utils/style_helpers.dart';
import '../models/quote.dart';

class QuoteItemWidget extends StatelessWidget {
  final Quote quote;
  final QuoteItemStyle style;

  const QuoteItemWidget({
    required this.quote,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: MediaQuery.sizeOf(context).height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: style.gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Stack(
              alignment: style.imageAlignment,
              children: [
                Opacity(
                  opacity: .4,
                  child: SvgWidget(
                    width: constraints.maxWidth,
                    assetPath: style.backgroundImagePath,
                    boxFit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              quote.text,
                              style: AppFonts(context).bodyLarge?.copyWith(
                                    color: style.textColor,
                                    fontSize: 18,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          quote.author,
                          style: AppFonts(context).labelMedium?.copyWith(
                                color: style.textColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: ShareButton(
                            style: style.shareButtonStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum QuoteItemStyle {
  blue,
  amber;

  List<Color> get gradientColors {
    return switch (this) {
      blue => [
          const Color.fromRGBO(179, 210, 234, 1),
          const Color.fromRGBO(240, 244, 247, 1),
        ],
      amber => [
          const Color.fromARGB(255, 226, 216, 187),
          const Color.fromRGBO(243, 176, 147, 1),
        ],
    };
  }

  Color get textColor {
    return switch (this) {
      blue => const Color.fromRGBO(68, 109, 175, 1),
      amber => Colors.black.withOpacity(.5),
    };
  }

  String get backgroundImagePath {
    return switch (this) {
      blue => ImagePaths.mountains,
      amber => ImagePaths.lotus,
    };
  }

  Alignment get imageAlignment {
    return switch (this) {
      blue => Alignment.bottomCenter,
      amber => Alignment.center,
    };
  }

  ShareButtonStyle get shareButtonStyle {
    return switch (this) {
      blue => ShareButtonStyle.blue,
      amber => ShareButtonStyle.amber,
    };
  }
}
