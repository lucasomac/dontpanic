import 'package:dontpanic/models/secure_contact.dart';
import 'package:dontpanic/widgets/trailing_contact.dart';
import 'package:flutter/material.dart';

class SecureList extends StatelessWidget {
  const SecureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = [
      SecureContact('Lucas', '079991615960'),
      SecureContact('Luan', '079991615960'),
      SecureContact('Luana', '079991615960'),
      SecureContact('Licia', '079991615960'),
      SecureContact('Lorena', '079991615960'),
      SecureContact('Loreta', '079991615960'),
      SecureContact('Mateus', '079991114629'),
      SecureContact('Maria', '079991114629'),
      SecureContact('Mariana', '079991114629'),
      SecureContact('Mariazinha', '079991114629'),
      SecureContact('Maria Ines', '079991114629'),
      SecureContact('Marcela', '079991114629'),
      SecureContact('Monique', '079991114629'),
      SecureContact('Valeria', '079991114629'),
      SecureContact('Vitoria', '079991114629'),
      SecureContact('Raimunda', '079988124629')
    ];
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(list[index].nome),
        subtitle: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Text(
            list[index].telefone,
            style: const TextStyle(
              color: Colors.green,
              backgroundColor: Colors.greenAccent,
            ),
          ),
        ),
        trailing: const TrailingContact(),
      ),
    );
  }
}
//
//
// Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(16),
// border: Border.all(color: Colors.white12, width: 2),
// ),
// child: IconButton(
// onPressed: () {},
// icon: const Icon(
// Icons.delete,
// color: Colors.black45,
// ),
// ),
// )
