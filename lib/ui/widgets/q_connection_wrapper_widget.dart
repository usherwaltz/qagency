import 'package:flutter/material.dart';
import 'package:qagency/l10n/generated/app_localizations.dart';

import '../../utils/utils.dart';

class QConnectionWrapperWidget extends StatelessWidget {
  const QConnectionWrapperWidget({
    required this.child,
    this.buildWhenOffline = true,
    super.key,
  });

  final Widget child;
  final bool buildWhenOffline;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations strings = AppLocalizations.of(context)!;

    return StreamBuilder<bool>(
      stream: ConnectionUtil.instance.connectionStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildError(context, strings);
        } else if ((!snapshot.hasData || !snapshot.data!) && buildWhenOffline) {
          return child;
        } else if ((snapshot.hasData && snapshot.data!) && !buildWhenOffline) {
          return child;
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildError(BuildContext context, AppLocalizations strings) {
    return Center(
      child: Text(
        strings.somethingWentWrong,
        style: context.textTheme.headlineLarge,
      ),
    );
  }
}
