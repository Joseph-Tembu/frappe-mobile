import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:frappe_app/app/locator.dart';
import 'package:frappe_app/model/notification_response.dart';
import 'package:frappe_app/services/api/api.dart';
import 'package:frappe_app/utils/constants.dart';
import 'package:frappe_app/widgets/user_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'form_view/form_view.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago; // Make sure to import the timeago package
import 'package:flutter_pagewise/flutter_pagewise.dart'; // Import the flutter_pagewise package
import 'package:flutter_screenutil/flutter_screenutil.dart'; // If you're using ScreenUtil for responsive UI

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: Text(
          'Notifications',
        ),
      ),
      body: PagewiseListView(
        pageLoadController: PagewiseLoadController(
          pageSize: Constants.pageSize,
          pageFuture: (pageIndex) async {
            var listResponse = await locator<Api>().getList(
              fields: ["*"],
              limit: Constants.pageSize,
              orderBy: "creation desc",
              doctype: "Notification Log",
            );

            var notificationsResponse = NoticationResponse.fromJson(
              {
                "message": listResponse,
              },
            );

            return notificationsResponse.message;
          },
        ),
        itemBuilder: (context, entry, index) {
          var e = entry as Message;

          return Column(
            children: [
              ListTile(
                minLeadingWidth: 10,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  e.subject ?? '', // Use a Text widget instead of Html
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FormView(
                      name: e.documentName!,
                      doctype: e.documentType,
                    ),
                  ));
                },
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    timeago.format(
                      DateTime.parse(e.creation!),
                    ),
                  ),
                ),
                leading: UserAvatar(
                  uid: e.fromUser!,
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

// class NotifcationView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.8,
//         title: Text(
//           'Notifications',
//         ),
//       ),
//       body: PagewiseListView(
//         pageLoadController: PagewiseLoadController(
//           pageSize: Constants.pageSize,
//           pageFuture: (pageIndex) async {
//             var listResponse = await locator<Api>().getList(
//               fields: ["*"],
//               limit: Constants.pageSize,
//               orderBy: "creation desc",
//               doctype: "Notification Log",
//             );
//
//             var notificationsResponse = NoticationResponse.fromJson(
//               {
//                 "message": listResponse,
//               },
//             );
//
//             return notificationsResponse.message;
//           },
//         ),
//         itemBuilder: ((__, entry, _) {
//           var e = entry as Message;
//
//           return Column(
//             children: [
//               ListTile(
//                 minLeadingWidth: 10,
//                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
//                 title: Html(
//                   data: e.subject!,
//                 ),
//
//
//                 onTap: () {
//                   pushNewScreen(
//                     context,
//                     screen: FormView(
//                       name: e.documentName!,
//                       doctype: e.documentType,
//                     ),
//                     withNavBar: true,
//                   );
//                 },
//
//
//                 subtitle: Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text(timeago.format(
//                     DateTime.parse(
//                       e.creation!,
//                     ),
//                   )),
//                 ),
//                 leading: UserAvatar(
//                   uid: e.fromUser!,
//                 ),
//               ),
//               Divider(),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
