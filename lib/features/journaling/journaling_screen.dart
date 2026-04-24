import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_snackbar.dart';
import '../../core/widgets/smooth_widgets.dart';

class JournalingScreen extends ConsumerStatefulWidget {
  const JournalingScreen({super.key});

  @override
  ConsumerState<JournalingScreen> createState() => _JournalingScreenState();
}

class _JournalingScreenState extends ConsumerState<JournalingScreen> {
  final _controller = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final session = ref.read(appSessionProvider);
    _controller.text = session.journalSummary;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveNotes() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      final notes = _controller.text.trim();
      ref.read(appSessionProvider.notifier).updateJournalSummary(notes);

      if (mounted) {
        AppSnackBar.showSuccess(
          context,
          title: 'Notes saved',
          message: 'Your journal notes have been updated.',
        );
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(
          context,
          title: 'Save failed',
          message: 'Could not save your notes. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Notes'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveNotes,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Personal Notes',
              style: AppTypography.headingMedium.copyWith(
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Write down your thoughts, feelings, or anything you want to remember. These notes are private and stored locally.',
              style: AppTypography.bodySmall.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SmoothCard(
                backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
                borderColor: const Color(0xFFB7C97B).withOpacity(0.2),
                borderRadius: 16,
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Start writing your thoughts here...',
                    border: InputBorder.none,
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                  ),
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
