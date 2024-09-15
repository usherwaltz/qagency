import 'package:flutter/material.dart';

import '../../../../business_logic/models/models.dart';
import '../../../widgets/widgets.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({required this.movie, required this.maxHeight, super.key});

  final MovieModel movie;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        QImageWidget(
          movie: movie,
          width: mediaQuery.size.width,
        ),
        Container(
          height: mediaQuery.size.height * (1.0 - maxHeight),
          width: mediaQuery.size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black45, Colors.black12, Colors.transparent],
              stops: [0, 0.7, 1.0],
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
