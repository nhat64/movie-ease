import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlineTextFieldCustom extends StatefulWidget {
  final TextStyle? contentStyle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? errorPadding;

  final String? labelText;
  final TextStyle? labelStyle;

  final TextStyle? floatingLabelStyle;
  final FloatingLabelBehavior floatingLabelBehavior;

  final String? hintText;
  final TextStyle? hintStyle;

  final Color suffixColor;
  final double suffixIconSize;

  final Widget? prefixIcon;

  final TextStyle? errorStyle;

  final double cursorWidth;
  final Color? cursorColor;
  final bool cursorOpacityAnimates;

  final int maxLine;

  final bool isPassword;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? submitBorder;

  final Widget? errorWidget;
  final VoidCallback? onTextFieldTap;
  final bool isDisable;

  final bool isNumber;
  final Function(String? s)? onSubmit;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  final bool filled;
  final Color? fillColor;

  const OutlineTextFieldCustom({
    super.key,
    this.contentStyle,
    this.contentPadding,
    this.labelText,
    this.labelStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.floatingLabelStyle,
    this.hintText,
    this.hintStyle,
    this.errorStyle,
    this.cursorWidth = 1.0,
    this.cursorColor,
    this.cursorOpacityAnimates = true,
    this.suffixColor = Colors.black,
    this.suffixIconSize = 24,
    this.maxLine = 1,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.submitBorder,
    this.errorWidget,
    this.errorPadding,
    this.isDisable = false,
    this.prefixIcon,
    this.onTextFieldTap,
    this.isNumber = false,
    this.textInputAction,
    this.onSubmit,
    this.textInputType,
    this.maxLength,
    this.inputFormatters,
    this.filled = false,
    this.fillColor,
  });

  @override
  State<OutlineTextFieldCustom> createState() => _OutlineTextFieldCustomState();
}

class _OutlineTextFieldCustomState extends State<OutlineTextFieldCustom> {
  bool _obscureText = false;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _obscureText = widget.isPassword;

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    widget.focusNode?.addListener(_focusListener);
    super.initState();
  }

  void _focusListener() {
    if (!_focusNode.hasFocus) {
      setState(() {});
    }
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  dispose() {
    widget.focusNode?.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color errorColor =
        widget.errorStyle?.color ?? const Color(0xFFFF3B30);
    TextStyle? styleOfContent = widget.contentStyle;
    TextStyle? styleOfLabel = widget.labelStyle;
    TextStyle? styleOfFloatingLabel = widget.floatingLabelStyle;

    final bool isError = widget.errorWidget != null;

    if (isError) {
      styleOfContent = widget.contentStyle?.copyWith(color: errorColor);
      styleOfLabel = widget.labelStyle?.copyWith(color: errorColor);
      styleOfFloatingLabel =
          widget.floatingLabelStyle?.copyWith(color: errorColor);
    }

    return Column(
      children: [
        DefaultTextStyle.merge(
          style: widget.errorStyle,
          child: TextFormField(
            textInputAction: widget.textInputAction,
            onTap: widget.onTextFieldTap,
            onFieldSubmitted: widget.onSubmit,
            controller: _controller,
            focusNode: _focusNode,
            obscureText: _obscureText,
            keyboardType: widget.textInputType,
            style: styleOfContent,
            cursorWidth: widget.cursorWidth,
            cursorColor: widget.cursorColor,
            cursorErrorColor: errorColor,
            cursorOpacityAnimates: widget.cursorOpacityAnimates,
            maxLines: widget.maxLine,
            scrollPadding: const EdgeInsets.only(bottom: 18),
            readOnly: widget.isDisable,
            maxLength: widget.maxLength,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                null,
            inputFormatters: widget.inputFormatters,
            autofocus: false,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: widget.fillColor,
              contentPadding: widget.contentPadding,
              isDense: true,
              labelText: widget.labelText,
              labelStyle: styleOfLabel,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              floatingLabelStyle: styleOfFloatingLabel,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              border:
                  (widget.submitBorder != null && _controller.text.isNotEmpty)
                      ? widget.submitBorder
                      : widget.border,
              focusedBorder: widget.focusedBorder,
              errorBorder: widget.errorBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
              enabledBorder:
                  (widget.submitBorder != null && _controller.text.isNotEmpty)
                      ? widget.submitBorder
                      : widget.border,
              error: isError ? const SizedBox.shrink() : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 0, minWidth: 0),
              prefixIcon: !isError
                  ? widget.prefixIcon
                  : widget.prefixIcon != null
                      ? ColorFiltered(
                          colorFilter:
                              ColorFilter.mode(errorColor, BlendMode.srcIn),
                          child: widget.prefixIcon,
                        )
                      : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: _toggleObscureText,
                      icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          !isError ? widget.suffixColor : errorColor,
                          BlendMode.srcIn,
                        ),
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: widget.suffixIconSize,
                        ),
                      ),
                      iconSize: widget.suffixIconSize,
                    )
                  : null,
            ),
          ),
        ),
        if (isError)
          Container(
            alignment: Alignment.centerLeft,
            padding: widget.errorPadding,
            child: widget.errorWidget,
          ),
      ],
    );
  }
}
