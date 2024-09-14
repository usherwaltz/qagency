import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../business_logic/blocs/blocs.dart';
import '../../business_logic/models/models.dart';
import '../../utils/utils.dart';

class QImageWidget extends StatelessWidget {
  const QImageWidget({
    required this.movie,
    this.fit,
    this.height,
    this.width,
    super.key,
  });

  final MovieModel movie;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final color = context.select<ThemeBloc, Color>((bloc) {
      return bloc.state.palette.getColors(context).text;
    });

    return BlocProvider<MovieBloc>(
      create: (context) => MovieBloc()
        ..add(MoviePosterFetched(
          movieId: movie.id,
          posterPath: movie.posterPath,
        )),
      child: BlocBuilder<MovieBloc, MovieState>(
        buildWhen: (p, c) => p.bytes != c.bytes,
        builder: (context, state) {
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: _buildLoading(),
            secondChild: _buildImage(image: state.bytes, color: color),
            crossFadeState: _getFadeState(state.uiStatus),
          );
        },
      ),
    );
  }

  CrossFadeState _getFadeState(BlocStateUIStatus uiStatus) {
    switch (uiStatus) {
      case BlocStateUIStatus.loaded:
      case BlocStateUIStatus.error:
        return CrossFadeState.showSecond;

      default:
        return CrossFadeState.showFirst;
    }
  }

  Widget _buildImage({
    required Uint8List? image,
    required Color color,
  }) {
    if (image == null) return _buildEmpty(color);

    return Image(
      image: MemoryImage(image),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        return Center(child: child);
      },
      errorBuilder: (context, error, stackTrace) {
        logger.e(
          'Failed to render image',
          error: error,
          stackTrace: stackTrace,
        );
        return _buildEmpty(color);
      },
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        color: Colors.black,
        height: height,
        width: width,
      ),
    );
  }

  Widget _buildEmpty(Color color) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4.sp),
        ),
        child: Icon(
          Icons.image,
          color: color,
        ),
      ),
    );
  }
}
