import 'package:easycopy/bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultFormFeild({
  required TextEditingController controller,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  Function()? suffexPressed,
  Function()? perfixPressed,
  Function()? onTap,
  required String label,
  TextInputType type = TextInputType.text,
  IconData? prefix,
  IconData? suffex,
  bool isPassword = false,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: IconButton(
          splashRadius: 0.00001,
          icon: Icon(
            prefix,
            color: Colors.grey,
            size: 22.0,
          ),
          onPressed: perfixPressed,
        ),
        suffixIcon: suffex != null
            ? IconButton(onPressed: suffexPressed, icon: Icon(suffex))
            : null,
      ),
    );

void showSnack({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black87,
    ),
  );
}

Widget itemsBuilder({
  required BuildContext ctx,
  required List list,
}) =>
    Expanded(
      child: ListView.builder(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          leading: IconButton(
            splashRadius: 0.00001,
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ),
            onPressed: () {
              AppCubit.appCubit(context).remove(index: index, context: context);
            },
          ),
          title: SelectableText(
            list[index],
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: IconButton(
            splashRadius: 0.00001,
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(
                text: list[index],
              )).then(
                (value) {
                  showSnack(context: context, message: 'Copied to clipboard');
                },
              );
            },
          ),
        ),
      ),
    );
