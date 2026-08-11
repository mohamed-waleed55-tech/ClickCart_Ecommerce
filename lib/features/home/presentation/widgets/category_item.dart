import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatefulWidget {
  final String name;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });

        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          width: 78.w,
          child: Column(
            children: [

              Container(
                width: 70.r,
                height: 70.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.r),

                  color: isDark
                      ? widget.color.withValues(alpha: 0.16)
                      : widget.color.withValues(alpha: 0.08),

                  border: Border.all(
                    color: widget.color.withValues(
                      alpha: isDark ? 0.22 : 0.10,
                    ),
                    width: 1,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withValues(
                        alpha: isDark ? 0.08 : 0.06,
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ─────────────────────────
                    // Decorative Glow
                    // ─────────────────────────

                    Positioned(
                      top: -12.r,
                      right: -12.r,
                      child: Container(
                        width: 42.r,
                        height: 42.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.withValues(
                            alpha: 0.08,
                          ),
                        ),
                      ),
                    ),

                 

                    Image.asset(
                      widget.image,
                      width: 54.r,
                      height: 54.r,
                      fit: BoxFit.contain,

                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image_not_supported_outlined,
                          size: 28.sp,
                          color: widget.color,
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 9.h),

              // ─────────────────────────────
              // Category Name
              // ─────────────────────────────

              Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}