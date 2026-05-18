import 'package:flutter/material.dart';
import '../../data/models/study_group.dart';
import '../../data/repositories/study_group_repository.dart';

enum StudyGroupStatus { initial, loading, loaded, error }

class StudyGroupProvider extends ChangeNotifier {
  final StudyGroupRepository repository;

  StudyGroupProvider({required this.repository});

  List<StudyGroup> _studyGroups = [];
  StudyGroupStatus _status = StudyGroupStatus.initial;
  String _errorMessage = '';
  bool _isActionLoading = false;

  // Getters
  List<StudyGroup> get studyGroups => _studyGroups;
  StudyGroupStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isActionLoading => _isActionLoading;

  Future<void> fetchStudyGroups() async {
    _status = StudyGroupStatus.loading;
    notifyListeners();

    final (groups, failure) = await repository.getStudyGroups();

    if (failure != null) {
      _status = StudyGroupStatus.error;
      _errorMessage = failure.message;
    } else {
      _studyGroups = groups!;
      _status = StudyGroupStatus.loaded;
    }
    notifyListeners();
  }

  Future<bool> createStudyGroup(String subject, String description) async {
    _isActionLoading = true;
    notifyListeners();

    final newGroup = StudyGroup(
      id: 0,
      userId: 1,
      subject: subject,
      description: description,
    );

    final (created, failure) = await repository.createStudyGroup(newGroup);

    _isActionLoading = false;

    if (failure != null) {
      _errorMessage = failure.message;
      notifyListeners();
      return false;
    } else {
      _studyGroups = [created!, ..._studyGroups];
      notifyListeners();
      return true;
    }
  }

  Future<bool> updateStudyGroup(StudyGroup studyGroup) async {
    _isActionLoading = true;
    notifyListeners();

    final (updated, failure) = await repository.updateStudyGroup(studyGroup);

    _isActionLoading = false;

    if (failure != null) {
      _errorMessage = failure.message;
      notifyListeners();
      return false;
    } else {
      _studyGroups = _studyGroups
          .map((g) => g.id == updated!.id ? updated : g)
          .toList();
      notifyListeners();
      return true;
    }
  }

  Future<bool> deleteStudyGroup(int id) async {
    _isActionLoading = true;
    notifyListeners();

    final (success, failure) = await repository.deleteStudyGroup(id);

    _isActionLoading = false;

    if (failure != null || !success) {
      _errorMessage = failure?.message ?? 'Delete failed';
      notifyListeners();
      return false;
    } else {
      _studyGroups = _studyGroups.where((g) => g.id != id).toList();
      notifyListeners();
      return true;
    }
  }
}