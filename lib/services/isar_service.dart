import 'package:path_provider/path_provider.dart';

// Note: Isar requires code generation. run 'flutter pub run build_runner build' to generate the .g.dart files once schemas are defined.
// import 'package:isar/isar.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  // late Isar isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    
    // isar = await Isar.open(
    //   [
    //     // Add schemas here later: HabitSchema, FocusSessionSchema, etc.
    //   ],
    //   directory: dir.path,
    // );
  }
}
