import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/tasks.dart';

class DataFloatingActionButton extends StatelessWidget {
  const DataFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDataState = Provider.of<Tasks>(context).dataStatus;

    return FloatingActionButton(
      heroTag: 'Data synchronization status button',
      onPressed: currentDataState == DataStatus.loading
          ? null
          : () async =>
              Provider.of<Tasks>(context, listen: false).fetchAndSetTasks(),
      child: Icon(
        currentDataState == DataStatus.sync
            ? Icons.cloud_done_outlined
            : currentDataState == DataStatus.unsync
                ? Icons.cloud_off_rounded
                : Icons.cloud_download_outlined,
      ),
    );
  }
}
