import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/book.dart';

// part 'drive_service.g.dart';

// Mock service for MVP. Real impl requires google_sign_in and googleapis.
class DriveService {
  Future<List<Book>> getBooks() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Book(
        id: '1',
        userId: 'user1',
        title: 'Atomic Habits',
        author: 'James Clear',
        totalPages: 320,
        currentPage: 45,
        progressPercentage: 0.14,
      ),
      const Book(
        id: '2',
        userId: 'user1',
        title: 'Deep Work',
        author: 'Cal Newport',
        totalPages: 300,
        currentPage: 0,
        progressPercentage: 0.0,
      ),
    ];
  }
}

final driveServiceProvider = Provider<DriveService>((ref) {
  return DriveService();
});

final booksProvider = FutureProvider<List<Book>>((ref) async {
  final service = ref.read(driveServiceProvider);
  return service.getBooks();
});
