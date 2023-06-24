import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/color_schemes.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../generated/locale_keys.g.dart';
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
      collapsedHeight: 58,
      shadowColor: currentColorScheme(context).shadow,
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
                  LocaleKeys.my_tasks.tr(),
                  style: currentTextTheme(context).titleLarge?.copyWith(
                        color: currentColorScheme(context).onBackground,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: LocaleKeys.completed.tr()),
                          TextSpan(
                            text:
                                '${Provider.of<Tasks>(context).getCompletedTaskCount()}',
                          ),
                        ],
                        style: currentTextTheme(context).bodyMedium?.copyWith(
                              color:
                                  currentColorScheme(context).onSurfaceVariant,
                            ),
                      ),
                    ),
                    // Text(
                    //   'Выполнено — ${Provider.of<Tasks>(context).getCompletedTaskCount()}',
                    //   style: currentTextTheme(context).bodyMedium?.copyWith(
                    //         color: currentColorScheme(context).onSurfaceVariant,
                    //       ),
                    // ),
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
