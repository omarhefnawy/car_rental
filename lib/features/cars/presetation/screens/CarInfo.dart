import 'package:car_rental/core/payment_service/payment_service.dart';
import 'package:car_rental/features/cars/data/models/car_model.dart';
import 'package:car_rental/features/maps/presentation/screens/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/Colors.dart';

class CarInfo extends StatefulWidget {
  final Cars car;
  const CarInfo({super.key, required this.car});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  Future<void> _pay() async{
    PaymentIntegration().getPaymentKey(amount: widget.car.pricePerDay.toInt(), currency: "EGP").then((String paymentKey){
      launchUrl(
          Uri.parse("https://accept.paymob.com/api/acceptance/iframes/921059?payment_token=${paymentKey}")
      );
    }).catchError((onError){
      throw Exception("Error getting the iframe from paymob${onError.toString()}");
    });

  }
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
                image:DecorationImage(image: NetworkImage(widget.car.img,scale: .5)) ,
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
                  "EGP ${widget.car.pricePerDay}/day",
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
                    height: 145,
                    decoration: BoxDecoration(color: Color(0xffe8ebec),borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.car.owner.name}",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 25,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              // إضافة رمز الدولة '20' لمصر
                              final phoneNumber = "20${widget.car.owner.phone}"; // الرقم مع رمز الدولة

                              final url = "https://wa.me/$phoneNumber"; // بناء الرابط مع الرقم الصحيح

                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); // فتح الواتساب
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Could not open WhatsApp")), // في حال حدوث خطأ
                                );
                              }
                            },

                            child: Icon(FontAwesomeIcons.phone,size: 30,)),
                        IconButton(
                            onPressed: () async {
                                await  _pay();
                        }, icon: Icon(FontAwesomeIcons.moneyCheck,size: 30,color: Colors.deepPurple,)),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // اضف الوظيفة هنا لو حابب
                 Navigator.push(context, MaterialPageRoute(builder:(context) =>  MapScreen(car: widget.car,)));
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
