import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/models/models.dart';
import 'widgets.dart';

class QGenresChipListWidget extends StatelessWidget {
  const QGenresChipListWidget(
    this.genres, {
    this.noScroll = false,
    super.key,
  });

  final List<GenreModel> genres;
  final bool noScroll;

  @override
  Widget build(BuildContext context) {
    if (noScroll) _buildWrap();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Wrap(
          spacing: 4.sp,
          runSpacing: 4.sp,
          clipBehavior: Clip.hardEdge,
          children: genres.map((genre) {
            return QChipWidget(genre.name);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWrap() {
    return Wrap(
      spacing: 4.sp,
      runSpacing: 4.sp,
      clipBehavior: Clip.hardEdge,
      children: genres.map((genre) {
        return QChipWidget(genre.name);
      }).toList(),
    );
  }
}
