
import 'package:flutter/material.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

class WalktroughsViews extends BaseGetWidget {
  const WalktroughsViews({super.key});

  @override
  Widget buildWidgets(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Text("Bỏ qua", style: FontStyleUI.fontPlusJakartaSans(),)
        ],
      ),
    );
  }

}