import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../common/placeholders/error_placeholder.dart';
import '../../common/placeholders/loading_placeholder.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/service_locator/service_locator.dart';
import 'components/video_item_widget.dart';
import 'models/video.dart';
import 'videos_view_model.dart';
import 'videos_view_states.dart';

class VideosView extends StatefulWidget {
  const VideosView({super.key});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> with AutomaticKeepAliveClientMixin {
  final viewModel = serviceLocator.get<VideosViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadVideos();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
      valueListenable: viewModel.state,
      builder: (context, videoState, _) {
        return switch (videoState) {
          VideosInitial _ || VideosLoading _ => const Center(child: LoadingPlaceholder()),
          VideosSuccess(:final videos) => _VideosSuccessView(videos: videos),
          VideosFailure(:final errorMessage) => _VideosErrorView(
              errorMessage: errorMessage.getMessage(context.l10n),
            ),
        };
      },
    );
  }
}

class _VideosSuccessView extends StatelessWidget {
  final List<Video> videos;

  const _VideosSuccessView({required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      itemCount: videos.length,
      itemBuilder: (_, index) {
        final video = videos[index];
        return VideoItemWidget(video: video);
      },
      separatorBuilder: (_, __) => Divider(
        thickness: .4,
        color: AppColors.grey.withOpacity(0.5),
      ),
    );
  }
}

class _VideosErrorView extends StatelessWidget {
  final String errorMessage;

  const _VideosErrorView({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorPlaceholder(
                  title: context.l10n.commonsDefaultErrorMessageTitle,
                  description: errorMessage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
