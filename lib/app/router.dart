import 'package:flutter/material.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/views/careers/views/careers_detail_view.dart';
import 'package:powerhouse/ui/views/home/views/about_view.dart';
import 'package:powerhouse/ui/views/home/views/edit_profile_view.dart';
import 'package:powerhouse/ui/views/home/views/settings_view.dart';
import 'package:powerhouse/ui/views/journal/views/journal_detail_view.dart';
import 'package:powerhouse/ui/views/main/views/main_view.dart';
import 'package:powerhouse/ui/views/media_view/views/media_detail_view.dart';
import 'package:powerhouse/ui/views/media_view/views/video_view.dart';
import 'package:powerhouse/ui/views/onboarding/views/onboarding_view.dart';
import 'package:powerhouse/ui/views/onboarding/views/splash_view.dart';

class Routes {
  static const splashView = '/';
  static const onboardingView = '/onboarding-view';
  static const mainView = '/main-view';
  static const settingsView = '/settings-view';
  static const mediaDetailView = '/media-detail-view';
  static const videoMediaDetailView = '/video-media-detail-view';
  static const journalDetailView = '/journal-detail-view';
  static const videoFullScreenView = '/video-full-screen-view';
  static const careerDetailView = '/career-detail-view';
  static const aboutView = '/about-view';
  static const editProfileView = '/edit-profile-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingView:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.mainView:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.settingsView:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.mediaDetailView:
        final data = settings.arguments as MediaModel;
        return MaterialPageRoute(builder: (_) => MediaDetailView(medium: data));
      case Routes.videoMediaDetailView:
        final data = settings.arguments as MediaModel;
        return MaterialPageRoute(builder: (_) => VideoView(medium: data));
      case Routes.journalDetailView:
        final data = settings.arguments as JournalModel;
        return MaterialPageRoute(
            builder: (_) => JournalDetailView(journal: data));
      case Routes.videoFullScreenView:
        return MaterialPageRoute(builder: (_) => const VideoFullScreenView());
      case Routes.careerDetailView:
        final data = settings.arguments as CareerModel;
        return MaterialPageRoute(
            builder: (_) => CareerDetailView(career: data));
      case Routes.aboutView:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case Routes.editProfileView:
        return MaterialPageRoute(builder: (_) => const EditProfileView());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text('This Route does not exist'),
      ),
    );
  }
}
