import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmer extends StatelessWidget {
  final bool? isLoading;
  final Widget? child;

  const CommonShimmer({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      child: (isLoading!)
          ? Shimmer.fromColors(
              key: const ValueKey('1'),
              period: const Duration(milliseconds: 900),
              baseColor: Colors.grey.shade300.withOpacity(0.8),
              highlightColor: Colors.grey.shade100,
              child: child!,
            )
          : child!,
    );
  }
}
