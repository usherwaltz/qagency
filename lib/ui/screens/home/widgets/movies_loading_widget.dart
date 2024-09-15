import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

/// Utilizes [Shimmer] to show a loading widget
class MoviesLoadingWidget extends StatelessWidget {
  const MoviesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Gap(20.0.sp),
        itemCount: 10,
        itemBuilder: (context, index) => _buildContent(),
      ),
    );
  }

  Widget get _image => _element(100.0, 100.0);
  Widget get _title => _element(20.0, 160.0);
  Widget get _rating => _element(20.0, 100.0);
  Widget get _chip1 => _element(21.0, 69.0);
  Widget get _chip2 => _element(21.0, 59.0);
  Widget get _chip3 => _element(21.0, 50.0);

  Widget _element(double height, double width) {
    return Container(
      height: height.sp,
      width: width.sp,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4.0.sp),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_image, Gap(16.0.sp), _buildTitleAndChips()],
    );
  }

  Widget _buildTitleAndChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title,
        Gap(4.0.sp),
        _rating,
        Gap(12.0.sp),
        _buildChips(),
      ],
    );
  }

  Widget _buildChips() {
    return Row(
      children: [
        _chip1,
        Gap(4.0.sp),
        _chip2,
        Gap(4.0.sp),
        _chip3,
      ],
    );
  }
}
