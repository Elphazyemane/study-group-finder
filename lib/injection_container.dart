import 'core/network/http_client.dart';
import 'data/datasources/study_group_remote_datasource.dart';
import 'data/repositories/study_group_repository.dart';
import 'presentation/providers/study_group_provider.dart';

class InjectionContainer {
  InjectionContainer._();

  static HttpClient get httpClient => HttpClient();

  static StudyGroupRemoteDataSource get remoteDataSource =>
      StudyGroupRemoteDataSourceImpl(httpClient: httpClient);

  static StudyGroupRepository get repository =>
      StudyGroupRepositoryImpl(remoteDataSource: remoteDataSource);

  static StudyGroupProvider get studyGroupProvider =>
      StudyGroupProvider(repository: repository);
}