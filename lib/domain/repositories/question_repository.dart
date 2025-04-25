import 'package:have_you_ever_been_like_that/domain/entities/question.dart';

abstract class QuestionRepository {
  Future<Question?> getTodayQuestion();
  Future<void> addQuestion(Question question);
}
