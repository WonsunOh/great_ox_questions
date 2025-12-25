import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/models.dart';
import '../../../providers/question_providers.dart';
import '../../../router/route_paths.dart';
import '../../quiz/viewmodel/quiz_viewmodel.dart';

/// 결과 화면 - 퀴즈 결과 확인
class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizViewModelProvider);
    final viewModel = ref.read(quizViewModelProvider.notifier);
    final selectedSet = ref.watch(selectedQuestionSetProvider);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            final maxWidth = isWide ? 600.0 : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: CustomScrollView(
                  slivers: [
                    // 결과 헤더
                    SliverToBoxAdapter(
                      child: _buildResultHeader(context, quizState, selectedSet),
                    ),

                    // 통계
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverToBoxAdapter(
                        child: _buildStatistics(context, quizState),
                      ),
                    ),

                    // 오답 목록
                    if (quizState.incorrectQuestions.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverToBoxAdapter(
                          child: _buildIncorrectSection(context, quizState),
                        ),
                      ),

                    // 액션 버튼
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverToBoxAdapter(
                        child: _buildActionButtons(context, viewModel, quizState),
                      ),
                    ),

                    // 하단 여백
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 32),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResultHeader(
    BuildContext context,
    QuizState quizState,
    QuestionSet? selectedSet,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final correctRate = quizState.correctRate;

    // 성적에 따른 설정
    final (String emoji, String message, Color color) = switch (correctRate) {
      >= 90 => ('🏆', '훌륭합니다!', Colors.amber.shade700),
      >= 70 => ('👍', '잘했습니다!', Colors.green),
      >= 50 => ('💪', '조금 더 노력해보세요', Colors.orange),
      _ => ('📚', '다시 도전해보세요', Colors.red),
    };

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.85),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          children: [
            // 과목 정보
            if (selectedSet != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${selectedSet.subjectInfo.subjectName} - ${selectedSet.subjectInfo.chapterMinor}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // 이모지
            Text(
              emoji,
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 16),

            // 메시지
            Text(
              message,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // 정답률 원형 프로그레스
            SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: correctRate / 100,
                      strokeWidth: 12,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${correctRate.toStringAsFixed(0)}%',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '정답률',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, QuizState quizState) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.quiz_outlined,
            label: '전체',
            value: quizState.totalQuestions,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.check_circle_outline,
            label: '정답',
            value: quizState.correctCount,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.cancel_outlined,
            label: '오답',
            value: quizState.incorrectCount,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            '$value',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncorrectSection(BuildContext context, QuizState quizState) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 헤더
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 24),
              const SizedBox(width: 12),
              Text(
                '오답 노트',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${quizState.incorrectCount}문제',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 오답 목록
        ...quizState.incorrectQuestions.asMap().entries.map(
              (entry) => _buildIncorrectCard(context, entry.key + 1, entry.value),
            ),
      ],
    );
  }

  Widget _buildIncorrectCard(
    BuildContext context,
    int number,
    Question question,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                question.answer,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          title: Text(
            question.question,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 해설 라벨
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '해설',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 해설 내용
                  Text(
                    question.explanation,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  // 정정문
                  if (question.correction != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.edit_note, size: 18, color: Colors.blue),
                          const SizedBox(width: 10),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    QuizViewModel viewModel,
    QuizState quizState,
  ) {

    return Column(
      children: [
        // 홈으로
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: () {
              viewModel.resetQuiz();
              context.go(RoutePaths.home);
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined),
                SizedBox(width: 8),
                Text(
                  '홈으로',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 전체 다시 풀기
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              viewModel.restartQuiz();
              context.go(RoutePaths.quiz);
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh),
                SizedBox(width: 8),
                Text(
                  '전체 다시 풀기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        // 오답만 다시 풀기
        if (quizState.incorrectQuestions.isNotEmpty) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                viewModel.retryIncorrectOnly();
                context.go(RoutePaths.quiz);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.replay),
                  const SizedBox(width: 8),
                  Text(
                    '오답만 다시 풀기 (${quizState.incorrectCount}문제)',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
