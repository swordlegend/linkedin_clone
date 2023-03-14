import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/models/jobs_model.dart';

final jobApiProvider = Provider((ref) {
  return JobApi(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IJobApi {
  FutureEither<Document> postJob(JobModel jobModel);
  Future<List<Document>> getJobsPosts();
  FutureEitherVoid deletePost(JobModel jobModel);
  FutureEitherVoid bookmarkJob(JobModel jobModel);
}

class JobApi implements IJobApi {
  final Databases _db;
  JobApi({
    required Databases db,
  }) : _db = db;

  @override
  FutureEither<Document> postJob(JobModel jobModel) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.jobsCollection,
        documentId: ID.unique(),
        data: jobModel.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'Some unexpected error occurred', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getJobsPosts() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.jobsCollection,
    );
    return documents.documents;
  }



  @override
  FutureEitherVoid deletePost(JobModel jobModel) async {
    try {
      await _db.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.jobsCollection,
        documentId: jobModel.id,
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'Some unexpected error occurred', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
  
  @override
  FutureEitherVoid bookmarkJob(JobModel jobModel) async {
  try {
      await _db.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.jobsCollection,
        documentId: jobModel.id,
        data: {
          'isBookmarked': jobModel.isBookmarked,
        }
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'Some unexpected error occurred', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
