import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/text_styles.dart';
import '../../../providers/tasks.dart';
import 'visibility_button.dart';

class MyTasksAppBar extends StatelessWidget {
  const MyTasksAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 164,
      backgroundColor: currentColorScheme(context).background,
      elevation: 3,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 60, top: 14),
        title: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Мои дела',
                  style: currentTextTheme(context).titleLarge?.copyWith(
                        color: currentColorScheme(context).onBackground,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Выполнено — ${Provider.of<Tasks>(context).completedTaskCount}',
                      style: currentTextTheme(context).bodyMedium?.copyWith(
                            color: currentColorScheme(context).onSurfaceVariant,
                          ),
                    ),
                    const VisibilityButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
