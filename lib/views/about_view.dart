// import 'package:flutter/material.dart';
// import 'package:parenthood/views/Details_view.dart';
//
// class AboutView extends StatelessWidget {
//    AboutView({Key? key}) : super(key: key);
//
//   final List<Color> colors = [
//     Colors.red,
//     Colors.green,
//     Colors.blue,
//     Colors.orange,
//     Colors.purple,
//   ];
//
//   final List<String> titles = [
//     'Title 1',
//     'Title 2',
//     'Title 3',
//     'Title 4',
//     'Title 5',
//   ];
//
//   final List<String> descriptions = [
//     'This is a longer description for item 1. It contains more detailed information about the item.',
//     'This is a longer description for item 2. It contains more detailed information about the item.',
//     'This is a longer description for item 3. It contains more detailed information about the item.',
//     'This is a longer description for item 4. It contains more detailed information about the item.',
//     'This is a longer description for item 5. It contains more detailed information about the item.',
//   ];
//    final List<String> imageUrls = [
//      'https://via.placeholder.com/150',
//      'https://via.placeholder.com/150',
//      'https://via.placeholder.com/150',
//      'https://via.placeholder.com/150',
//      'https://via.placeholder.com/150',
//    ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Near Future'),
//       ),
//       body: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DetailScreen(),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: colors[index], width: 2.0),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(titles[index]),
//                     Text(descriptions[index]),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailScreen(),
//                           ),
//                         );
//                       },
//                       child: Text('Read More'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
