import 'package:flutter/material.dart';

class OopsWidget extends StatelessWidget {
  const OopsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.info_outline,
            size: 100,
          ),
          Text(
            'Oops',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          Text('Có lỗi xảy ra.'),
        ],
      ),
    );
  }
}
