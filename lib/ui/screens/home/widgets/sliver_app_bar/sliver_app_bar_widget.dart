import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qagency/utils/utils.dart';

import '../../../../../assets/assets.dart';
import '../../../../../business_logic/blocs/blocs.dart';
import '../../../../../business_logic/repositories/repositories.dart';
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
    final palette = context.select<ThemeBloc, ColorPalette>((bloc) {
      return bloc.state.palette.getColors(context);
    });
    return SliverAppBar(
      automaticallyImplyLeading: true,
      pinned: true,
      centerTitle: false,
      title: QSvgWidget(
        assetPath: Assets.logo,
        height: 28.sp,
        color: palette.primary,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
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
