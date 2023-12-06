import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final String title;
  final Function handleDelete;
  const DeleteButton({
    super.key,
    required this.title,
    required this.handleDelete,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Column(
        children: [
          Icon(Icons.delete),
          Text('삭제'),
        ],
      ),
      onPressed: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return AlertDialog(
              title: Text(this.title),
              content: const Text('정말 삭제하시겠습니까?'),
              actions: [
                TextButton(
                  child: const Text('취소'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('삭제'),
                  onPressed: () async {
                    handleDelete().then((value) => Navigator.pop(context));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
