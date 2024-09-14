import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/blocs/blocs.dart';
import '../../../utils/utils.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _setupPageController();

    _loadData();
    super.initState();
  }

  void _loadData() {
    context.read<MoviesBloc>().add(const MoviesLoaded(refresh: true));
    context.read<FavouritesBloc>().add(const FavouritesLoaded());
  }

  void _setupPageController() {
    final initialLayout = context.read<HomeLayoutBloc>().state.layout;
    _pageController = PageController(
      initialPage: HomeLayout.values.indexOf(initialLayout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: BlocListener<HomeLayoutBloc, HomeLayoutState>(
        listenWhen: (p, c) => p.layout != c.layout,
        listener: (context, state) {
          _pageController.jumpToPage(
            HomeLayout.values.indexOf(state.layout),
          );
        },
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: HomeLayout.values.length,
          itemBuilder: (context, index) => _getContent(index),
        ),
      ),
    );
  }

  Widget _getContent(int index) {
    final layout = HomeLayout.values[index];

    switch (layout) {
      case HomeLayout.favourites:
        return const FavouritesTabWidget();

      default:
        return const MoviesTabWidget();
    }
  }
}
