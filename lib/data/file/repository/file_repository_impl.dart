import 'package:ecommerce_admin/data/file/datasource/file_remote_data_source.dart';
import 'package:ecommerce_admin/data/file/model/file_model.dart';

class FileRepository {
  final FileRemoteDataSource remoteDataSource;

  FileRepository({required this.remoteDataSource});

  Future<FileModel> upload(data) async {
    return await remoteDataSource.upload(data);
  }
}
