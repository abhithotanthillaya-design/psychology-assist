import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/app_session_store.dart';

const demoPsychologistEmail = 'panipuri@macxcode';

enum UserRole { psychologist, patient }

class AppProfile {
  final UserRole role;
  final String name;
  final DateTime? dateOfBirth;
  final String? email;
  final String? psychologistEmail;

  const AppProfile({
    required this.role,
    required this.name,
    this.dateOfBirth,
    this.email,
    this.psychologistEmail,
  });

  bool get hasPsychologist =>
      psychologistEmail != null && psychologistEmail!.trim().isNotEmpty;
}

class Appointment {
  final String psychologistEmail;
  final DateTime startsAt;
  final String type;
  final String note;

  const Appointment({
    required this.psychologistEmail,
    required this.startsAt,
    required this.type,
    required this.note,
  });
}

class AppSession {
  final bool onboardingComplete;
  final bool appLockSet;
  final String? lockPin;
  final AppProfile? profile;
  final List<Appointment> appointments;
  final bool isLocked;

  const AppSession({
    this.onboardingComplete = false,
    this.appLockSet = false,
    this.lockPin,
    this.profile,
    this.appointments = const [],
    this.isLocked = false,
  });

  AppSession copyWith({
    bool? onboardingComplete,
    bool? appLockSet,
    String? lockPin,
    AppProfile? profile,
    List<Appointment>? appointments,
    bool? isLocked,
  }) {
    return AppSession(
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      appLockSet: appLockSet ?? this.appLockSet,
      lockPin: lockPin ?? this.lockPin,
      profile: profile ?? this.profile,
      appointments: appointments ?? this.appointments,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

final initialAppSessionProvider = Provider<AppSession>(
  (ref) => const AppSession(),
);

final appSessionStoreProvider = Provider<AppSessionStore>(
  (ref) => AppSessionStore(),
);

final appSessionProvider =
    StateNotifierProvider<AppSessionNotifier, AppSession>(
  (ref) => AppSessionNotifier(
    initialSession: ref.watch(initialAppSessionProvider),
    store: ref.watch(appSessionStoreProvider),
  ),
);

class AppSessionNotifier extends StateNotifier<AppSession> {
  final AppSessionStore _store;

  AppSessionNotifier({
    required AppSession initialSession,
    required AppSessionStore store,
  })  : _store = store,
        super(initialSession);

  void completeOnboarding({
    required AppProfile profile,
    required String lockPin,
  }) {
    state = state.copyWith(
      onboardingComplete: true,
      appLockSet: true,
      lockPin: lockPin,
      profile: profile,
      isLocked: false,
    );
    _persist();
  }

  void addAppointment(Appointment appointment) {
    final updated = [...state.appointments, appointment]
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    state = state.copyWith(appointments: updated);
    _persist();
  }

  void lock() {
    if (state.onboardingComplete && state.appLockSet && !state.isLocked) {
      state = state.copyWith(isLocked: true);
    }
  }

  bool unlock(String pin) {
    if (pin.trim() == state.lockPin) {
      state = state.copyWith(isLocked: false);
      return true;
    }
    return false;
  }

  Future<void> _persist() async {
    await _store.save(state);
  }
}
