class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Take care of your plants',
    image: 'img/Intro1.png',
  ),
  OnBoarding(
    title: 'Keep an eye on them',
    image: 'img/Intro2.png',
  ),
  OnBoarding(
    title: 'Water your plants',
    image: 'img/Intro3.png',
  ),

];