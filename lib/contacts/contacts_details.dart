import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyatobi/contacts/contacts_list.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsDetails extends StatefulWidget {
  @override
  ContactsGenerator createState() => ContactsGenerator();

//  getContacts  () async {
//      Iterable<Contact> contacts = await ContactsService.getContacts();
//      if(contacts!=null){

//      }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//             tag: 'imageHero',
//             child: Image.network(
//               'https://picsum.photos/250?image=9',
//             ),
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );

}

class ContactsGenerator extends State<ContactsDetails> {
  // ignore: unused_field
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;
  List contacts;

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      if (await Permission.contacts.isPermanentlyDenied) {
        return openAppSettings();
      }
      _handleInvalidPermissions(permissionStatus);
    } else {
      Iterable<Contact> contact = await ContactsService.getContacts();
      setState(() {
        _permissionStatus = PermissionStatus.granted;
        contacts = contact.toList();
      });
      print(contact.toList());
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    final permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  _handleInvalidPermissions([PermissionStatus permissionStatus]) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: _permissionStatus == PermissionStatus.granted
            ? (contacts != null
                ? ContactsList(contacts)
                : Center(child: CircularProgressIndicator()))
            : Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Please Give Access to the contacts to send the bill',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      MaterialButton(
                        onPressed: _askPermissions,
                        child: Text('Get Contacts'),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        elevation: 5.0,
                      )
                    ],
                  ),
                )));
  }
}
