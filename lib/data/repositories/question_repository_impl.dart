import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/question_firestore_datasource.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionFirestoreDatasource datasource;

  QuestionRepositoryImpl(this.datasource);

  @override
  Future<Question?> getTodayQuestion() {
    return datasource.getTodayQuestion();
  }

  @override
  Future<void> addQuestion(Question question) {
    return datasource.addQuestion(question);
  }
}
