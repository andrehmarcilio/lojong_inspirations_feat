import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/style_helpers.dart';
import 'my_app_bar.dart';

class TabBarTemplate extends StatelessWidget {
  final String title;
  final List<Widget> tabViews;
  final List<String> tabLabels;

  const TabBarTemplate({
    required this.title,
    required this.tabViews,
    required this.tabLabels,
    super.key,
  }) : assert(tabViews.length == tabLabels.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors(context).primary,
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Column(
            children: [
              MyAppBar(title: title),
              SizedBox(
                height: 40,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.11),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.center,
                    tabs: tabLabels.map((label) {
                      return Tab(
                        child: Container(
                          width: 90,
                          alignment: Alignment.center,
                          child: AutoSizeText(label, maxLines: 1, minFontSize: 8),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors(context).background),
                    child: TabBarView(children: tabViews),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
