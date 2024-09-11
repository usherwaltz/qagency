import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../utils/utils.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<MoviesBloc>().add(const MoviesLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: BlocSelector<MoviesBloc, MoviesState, BlocStateUIStatus>(
        selector: (state) => state.uiStatus,
        builder: (context, uiStatus) {
          switch (uiStatus) {
            case BlocStateUIStatus.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );

            case BlocStateUIStatus.loadingMore:
            case BlocStateUIStatus.loaded:
              return const BodyWidget();

            case BlocStateUIStatus.error:
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
