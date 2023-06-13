import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/tasks.dart';

class VisibilityButton extends StatefulWidget {
  const VisibilityButton({
    super.key,
  });

  @override
  State<VisibilityButton> createState() => _VisibilityButtonState();
}

class _VisibilityButtonState extends State<VisibilityButton> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: SizedBox(
        height: 24,
        width: 24,
        child: IconButton(
          onPressed: () {
            Provider.of<Tasks>(context, listen: false)
                .toggleCompletedTasksVisibility();
            setState(() {
              visibility = !visibility;
            });
          },
          splashRadius: 12,
          padding: EdgeInsets.zero,
          icon: Icon(
            visibility
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
