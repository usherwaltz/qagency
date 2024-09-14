import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../business_logic/repositories/repositories.dart';
import '../../../../../../ui/widgets/widgets.dart';
import '../../../../../../utils/utils.dart';
import '../../widgets.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget(this.scrollController, {super.key});

  final ScrollController scrollController;

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _setupListener();
    super.initState();
  }

  void _setupListener() {
    _scrollController = widget.scrollController;
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (mounted) context.read<MoviesBloc>().add(const MoviesLoaded());
      }
    });
  }

  Future<void> _reloadData() async {
    context.read<MoviesBloc>().add(const MoviesLoaded(refresh: true));
  }

  @override
  Widget build(BuildContext context) {
    final palette =
        context.select<ThemeBloc, QPalette>((bloc) => bloc.state.palette);
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (p, c) => p.movies != c.movies,
      builder: (context, state) {
        final isEnd = state.page == state.totalPages;
        return RefreshIndicator(
          color: palette.text,
          backgroundColor: palette.primary,
          onRefresh: _reloadData,
          child: state.movies.isNotEmpty
              ? ListView.separated(
                  key: PageStorageKey<String>(HomeLayout.movies.name),
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(16.0.sp, 0.0, 16.0.sp, 16.0.sp),
                  itemCount: state.movies.length + (!isEnd ? 1 : 0),
                  separatorBuilder: (context, index) => Gap(20.0.sp),
                  itemBuilder: (context, index) {
                    if (index > state.movies.length - 1 && !isEnd) {
                      return QConnectionWrapperWidget(
                        buildWhenOffline: false,
                        child: Center(
                          child:
                              CircularProgressIndicator(color: palette.primary),
                        ),
                      );
                    }

                    final movie = state.movies[index];
                    final genres = movie.getGenres(state.genres);

                    return MovieListItemWidget(movie: movie, genres: genres);
                  },
                )
              : const QNoDataWidget(),
        );
      },
    );
  }
}
