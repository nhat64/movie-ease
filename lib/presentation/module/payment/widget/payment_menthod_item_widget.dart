import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/payment_menthod_entity.dart';
import 'package:flutter/material.dart';

class PaymentMenthodItemWidget extends StatelessWidget {
  const PaymentMenthodItemWidget({super.key, required this.menthod, required this.isSelected, this.onTap});

  final PaymentMenthodEntity menthod;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF261D08) : AppColors.neutral1D1D1D,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: AppColors.yellowFCC434, width: 1) : Border.all(color: Colors.transparent, width: 1),
          ),
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
                width: 80,
                height: 48,
                child: Image.asset(menthod.image, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Text(
                menthod.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: isSelected ? Border.all(color: AppColors.yellowFCC434, width: 2) : Border.all(color: Colors.transparent, width: 2),
                ),
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.yellowFCC434 : Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
