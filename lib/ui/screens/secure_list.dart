import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/res/palette.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../data/models/secure_contact.dart';
import '../../data/repository/secure_contact_repository.dart';
import '../widgets/secure_contact_form.dart';
import '../widgets/trailing_contact.dart';

class SecureList extends StatelessWidget {
  final String userEmail;

  final SecureContactRepository repository = KiwiContainer().resolve();

  SecureList(this.userEmail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: StreamBuilder<QuerySnapshot>(
            stream: repository.getAllSecureContact(userEmail),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else {
                if (snapshot.hasData || snapshot.data != null) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var secureContactInfo =
                          snapshot.data!.docs[index].data()!;
                      String docID = snapshot.data!.docs[index].id;
                      SecureContact contact = SecureContact.fromJson(
                          secureContactInfo as Map<String, dynamic>);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            // onTap: () => Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const EditSecureContact(
                            //         // currentTitle: title,
                            //         // currentDescription: description,
                            //         // documentId: docID,
                            //         ),
                            //   ),
                            // ),
                            title: Text(
                              contact.name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              contact.phone,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                backgroundColor: Colors.greenAccent,
                              ),
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  repository.deleteSecureContact(
                                      userEmail, docID);
                                },
                                child: const TrailingContact()),
                          ),
                        ),
                      );
                    },
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Palette.firebaseOrange,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecureContactForm(userEmail)),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }
}
