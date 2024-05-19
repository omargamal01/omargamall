import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/main_layout/cubit/main_cubit.dart';
import 'package:airplane/main_layout/main_layout.dart';
import 'package:airplane/models/notification_model.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .04),
              const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: AppText(text: "Notification List")),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 2.5,
                margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .04),
              ),
              Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          NotificationItem(
                              model: MainCubit.get(context).notificationList[index]),
                      separatorBuilder: (context, index) =>
                          Container(
                            color: Colors.grey.withOpacity(0.5),
                            width: double.infinity,
                            height: 2.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * .04),
                          ),
                      itemCount:  MainCubit.get(context).notificationList.length))
            ],
          ),
        );
      },
    );
  }
}
