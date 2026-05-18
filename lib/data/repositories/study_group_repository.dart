import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../datasources/study_group_remote_datasource.dart';
import '../models/study_group.dart';

abstract class StudyGroupRepository {
  Future<(List<StudyGroup>?, Failure?)> getStudyGroups();
  Future<(StudyGroup?, Failure?)> createStudyGroup(StudyGroup studyGroup);
  Future<(StudyGroup?, Failure?)> updateStudyGroup(StudyGroup studyGroup);
  Future<(bool, Failure?)> deleteStudyGroup(int id);
}

class StudyGroupRepositoryImpl implements StudyGroupRepository {
  final StudyGroupRemoteDataSource remoteDataSource;

  StudyGroupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<StudyGroup>?, Failure?)> getStudyGroups() async {
    try {
      final groups = await remoteDataSource.getStudyGroups();
      return (groups, null);
    } on NetworkException catch (e) {
      return (null, NetworkFailure(e.message));
    } on ServerException catch (e) {
      return (null, ServerFailure(e.message));
    } catch (e) {
      return (null, UnknownFailure(e.toString()));
    }
  }

  @override
  Future<(StudyGroup?, Failure?)> createStudyGroup(
      StudyGroup studyGroup) async {
    try {
      final created = await remoteDataSource.createStudyGroup(studyGroup);
      return (created, null);
    } on NetworkException catch (e) {
      return (null, NetworkFailure(e.message));
    } on ServerException catch (e) {
      return (null, ServerFailure(e.message));
    } catch (e) {
      return (null, UnknownFailure(e.toString()));
    }
  }

  @override
  Future<(StudyGroup?, Failure?)> updateStudyGroup(
      StudyGroup studyGroup) async {
    try {
      final updated = await remoteDataSource.updateStudyGroup(studyGroup);
      return (updated, null);
    } on NetworkException catch (e) {
      return (null, NetworkFailure(e.message));
    } on ServerException catch (e) {
      return (null, ServerFailure(e.message));
    } catch (e) {
      return (null, UnknownFailure(e.toString()));
    }
  }

  @override
  Future<(bool, Failure?)> deleteStudyGroup(int id) async {
    try {
      await remoteDataSource.deleteStudyGroup(id);
      return (true, null);
    } on NotFoundException catch (e) {
      return (false, NotFoundFailure(e.message));
    } on NetworkException catch (e) {
      return (false, NetworkFailure(e.message));
    } on ServerException catch (e) {
      return (false, ServerFailure(e.message));
    } catch (e) {
      return (false, UnknownFailure(e.toString()));
    }
  }
}