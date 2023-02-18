import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputForm extends StatefulWidget {
  String title;
  String hintText;
  String mask;
  String validationMessage;
  bool obscure;
  TextEditingController controller;
  FocusNode focus;
  bool isPrefixIcon;
  Widget prefixIcon;
  int length;
  bool isSufixIconObscure;
  Widget sufixIcon;
  Function specialValidation;
  bool requiredInput;
  Function onChangeCustom;
  var globalKeyInput;
  String type;
  String outlineBorder;


  InputForm({@required this.controller, @required this.title, @required this.validationMessage, @required this.focus, this.obscure = false, this.length, this.prefixIcon, this.mask, this.isPrefixIcon = false, this.isSufixIconObscure = false, this.hintText, this.sufixIcon, this.specialValidation, this.requiredInput = true, this.onChangeCustom, this.globalKeyInput, @required this.type, this.outlineBorder});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool validation = false;
  var _formKeyFied;


  @override
  void initState() {
    if (widget.globalKeyInput != null) _formKeyFied = widget.globalKeyInput;
    else _formKeyFied = new GlobalKey<FormFieldState>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(
        fontFamily: "OpensSans",
        fontSize: 16,
        color: Color(0xFFf0821e)
        )),
        SizedBox(height: 5),
        TextFormField(
          cursorColor: Color(0xFFf0821e),
          key: _formKeyFied,
          maxLength: widget.length,
          controller: widget.controller,
          obscureText: widget.obscure,
          focusNode: widget.focus,
          keyboardType: _TextInputType(type: widget.type),
          style: TextStyle(
            color: Color(0xFFf0821e)
          ),
          decoration: InputDecoration(
            prefixIcon: widget.isPrefixIcon ? widget.prefixIcon : null,
            suffixIcon: widget.isSufixIconObscure ? IconButton(
              onPressed: (){
                setState(() {
                  widget.obscure = !widget.obscure;
                });
              },
              icon: Icon(
                widget.obscure ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFFf0821e),
                size: 20,
              ),
            ) : null,
            border: widget.outlineBorder !=null ? const OutlineInputBorder(): null,
          ),
          onChanged: (value){
            if (validation) {
              _formKeyFied.currentState.validate();
            }
            if (widget.onChangeCustom != null) {
              widget.onChangeCustom();
            }
          },
          validator: (value){
            if (widget.requiredInput) {
              if (widget.specialValidation != null) {
                ModifyFlagValidationTrue();
                var result = widget.specialValidation();
                return result;
              }
              ModifyFlagValidationFalse();
            }
          },
          inputFormatters:  [_MaskTextInputFormatter(title: widget.mask)] ,
        ),
      ],
    );
  }

  dynamic _TextInputType({type = ""}) {
    switch (type) {
      case "TEXT":
        return TextInputType.text;
      case "NUMBER":
        return TextInputType.number;
      case "EMAIL":
        return TextInputType.emailAddress;
      case "PHONE":
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  dynamic _MaskTextInputFormatter({title = ""}) {
    switch (title) {
      case "EMAIL":
        return MaskTextInputFormatter(
          initialText: widget.controller.text.toUpperCase(),
        );
      case "PASSWORD":
        return MaskTextInputFormatter(
          initialText: widget.controller.text,
        );
      case "CPF":
        return MaskTextInputFormatter(
            initialText: widget.controller.text,
            mask: '###.###.###-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
      default:
        return MaskTextInputFormatter(
          initialText: widget.controller.text.toUpperCase(),
        );
    }
  }

  void ModifyFlagValidationTrue() {
    setState(() => validation = true);
  }

  void ModifyFlagValidationFalse() {
    setState(() => validation = false);
  }

}


