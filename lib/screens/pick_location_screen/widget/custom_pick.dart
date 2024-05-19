/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomPickerDesign extends StatelessWidget {
  final String place;
  final double lat;
  final double lon;
  var formKey = GlobalKey<FormState>();

  CustomPickerDesign(
      {super.key, required this.place, required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickerCubit, PickerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: SizeConfigManger.bodyHeight * .2,
          width: double.infinity,
          color: ColorsManger.blackTranspart,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfigManger.bodyHeight * .04,
                horizontal: SizeConfigManger.bodyHeight * .01),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller:PickerCubit.get(context).title2 ,
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: "Tajawal"
                      ),
                      decoration: InputDecoration(
                        suffixIcon:GestureDetector(
                          onTap: () {
                            if(PickerCubit.get(context).title2.text.isEmpty){
                              showToast(msg: "إسم المخيم مطلوب",color: Colors.redAccent);
                            }else{
                              PickerCubit.get(context).saveLocation(title: place, lat: lat, lon: lon, title2: PickerCubit.get(context).title2.text);
                            }

                          },
                          child: Container(
                            height: SizeConfigManger.bodyHeight * .1,
                            width: SizeConfigManger.screenWidth * .2,
                            decoration: BoxDecoration(
                                color: ColorsManger.darkPrimary,
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(15))),
                            child: Center(
                              child: AppText(
                                text: "حفظ",
                                color: Colors.white,
                                textSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "إسم المخيم",
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight*.02),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/
