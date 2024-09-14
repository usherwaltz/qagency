import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../assets/assets.dart';
import '../../../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class SliverAppBarWidget extends StatefulWidget {
  const SliverAppBarWidget(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  late ScrollController _scrollController;
  double _titleIndent = 16.0.sp;

  @override
  void initState() {
    _setupListener();
    super.initState();
  }

  void _setupListener() {
    _scrollController = widget.scrollController;

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final titleIndent = (16.0.sp + offset).clamp(16.sp, 72.sp);

      setState(() => _titleIndent = titleIndent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      pinned: true,
      title: QSvgWidget(
        assetPath: Assets.logo,
        height: 28.sp,
      ),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.only(
          left: _titleIndent,
          bottom: 16,
          top: 30,
        ),
        title: const HeadlineWidget(),
      ),
      actions: const [ThemeToggleWidget()],
      expandedHeight: kToolbarHeight * 2,
    );
  }
}
