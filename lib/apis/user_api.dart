import 'package:fpdart/fpdart.dart';
import 'package:linkedin/constants/appwrite_constants.dart';
import 'package:linkedin/core/core.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/models/user_model.dart';

final userApiProvider = Provider((ref) {
  final database = ref.watch(appwriteDatabaseProvider);
  return UserApi(database: database);
});

abstract class IUserApi {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
  Future<List<model.Document>> searchUserByName(String name);
  FutureEitherVoid updateUserData(UserModel userModel);
  Future<List> getAllUsers();
}

class UserApi implements IUserApi {
  final Databases _database;
  UserApi({required Databases database}) : _database = database;

  @override
  Future<List> getAllUsers() async {
    final users = await _database.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
    );
    return users.documents;
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _database.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid,
    );
  }

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _database.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<model.Document>> searchUserByName(String name) async {
    final users = await _database.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      queries: [
        Query.search('name', name),
      ],
    );
    return users.documents;
  }

  @override
  FutureEitherVoid updateUserData(UserModel userModel) async {
    try {
      await _database.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
