import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/models.dart';
import '../../../providers/question_providers.dart';
import '../../../router/route_paths.dart';
import '../viewmodel/quiz_viewmodel.dart';

/// 퀴즈 화면 - O/X 문제 풀이
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizViewModelProvider);
    final viewModel = ref.read(quizViewModelProvider.notifier);

    // 퀴즈가 시작되지 않았으면 홈으로 리다이렉트
    if (quizState.status == QuizStatus.initial || quizState.questions.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(RoutePaths.home);
        }
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 퀴즈 완료 시 결과 화면으로 이동
    ref.listen(quizViewModelProvider, (previous, next) {
      if (next.status == QuizStatus.completed) {
        context.go(RoutePaths.result);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('문제 ${quizState.currentIndex + 1} / ${quizState.totalQuestions}'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitDialog(context, viewModel),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: quizState.progress,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
      ),
      body: quizState.currentQuestion == null
          ? const Center(child: CircularProgressIndicator())
          : _buildQuizContent(context, quizState, viewModel),
    );
  }

  Widget _buildQuizContent(
    BuildContext context,
    QuizState quizState,
    QuizViewModel viewModel,
  ) {
    final question = quizState.currentQuestion!;
    final theme = Theme.of(context);

    return Column(
      children: [
        // 문제 영역
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 중요도 표시
                _buildImportanceBadge(question.importance),
                const SizedBox(height: 16),

                // 문제 텍스트
                Text(
                  question.question,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),

                // 태그 표시
                if (question.tags.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: question.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ],

                // 피드백 영역
                if (quizState.showingFeedback) ...[
                  const SizedBox(height: 32),
                  _buildFeedback(context, quizState, question),
                ],
              ],
            ),
          ),
        ),

        // O/X 버튼 영역
        _buildAnswerButtons(context, quizState, viewModel),
      ],
    );
  }

  Widget _buildImportanceBadge(int importance) {
    final color = importance >= 4 ? Colors.red : Colors.orange;
    return Row(
      children: [
        Icon(Icons.star, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '중요도 $importance',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFeedback(
    BuildContext context,
    QuizState quizState,
    Question question,
  ) {
    final isCorrect = quizState.lastAnswerCorrect ?? false;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 정답/오답 표시
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? '정답입니다!' : '오답입니다',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 정답 표시
          Text(
            '정답: ${question.answer}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // 해설
          Text(
            question.explanation,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),

          // 정정 내용 (오답인 경우)
          if (question.correction != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.edit, size: 18, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      question.correction!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnswerButtons(
    BuildContext context,
    QuizState quizState,
    QuizViewModel viewModel,
  ) {
    final showingFeedback = quizState.showingFeedback;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: showingFeedback
            ? _buildNextButton(viewModel, quizState.isLastQuestion)
            : _buildOXButtons(viewModel),
      ),
    );
  }

  Widget _buildOXButtons(QuizViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: FilledButton(
              onPressed: () => viewModel.submitAnswer(true),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(
                  'O',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 64,
            child: FilledButton(
              onPressed: () => viewModel.submitAnswer(false),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(QuizViewModel viewModel, bool isLastQuestion) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: viewModel.nextQuestion,
        icon: Icon(isLastQuestion ? Icons.check : Icons.arrow_forward),
        label: Text(
          isLastQuestion ? '결과 확인' : '다음 문제',
          style: const TextStyle(fontSize: 18),
        ),
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context, QuizViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('퀴즈 종료'),
        content: const Text('퀴즈를 종료하시겠습니까?\n진행 상황이 저장되지 않습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('계속하기'),
          ),
          TextButton(
            onPressed: () {
              viewModel.resetQuiz();
              Navigator.pop(context);
              context.go(RoutePaths.home);
            },
            child: const Text('종료'),
          ),
        ],
      ),
    );
  }
}
