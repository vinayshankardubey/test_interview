import 'dart:async';
import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:test_interview/Widgets/text_animation.dart';
import 'package:video_player/video_player.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
late String Heading;
late String Content;

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late AnimationController _animController;
  late Animation<Offset> _animOffset;
  late Animation<Offset> _animationSlide;


  late Animation<double> _animationFade;
  int delayAmount = 50;





  List<String> HeadingList = [
    "Welcome One 1",
    "Welcome One 2",
    "Welcome One 3",
  ];


  List<String> ContentList = [
    "Welcome One 1 content ",
    "Welcome One 2 content ",
    "Welcome One 3 content",
  ];










  @override
  void initState() {
    // TODO: implement initState


    _pageController = PageController(viewportFraction: 0.8);

    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/sample.mp4');
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.setVolume(0.0);
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
      });
    });


    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (delayAmount == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: delayAmount), () {
        _animController.forward();
      });
    }


    Heading = HeadingList[0];
    Content = ContentList[0];

  }


  _onPageViewChange(int page) {
    _animController.reverse().then((value){
      Heading = HeadingList[page];
      Content = ContentList[page];
      setState(() {

      });
    }).then((value) {
      _animController.forward();
    });

    setState(() {
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _animController.dispose();


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "https://images.pexels.com/photos/1162983/pexels-photo-1162983.jpg",
      "https://images.pexels.com/photos/10107369/pexels-photo-10107369.jpeg",
      "https://images.pexels.com/photos/4550855/pexels-photo-4550855.jpeg"
    ];




    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, bottom: 15.0),
              child: Text(
                "Make it personal",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Container(
              width: 100.w,
              height: 70.h,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageViewChange,
                  itemCount: images.length,
                  pageSnapping: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {


                      //Working
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        child: AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      );
                    } else {
                      return Container(
                          margin: EdgeInsets.all(10.0),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ));
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child :  ShowUp(
                        child: Text(Heading,style: TextStyle(fontSize: 30),),
                        delay: delayAmount + 200,
                        animController: _animController,
                        animOffset: _animOffset,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child :  ShowUp(
                        animController: _animController,
                        animOffset: _animOffset,
                        child: Text(Content,style: TextStyle(fontSize: 20),),
                        delay: delayAmount + 200,
                      ),
                      ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
