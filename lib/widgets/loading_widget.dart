
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: AppColors.primary,
      child: SizedBox(height: 150, child: Image.asset(AppAssets.appLogo)),
    ));
  }
}
