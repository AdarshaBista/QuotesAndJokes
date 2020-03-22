import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/images/empty.png',
            color: Colors.white54,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 24.0),
          Text(
            'Nothing here...',
            style: AppTextStyles.largeDark.copyWith(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
