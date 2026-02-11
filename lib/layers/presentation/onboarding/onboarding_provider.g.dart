// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingRepositoryHash() =>
    r'73985613e633a57080d991f055104ce2e16cfa06';

/// See also [onboardingRepository].
@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider =
    AutoDisposeProvider<OnboardingRepository>.internal(
  onboardingRepository,
  name: r'onboardingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingRepositoryRef = AutoDisposeProviderRef<OnboardingRepository>;
String _$onboardingControllerHash() =>
    r'3229193722269f1767e4c849cff1146f8ba9a3e1';

/// See also [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider = AutoDisposeAsyncNotifierProvider<
    OnboardingController, List<Onboarding>>.internal(
  OnboardingController.new,
  name: r'onboardingControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingController = AutoDisposeAsyncNotifier<List<Onboarding>>;
String _$onboardingIndexHash() => r'0de525aa00f4ff4ae50053d3caafac1b9d09d317';

/// See also [OnboardingIndex].
@ProviderFor(OnboardingIndex)
final onboardingIndexProvider =
    AutoDisposeNotifierProvider<OnboardingIndex, int>.internal(
  OnboardingIndex.new,
  name: r'onboardingIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingIndex = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
