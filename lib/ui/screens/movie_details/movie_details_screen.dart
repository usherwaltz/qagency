import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../assets/assets.dart';
import '../../../business_logic/blocs/blocs.dart';
import '../../../business_logic/models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen(this.movie, {super.key});

  final MovieModel movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  final double _initialChildSize = 0.6134;
  late double _maxChildSize;
  late MediaQueryData _mediaQuery;
  late List<GenreModel> _genres;

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);
    _computeMaxSize();
    _getGenres();
    super.didChangeDependencies();
  }

  void _computeMaxSize() {
    final screenHeight = _mediaQuery.size.height;
    final height = screenHeight - _mediaQuery.viewPadding.top - kToolbarHeight;
    _maxChildSize = height / screenHeight;
  }

  void _getGenres() => _genres = context.read<MoviesBloc>().state.genres;

  EdgeInsets get _contentPadding {
    return EdgeInsets.fromLTRB(16.0.sp, 28.sp, 16.sp, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildHeaderImage(),
        _buildBackButton(),
        _buildDragSheet(),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Positioned(
      top: 0,
      child: ImageWidget(
        movie: widget.movie,
        maxHeight: _maxChildSize,
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: kToolbarHeight.sp - 24.sp,
      left: 16.sp,
      child: IconButton(
        onPressed: () => context.pop(),
        icon: QSvgWidget(
          assetPath: Assets.back,
          width: 24.sp,
        ),
      ),
    );
  }

  Widget _buildDragSheet() {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        controller: _controller,
        key: _sheet,
        initialChildSize: _initialChildSize,
        maxChildSize: _maxChildSize,
        minChildSize: _initialChildSize,
        expand: true,
        snap: true,
        builder: (context, controller) {
          return _buildDecoration(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: _contentPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadlineWidget(widget.movie),
                        Gap(16.sp),
                        QGenresChipListWidget(
                          widget.movie.getGenres(_genres),
                        ),
                        Gap(40.sp),
                        DescriptionWidget(widget.movie.overview),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDecoration({required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      child: child,
    );
  }
}
