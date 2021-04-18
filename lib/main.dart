import 'package:car_app/bloc/state_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import './models/car.dart';
import 'bloc/state_provider.dart';

void main() {
  runApp(MyApp());
}

int ind = 0;
var currentCar = carList.cars[ind]; //the first car which is the chevorlate here

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //corner debug text gone
      home: MainApp(ind),
    );
  }
}

class MainApp extends StatefulWidget {
  final int ind;
  MainApp(this.ind);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the canvas
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
            margin: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25),
            child: Icon(Icons.favorite_border_outlined),
          )
        ],
      ),

      backgroundColor: Colors.black,
      body: LayoutStarts(),
    );
  }
}

class LayoutStarts extends StatefulWidget {
  @override
  _LayoutStartsState createState() => _LayoutStartsState();
}

class _LayoutStartsState extends State<LayoutStarts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarDetailsAnimations(),
        CustomBottomSheet(),
        NextButton(),
      ],
    );
  }
}

class NextButton extends StatefulWidget {
  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 150,
        child: FlatButton(
          onPressed: () {
            setState(() {
              changeState();
            });
          }, //now do this part yourself where pressing the button you show u a new car
          child: Text(
            "Next Car",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                letterSpacing: 1.4,
                fontFamily: "arial"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
          ),
          color: Colors.black,
          padding: EdgeInsets.all(22.5),
        ),
      ),
    );
  }
}

void changeState() {
  ind++;
  currentCar = carList.cars[ind];
  main();
}

class CarDetailsAnimations extends StatefulWidget {
  @override
  _CarDetailsAnimationsState createState() => _CarDetailsAnimationsState();
}

class _CarDetailsAnimationsState extends State<CarDetailsAnimations>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  AnimationController scaleController;

  Animation fadeAnim;
  Animation scaleAnim;

  @override
  void initState() {
    super.initState();

    fadeController =
        AnimationController(duration: Duration(milliseconds: 180), vsync: this);

    scaleController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this);

    fadeAnim = Tween(begin: 0.0, end: 1.0).animate(fadeController);
    scaleAnim = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));
  }

  forward() {
    scaleController.forward();
    fadeController.forward();
  }

  reverse() {
    scaleController.reverse();
    fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: StateProvider().isAnimating,
        stream: stateBloc.animationStatus,
        builder: (context, snapshot) {
          snapshot.data ? forward() : reverse();
          return ScaleTransition(
            scale: scaleAnim,
            child: FadeTransition(
              opacity: fadeAnim,
              child: CarDetails(),
            ),
          );
        });
  }
}

class CarDetails extends StatefulWidget {
  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            child: _carTitle(),
          ),
          Container(
            width: double.infinity,
            child: CarCarousel(),
          ),
        ],
      ),
    );
  }

  _carTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 38),
                children: [
              TextSpan(text: currentCar.companyName),
              TextSpan(text: '\n'),
              TextSpan(
                text: currentCar.carName,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ])),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 16), children: [
            TextSpan(
              text: currentCar.price.toString(),
              style: TextStyle(color: Colors.grey[20]),
            ),
            TextSpan(
              text: ' / day',
              style: TextStyle(color: Colors.grey),
            ),
          ]),
        ),
      ],
    );
  }
}

class CarCarousel extends StatefulWidget {
  @override
  CarCarouselState createState() => CarCarouselState();
}

class CarCarouselState extends State<CarCarousel> {
  static List<String> imgList = currentCar.imgList;

  void printing() => print(currentCar.imgList);

  final List<Widget> child = _map<Widget>(imgList, (index, String assetName) {
    return Container(
      child: Image.asset("assets/$assetName", fit: BoxFit.fitWidth),
    );
  }).toList();

  static List<T> _map<T>(List list, Function handler) {
    List<T> result = [];

    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0; //this denotes the current position of the slider

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
              items: child,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              )),
          Container(
            margin: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _map<Widget>(imgList, (index, assetName) {
                return Container(
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                      color: _current == index
                          ? Colors.grey[100]
                          : Colors.grey[600]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 400;
  double minSheetTop = 30;

  /*  bool isExpanded = false; */
  Animation<double> animation;

  AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

  forwardAnimation() {
    animController.forward();
    stateBloc.toggleAnimtion();
  }

  reverseAnimation() {
    animController.reverse();
    stateBloc.toggleAnimtion();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          animController.isCompleted ? reverseAnimation() : forwardAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          //upward grag when bottom to top and vice versa
          if (dragEndDetails.primaryVelocity < 0.0) {
            animController.forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            animController.reverse();
          } else {
            return;
          }
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Color(0xFFC8C6C6)),
      child: Column(
        children: <Widget>[
          drawerHandle(),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                offerDetails(sheetItemHeight),
                features(sheetItemHeight),
                specs(sheetItemHeight),
                SizedBox(
                  height: 220,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

drawerHandle() {
  return Container(
    margin: EdgeInsets.only(bottom: 25),
    height: 3,
    width: 65,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
  );
}

specs(double sheetItemHeight) {
  return Container(
    padding: EdgeInsets.only(top: 15, left: 12.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Specifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.specs.length,
            itemBuilder: (context, index) {
              return ListItem(
                sheetItemHeight: sheetItemHeight,
                mapVal: currentCar.specs[index],
              );
            },
          ),
        ),
      ],
    ),
  );
}

features(double sheetItemHeight) {
  return Container(
    padding: EdgeInsets.only(top: 15, left: 12.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Features',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.features.length,
            itemBuilder: (context, index) {
              return ListItem(
                sheetItemHeight: sheetItemHeight,
                mapVal: currentCar.features[index],
              );
            },
          ),
        ),
      ],
    ),
  );
}

offerDetails(double sheetItemHeight) {
  return Container(
    padding: EdgeInsets.only(top: 15, left: 12.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Offer Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.offerDetails.length,
            itemBuilder: (context, index) {
              return ListItem(
                sheetItemHeight: sheetItemHeight,
                mapVal: currentCar.offerDetails[index],
              );
            },
          ),
        ),
      ],
    ),
  );
}

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  ListItem({this.mapVal, this.sheetItemHeight});

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      isMap = true;
      innerMap = mapVal.values.elementAt(0);
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: EdgeInsets.only(right: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          mapVal.keys.elementAt(0),
          isMap
              ? Text(
                  innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                )
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
