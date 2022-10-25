
import 'package:flutter/material.dart';
import '../../constants.dart';

class MultilineInput extends StatelessWidget {
  const MultilineInput({super.key});





  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: const Offset(0.0, 15.0),
            color: kTextColor.withAlpha(20)
          )
        ]
      ),
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        validator: (val){
          if(val!.isEmpty){
            return 'Enter valid review';
          }else{
            return null;
          }
        },
        onSaved: (val){


        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Additional comment',
          hintStyle: TextStyle(
            color: kTextLightColor,
          )
        ),
      ),
    );
  }
}