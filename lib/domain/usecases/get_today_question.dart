import '../entities/question.dart';
import '../repositories/question_repository.dart';

class GetTodayQuestion {
  final QuestionRepository repository;

  GetTodayQuestion(this.repository);

  Future<Question?> call() {
    return repository.getTodayQuestion();
  }
}
