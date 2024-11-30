import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:flutter/material.dart';

class SwitchBar extends StatelessWidget {
  const SwitchBar({
    super.key,
    required this.index,
    required this.count,
    required this.listTitle,
    this.onChange,
  });

  final int index;
  final int count;
  final List<String> listTitle;
  final Function(int index)? onChange;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        const double padding = 6;
        const double gap = 8;
        final double itemWidth = (maxWidth - padding * 2 - gap * (count - 1)) / count;
        const double itemHeight = 45 - padding * 2;
        return Stack(
          children: [
            Container(
              height: 45,
              width: maxWidth,
              decoration: BoxDecoration(
                color: AppColors.neutral1C1C1C,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              top: padding,
              left: index * (itemWidth + gap) + padding,
              child: Container(
                width: itemWidth,
                height: itemHeight,
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(
              height: 45,
              width: maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: listTitle
                    .map<Widget>(
                      (e) => Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            onChange?.call(listTitle.indexOf(e));
                          },
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: listTitle.indexOf(e) == index ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
