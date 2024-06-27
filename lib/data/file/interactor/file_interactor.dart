import 'package:ecommerce_admin/data/file/model/file_model.dart';
import 'package:ecommerce_admin/data/file/repository/file_repository_impl.dart';

class FileInteractor {
  final FileRepository repository;

  FileInteractor({required this.repository});

  Future<FileModel> upload(data) async => await repository.upload(data);
}
