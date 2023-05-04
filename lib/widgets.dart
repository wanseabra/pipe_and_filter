import 'package:flutter/material.dart';

class MensagemRequest extends StatelessWidget {
  const MensagemRequest({
    super.key,
    required this.requests,
    required this.avatar,
  });

  final String requests;
  final int avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset(
            "assets/images/avatar$avatar.png",
            height: 100,
            width: 100,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  requests,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

TextStyle textStyle() {
  return const TextStyle(
    fontSize: 20,
  );
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.label,
  });

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          label: Text(label),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey))),
    );
  }
}

class CheckboxTile extends StatelessWidget {
  const CheckboxTile({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.isFiltroChecked,
    required this.callback,
  });

  final String titulo;
  final String subtitulo;
  final bool isFiltroChecked;
  final Function(bool) callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: CheckboxListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitulo,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        value: isFiltroChecked,
        tileColor:
            isFiltroChecked ? Colors.grey[300] : Theme.of(context).canvasColor,
        onChanged: (value) {
          callback(value!);
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF276DC9), Color(0XFF1F2F98)]),
            borderRadius: BorderRadius.circular(8)),
        height: 50,
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
