class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: "Learn anytime and anywhere",
      image: 'assets/onboarding_1.png',
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!"),
  OnboardingContent(
      title: 'Find a course for you',
      image: 'assets/onboarding_2.png',
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!"),
  OnboardingContent(
      title: 'Improve your skills',
      image: 'assets/onboarding_3.png',
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!"),
];
