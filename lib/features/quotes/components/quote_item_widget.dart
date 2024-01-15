import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../common/components/share_button.dart';
import '../../../common/components/svg_widget.dart';
import '../../../utils/style_helpers.dart';
import '../models/quote.dart';

class QuoteItemWidget extends StatelessWidget {
  final int index;
  final Quote quote;

  const QuoteItemWidget({
    required this.quote,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(179, 210, 234, 1),
            Color.fromRGBO(240, 244, 247, 1),
          ],
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
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            top: null,
            child: Opacity(
              opacity: .4,
              child: SvgWidget(
                assetPath: ImagePaths.mountains,
                boxFit: BoxFit.cover,
              ),
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
                              color: const Color.fromRGBO(68, 109, 175, 1),
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
                          color: const Color.fromRGBO(68, 109, 175, 1),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Center(
                      child: ShareButton(
                    style: ShareButtonStyle.blue,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
