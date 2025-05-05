import 'package:car_rental/features/cars/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/Colors.dart';

class CarInfo extends StatefulWidget {
  final Cars car;
  const CarInfo({super.key, required this.car});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorsConst.Kcbg,
                image: DecorationImage(
                  image: AssetImage("assets/cars.png"),
                  scale: .5,
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.car.name,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color(0xff181c1e),
                  ),
                ),
                Text(
                  "\$${widget.car.pricePerDay}/day",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff384147),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(color: Color(0xffe8ebec),
                    borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Transition",
                          style: TextStyle(
                            color: Color(0xff87a6b3),
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "${widget.car.transition}",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(color: Color(0xffe8ebec),borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Speed",
                          style: TextStyle(
                            color: Color(0xff87a6b3),
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "\$${widget.car.pricePerDay} /day",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: ColorsConst.Kcbg,
                  child: Icon(FontAwesomeIcons.person,size: 100,),
                  radius: 60,
                ),
                SizedBox(width: 100,),
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(color: Color(0xffe8ebec),borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Omar",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 25,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              },
                            child: Icon(FontAwesomeIcons.phone,size: 30,)),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // اضف الوظيفة هنا لو حابب
                },
                child: Container(
                  //width: double.infinity,
                  child: Image.asset(
                    "assets/mapy.png",

                  ),
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}
