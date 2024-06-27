import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final String title;
  final bool isVisible;
  final Function onPressed;
  final IconData icon;

  const ActionButtonWidget({
    super.key,
    required this.isVisible,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        height: 40.0,
        child: ElevatedButton(
          onPressed: () =>
          {
            onPressed.call()
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(title, style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: Colors.white,
              ))
            ],
          ),
        ),
      ),);
  }
}