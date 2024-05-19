import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/models/notification_model.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {},
      key: UniqueKey(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightDark, width: 2)),
                  child: const Icon(Icons.notifications,size: 50,color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: model.title.toString(),
                        maxLines: 2,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      AppText(
                        text: model.body.toString(),
                        maxLines: 2,
                        textSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: AppText(
                          text: model.time.toString(),
                          maxLines: 1,
                          textSize: 12,
                          color: AppColors.iconGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
