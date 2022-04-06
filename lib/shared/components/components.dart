import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minapharm/models/movie_data_model.dart';
import 'package:minapharm/shared/styles/colors.dart';

// ignore: must_be_immutable
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  DefaultAppBar({Key? key,this.actions}) : super(key: key);
  List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: defaultColor,
      title: Text(
        'MinaPharm',
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.white),
      ),
      actions: actions,
      elevation: 0.5,
    );
  }
}

Widget defaultFormField({
  Function(dynamic)? onSubmit,
  Function(dynamic)? onChange,
  Function(dynamic)? validate,
  Function()? onPressedSofix,
  Function()? onTapText,
  IconData? sofIcon,
  bool security = false,
  required TextEditingController textController,
  required TextInputType textType,
  required IconData preficon,
  required String labelText,
  required String validatedText,
}) {
  return TextFormField(
    controller: textController,
    keyboardType: textType,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    obscureText: security,
    onTap: onTapText,
    decoration: InputDecoration(
      prefixIcon: Icon(preficon),
      labelText: 'Enter Your $labelText',
      border: const OutlineInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(sofIcon),
        onPressed: onPressedSofix,
      ),
    ),

    // ignore: body_might_complete_normally_nullable
    validator: (value) {
      if (preficon == Icons.email_outlined){
        if (value!.isEmpty ||
            !value.contains('@') ||
            !value.contains('.')) {
          return 'Please Enter True Email Address';
        }
      }
      if (value!.isEmpty) {
        return '$validatedText must not be Empty';
      }
    },
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 15.0,
  double height = 45.0,
  FontWeight btnFontBold = FontWeight.bold,
  required Function function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      border: Border.all(color: Colors.white),
      color: background,
      borderRadius: BorderRadius.circular(15),
    ),
    child: MaterialButton(
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: btnFontBold,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        function();
      },
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

Widget defaultTextButton({
  required Function function,
  required String data,
  Color? color,
}) {
  return TextButton(
    onPressed: (){function();},
    child: Text(
      data.toUpperCase(),
      style: TextStyle(
        color: color,
      ),
    ),
  );
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.only(left: 20,top: 8,bottom: 8,right: 20),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

Widget homeGridProductsBuilder({MovieDataModel? model,BuildContext? context}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset:
          const Offset(0, 3), // changes position of shadow
        ),
      ],
      border: Border.all(color: Colors.white),
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: '${model?.poster}',
          placeholder: (context, url) => const SizedBox(
            child: Center(child: CircularProgressIndicator()),
            width: 30,
            height: 30,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: double.infinity ,
          height: 180,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: 10,),
        Center(
          child: Text(
            '${model?.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

