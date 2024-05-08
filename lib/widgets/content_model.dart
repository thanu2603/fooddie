class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: "Pick your food from our menu\n    More than 35 times",
      image: "images/screen1.png",
      title: "Select from our\n     Best Menu"),
  UnboardingContent(
      description: "You can pay by Wallet or\n    On Cash on Delivery",
      image: "images/screen2.png",
      title: "Easy and Online Payment"),
  UnboardingContent(
      description: "Deliver your Food at your Doorsteps",
      image: "images/screen3.png",
      title: "Quick Delivery")
];
