import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../cores/const/app_colors.dart';
import '../controllers/fixer_map_controller.dart';
import '../controllers/fixer_map_controller_imp.dart';

class FixerMapView extends BaseGetWidget {
  @override
  FixerMapController controller = Get.put(FixerMapControllerImp());

  FixerMapView({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Vị trí thợ sửa",
              style: FontStyleUI.fontPlusJakartaSans(),
            ),
            iconTheme: const IconThemeData(
              color: AppColors.colorTextLogin, // Đặt màu cho icon ở đây
            ),
          ),
          body: Obx(
            () => BaseWidget().baseLoading(
              isLoading: controller.isShowLoading.value,
              widget: _body(),
            ),
          )),
    );
  }

  Widget _body() {
    return GoogleMap(
      markers: Set<Marker>.of(controller.allMarkers),
      onMapCreated: controller.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(controller.latitude.value, controller.longitude.value),
        zoom: 12.0,
      ),
    );
  }
}
