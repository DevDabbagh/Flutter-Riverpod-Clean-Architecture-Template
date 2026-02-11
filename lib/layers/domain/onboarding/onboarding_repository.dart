import 'package:dartz/dartz.dart';
import '../../../../app/core/errors/failures.dart';
import 'entities/onboarding.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<Onboarding>>> getOnboardingItems();
}
