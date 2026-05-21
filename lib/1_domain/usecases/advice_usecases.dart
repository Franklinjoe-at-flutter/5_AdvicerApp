import 'package:advicer_app/1_domain/entities/advice_entity.dart';
import 'package:advicer_app/1_domain/failures/failures.dart';
import 'package:advicer_app/2_data/repositories/advice_repo_implementation.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  final AdviceRepoImplementation adviceRepo;
  AdviceUseCases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
  }
}
