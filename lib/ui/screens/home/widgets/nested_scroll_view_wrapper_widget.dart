import 'package:flutter/material.dart';

import 'widgets.dart';

class NestedScrollViewWrapperWidget extends StatelessWidget {
  const NestedScrollViewWrapperWidget({
    required this.scrollController,
    required this.child,
    super.key,
  });

  final ScrollController scrollController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [SliverAppBarWidget(scrollController)];
      },
      body: child,
    );
  }
}
