import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../business_logic/blocs/blocs.dart';
import '../../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../widgets.dart';
import 'widgets/widgets.dart';

class FavouritesTabWidget extends StatefulWidget {
  const FavouritesTabWidget({super.key});

  @override
  State<FavouritesTabWidget> createState() => _FavouritesTabWidgetState();
}

class _FavouritesTabWidgetState extends State<FavouritesTabWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<FavouritesBloc>().add(const FavouritesLoaded());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollViewWrapperWidget(
        scrollController: _scrollController,
        child: BlocSelector<FavouritesBloc, FavouritesState, BlocStateUIStatus>(
          selector: (state) => state.uiStatus,
          builder: (context, uiStatus) {
            switch (uiStatus) {
              case BlocStateUIStatus.loading:
                return const MoviesLoadingWidget();

              case BlocStateUIStatus.loadingMore:
              case BlocStateUIStatus.loaded:
                return const BodyWidget();

              case BlocStateUIStatus.error:
                return const QErrorWidget();

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
