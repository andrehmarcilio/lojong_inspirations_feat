import 'package:flutter/widgets.dart';

import '../../utils/style_helpers.dart';
import 'my_back_button.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: MyBackButton(),
            ),
          ),
          Text(
            title,
            style: AppFonts(context).titleSmall?.copyWith(
                  color: AppColors(context).onPrimary,
                ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
