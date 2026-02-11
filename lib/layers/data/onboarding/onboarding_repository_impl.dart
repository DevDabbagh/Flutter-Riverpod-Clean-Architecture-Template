import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../app/core/errors/failures.dart';
import '../../domain/onboarding/entities/onboarding.dart';
import '../../domain/onboarding/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<Either<Failure, List<Onboarding>>> getOnboardingItems() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return Dummy Data (as requested for now)
    final items = [
      const Onboarding(
        title: "Your Journey to Balance Starts Here",
        description:
            "We're here to support you every step towards better mental health.",
        icon: Icons.favorite_outline_rounded,
      ),
      const Onboarding(
        title: "Book Your Session Easily",
        description:
            "Choose a convenient time from licensed psychologists' schedules.",
        icon: Icons.calendar_today_rounded,
      ),
      const Onboarding(
        title: "Privacy, Security & Care",
        description:
            "Your sessions are confidential and protected with licensed professionals.",
        icon: Icons.security_rounded,
      ),
    ];

    return Right(items);
  }
}
