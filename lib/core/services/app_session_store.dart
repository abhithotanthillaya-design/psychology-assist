import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../app/app_state.dart';

class AppSessionStore {
  static const _databaseName = 'psychol_demo.db';
  static const _tableName = 'app_state';
  static const _stateKey = 'session';

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      p.join(dbPath, _databaseName),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, payload TEXT NOT NULL)',
        );
      },
    );
  }

  Future<AppSession> load() async {
    final db = await _open();
    final rows = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [_stateKey],
      limit: 1,
    );
    if (rows.isEmpty) {
      return const AppSession();
    }

    final payload = rows.first['payload'] as String;
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final session = _sessionFromJson(data);
    return session.copyWith(
      isLocked: session.onboardingComplete && session.appLockSet,
    );
  }

  Future<void> save(AppSession session) async {
    final db = await _open();
    await db.insert(
      _tableName,
      {
        'id': _stateKey,
        'payload': jsonEncode(_sessionToJson(session)),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, dynamic> _sessionToJson(AppSession session) {
    return {
      'onboardingComplete': session.onboardingComplete,
      'appLockSet': session.appLockSet,
      'lockPin': session.lockPin,
      'profile':
          session.profile == null ? null : _profileToJson(session.profile!),
      'appointments': session.appointments.map(_appointmentToJson).toList(),
    };
  }

  AppSession _sessionFromJson(Map<String, dynamic> json) {
    final appointments = (json['appointments'] as List<dynamic>? ?? [])
        .map((item) => _appointmentFromJson(item as Map<String, dynamic>))
        .toList();

    return AppSession(
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
      appLockSet: json['appLockSet'] as bool? ?? false,
      lockPin: json['lockPin'] as String?,
      profile: json['profile'] == null
          ? null
          : _profileFromJson(json['profile'] as Map<String, dynamic>),
      appointments: appointments,
    );
  }

  Map<String, dynamic> _profileToJson(AppProfile profile) {
    return {
      'role': profile.role.name,
      'name': profile.name,
      'dateOfBirth': profile.dateOfBirth?.toIso8601String(),
      'email': profile.email,
      'psychologistEmail': profile.psychologistEmail,
    };
  }

  AppProfile _profileFromJson(Map<String, dynamic> json) {
    return AppProfile(
      role: UserRole.values.firstWhere(
        (role) => role.name == json['role'],
        orElse: () => UserRole.patient,
      ),
      name: json['name'] as String? ?? 'Demo Patient',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      email: json['email'] as String?,
      psychologistEmail: json['psychologistEmail'] as String?,
    );
  }

  Map<String, dynamic> _appointmentToJson(Appointment appointment) {
    return {
      'psychologistEmail': appointment.psychologistEmail,
      'startsAt': appointment.startsAt.toIso8601String(),
      'type': appointment.type,
      'note': appointment.note,
    };
  }

  Appointment _appointmentFromJson(Map<String, dynamic> json) {
    return Appointment(
      psychologistEmail:
          json['psychologistEmail'] as String? ?? demoPsychologistEmail,
      startsAt: DateTime.parse(json['startsAt'] as String),
      type: json['type'] as String? ?? 'Video session',
      note: json['note'] as String? ?? '',
    );
  }
}
