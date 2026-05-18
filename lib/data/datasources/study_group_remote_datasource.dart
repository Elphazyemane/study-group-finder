import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/errors/exceptions.dart';
import '../../core/network/api_constants.dart';
import '../../core/network/http_client.dart';
import '../models/study_group.dart';

abstract class StudyGroupRemoteDataSource {
  Future<List<StudyGroup>> getStudyGroups();
  Future<StudyGroup> createStudyGroup(StudyGroup studyGroup);
  Future<StudyGroup> updateStudyGroup(StudyGroup studyGroup);
  Future<void> deleteStudyGroup(int id);
}

class StudyGroupRemoteDataSourceImpl implements StudyGroupRemoteDataSource {
  final HttpClient httpClient;

  StudyGroupRemoteDataSourceImpl({required this.httpClient});

  static final List<StudyGroup> _localGroups = [];
  static int _nextId = 1;

  @override
  Future<List<StudyGroup>> getStudyGroups() async {
    return List.from(_localGroups);
  }

  @override
  Future<StudyGroup> createStudyGroup(StudyGroup studyGroup) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.studyGroupsEndpoint}'),
        headers: httpClient.headers,
        body: jsonEncode(studyGroup.toJson()),
      );
      if (response.statusCode == 201) {
        final newGroup = StudyGroup(
          id: _nextId++,
          userId: 1,
          subject: studyGroup.subject,
          description: studyGroup.description,
        );
        _localGroups.insert(0, newGroup);
        return newGroup;
      } else {
        throw const ServerException('Failed to create study group.');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const NetworkException('No internet connection.');
    }
  }

  @override
  Future<StudyGroup> updateStudyGroup(StudyGroup studyGroup) async {
    try {
      final response = await http.put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.studyGroupsEndpoint}/${studyGroup.id}'),
        headers: httpClient.headers,
        body: jsonEncode(studyGroup.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _localGroups.indexWhere((g) => g.id == studyGroup.id);
        if (index != -1) {
          _localGroups[index] = studyGroup;
        }
        return studyGroup;
      } else {
        throw const ServerException('Failed to update study group.');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const NetworkException('No internet connection.');
    }
  }

  @override
  Future<void> deleteStudyGroup(int id) async {
    try {
      final response = await http.delete(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.studyGroupsEndpoint}/$id'),
        headers: httpClient.headers,
      );
      if (response.statusCode == 200) {
        _localGroups.removeWhere((g) => g.id == id);
      } else {
        throw const ServerException('Failed to delete study group.');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const NetworkException('No internet connection.');
    }
  }
}