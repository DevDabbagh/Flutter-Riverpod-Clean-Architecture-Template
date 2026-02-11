import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/onboarding/entities/onboarding.dart';
import '../../domain/onboarding/onboarding_repository.dart';
import '../../data/onboarding/onboarding_repository_impl.dart';

part 'onboarding_provider.g.dart';

// 1. Repository Provider
@riverpod
OnboardingRepository onboardingRepository(Ref ref) {
  return OnboardingRepositoryImpl();
}

// 2. Data Provider (The Controller/Notifier)
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  Future<List<Onboarding>> build() async {
    final repository = ref.read(onboardingRepositoryProvider);
    final result = await repository.getOnboardingItems();

    return result.fold(
      (failure) => throw failure, // Handle error in UI
      (items) => items,
    );
  }
}

// 3. UI State Provider (Current Page Index)
@riverpod
class OnboardingIndex extends _$OnboardingIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
