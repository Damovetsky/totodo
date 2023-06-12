import 'package:flutter/material.dart';

import '../../core/ui/dimentions.dart';
import './widgets/my_tasks_appbar.dart';
import '../../core/ui/color_schemes.dart';
import '../../core/ui/text_styles.dart';
import 'widgets/task_tile.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColorScheme(context).background,
      body: CustomScrollView(
        slivers: [
          const MyTasksAppBar(),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: screenHorizontalMargin,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: currentColorScheme(context).surface,
              clipBehavior: Clip.antiAlias, //???
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) => TaskTile(),
                    shrinkWrap: true,
                  ),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(left: 52, bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Новое',
                      style: currentTextTheme(context).bodyMedium?.copyWith(
                            color: currentColorScheme(context).onSurfaceVariant,
                          ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
