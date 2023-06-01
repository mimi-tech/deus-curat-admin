
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final drawerMenuProvider = StateProvider<bool>((ref) => true);
final screenTypeProvider = StateProvider<String>((ref) => dashboard);
final requestTypeProvider = StateProvider<bool>((ref) => false);
final myChangeNotifierProvider = ChangeNotifierProvider((ref) => MyChangeNotifier());