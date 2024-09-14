import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../business_logic/blocs/blocs.dart';
import '../../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../widgets.dart';
import 'widgets/widgets.dart';

class MoviesTabWidget extends StatefulWidget {
  const MoviesTabWidget({super.key});

  @override
  State<MoviesTabWidget> createState() => _MoviesTabWidgetState();
}

class _MoviesTabWidgetState extends State<MoviesTabWidget>
    with AutomaticKeepAliveClientMixin<MoviesTabWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [SliverAppBarWidget(_scrollController)];
        },
        body: BlocSelector<MoviesBloc, MoviesState, BlocStateUIStatus>(
          selector: (state) => state.uiStatus,
          builder: (context, uiStatus) {
            switch (uiStatus) {
              case BlocStateUIStatus.loading:
                return const MoviesLoadingWidget();

              case BlocStateUIStatus.loadingMore:
              case BlocStateUIStatus.loaded:
                return BodyWidget(PrimaryScrollController.of(context));

              case BlocStateUIStatus.error:
                return QErrorWidget(
                  buttonCallback: () => context
                      .read<MoviesBloc>()
                      .add(const MoviesLoaded(refresh: true)),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
