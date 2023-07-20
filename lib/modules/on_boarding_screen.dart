import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/styles/colors.dart';
import '../modules/login_screen.dart';



class BoardingModel{
   String image;
   String title;
   String body;

   BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget {
   const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onboarding-thumb.png',
      title: 'On Boarding Title 1',
      body: 'On Boarding Screen 1'
    ),
    BoardingModel(
        image: 'assets/images/onboarding-thumb.png',
        title: 'On Boarding Title 2',
        body: 'On Boarding Screen 2'
    ),
    BoardingModel(
        image: 'assets/images/onboarding-thumb.png',
        title: 'On Boarding Title 3',
        body: 'On Boarding Screen 3'
    )
  ];
  var boardController = PageController();
  bool isLast = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: (){
                navigateAndFinish(context, const LoginScreen());
              },
              text: 'skip'
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index == boarding.length - 1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    isLast=false;
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) => buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5.0
                    ),
                    count: boarding.length
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        navigateAndFinish(context,  const LoginScreen());
                      }else{
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



Widget buildOnBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset(model.image)),
      const SizedBox(height: 20,),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 10.0,),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 10,
            color: Colors.grey
        ),
      ),
    ],
  );