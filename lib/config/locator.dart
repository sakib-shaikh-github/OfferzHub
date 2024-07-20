import 'package:mappls_gl/mappls_gl.dart';
import 'package:offers_hub/features/share_reward/data/data_repo_impl.dart';
import 'package:offers_hub/features/share_reward/domain/domain_repo_impl.dart';
import 'package:offers_hub/utilis/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeDependencies() async {
  //getit
  getIt.registerSingleton<DomainApiRepoImpl>(DataRepoImpl());

  //Mappls
  MapplsAccountManager.setMapSDKKey('795f57292c9590d8fcc1a00461fc81ac');
  MapplsAccountManager.setRestAPIKey('795f57292c9590d8fcc1a00461fc81ac');
  MapplsAccountManager.setAtlasClientId(
      '96dHZVzsAuu9TvwHWxVBm3KSzM57VQGHEKqY6KtDHCjWQ4bXqWk3gz9YXPkcB4-4-vMVkaVJUixuI3WF-mVY_g==');
  MapplsAccountManager.setAtlasClientSecret(
      'lrFxI-iSEg_LSGkh-imhseFBNmqxWckULKjhA9I9kb4gOM2Uy0whbe1hN97_sE8eiFbgHazMZr5aqbtDZn12n6kgiIfBFYtf');

  //
  gloabal_prefs = await SharedPreferences.getInstance();
}
