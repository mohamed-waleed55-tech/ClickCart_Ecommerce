
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.onChanged
  });

  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _hideText;

  @override
  void initState() {
    super.initState();
    _hideText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextFormField(
      onSaved: (value) {
        widget.onSaved?.call(value);
      },
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _hideText,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
        filled: true,
        fillColor: cs.surfaceContainerHighest.withValues(alpha: .28),
        prefixIcon: Icon(widget.prefixIcon, size: 20.sp, color: cs.primary),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => _hideText = !_hideText),
                icon: Icon(
                  _hideText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 20.sp,
                ),
              )
            : null,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: cs.onSurfaceVariant,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: cs.onSurfaceVariant.withValues(alpha: .7),
          fontSize: 13.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: cs.outlineVariant, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: cs.primary, width: 1.6.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: cs.error, width: 1.4.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: cs.error, width: 1.8.w),
        ),
      ),
    );
  }
}
