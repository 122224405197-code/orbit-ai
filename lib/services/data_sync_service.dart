import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_profile.dart';
import '../models/adaptive_metric.dart';

class DataSyncService {
  static final DataSyncService _instance = DataSyncService._internal();
  late SharedPreferences _prefs;

  factory DataSyncService() {
    return _instance;
  }

  DataSyncService._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============ User Profile Methods ============

  Future<void> saveUserProfile(UserProfile profile) async {
    final jsonString = jsonEncode(profile.toJson());
    await _prefs.setString('user_profile_${profile.userId}', jsonString);
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    final jsonString = _prefs.getString('user_profile_$userId');
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString);
      return UserProfile.fromJson(json);
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }

  // ============ Adaptive Metrics Methods ============

  Future<void> saveMetric(AdaptiveMetric metric) async {
    final metrics = await getMetrics(metric.userId);
    metrics.add(metric);

    final jsonList = metrics.map((m) => m.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString('metrics_${metric.userId}', jsonString);
  }

  Future<List<AdaptiveMetric>> getMetrics(String userId) async {
    final jsonString = _prefs.getString('metrics_$userId');
    if (jsonString == null) return [];

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => AdaptiveMetric.fromJson(json)).toList();
    } catch (e) {
      print('Error loading metrics: $e');
      return [];
    }
  }

  Future<void> clearOldMetrics(String userId, int daysToKeep) async {
    final metrics = await getMetrics(userId);
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));

    final filteredMetrics =
        metrics.where((m) => m.timestamp.isAfter(cutoffDate)).toList();

    final jsonList = filteredMetrics.map((m) => m.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString('metrics_$userId', jsonString);
  }

  // ============ General Methods ============

  Future<void> clearAllData(String userId) async {
    await _prefs.remove('user_profile_$userId');
    await _prefs.remove('metrics_$userId');
    await _prefs.remove('recommendations_$userId');
    await _prefs.remove('insights_$userId');
  }

  Future<Map<String, dynamic>> getBackupData(String userId) async {
    final profile = await getUserProfile(userId);
    final metrics = await getMetrics(userId);

    return {
      'profile': profile?.toJson(),
      'metrics': metrics.map((m) => m.toJson()).toList(),
      'backupDate': DateTime.now().toIso8601String(),
    };
  }

  Future<void> restoreFromBackup(String userId, Map<String, dynamic> backupData) async {
    if (backupData['profile'] != null) {
      final profile = UserProfile.fromJson(backupData['profile']);
      await saveUserProfile(profile);
    }

    if (backupData['metrics'] != null) {
      for (var metricJson in backupData['metrics']) {
        final metric = AdaptiveMetric.fromJson(metricJson);
        await saveMetric(metric);
      }
    }
  }
}