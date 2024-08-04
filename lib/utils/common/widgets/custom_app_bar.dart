// import 'package:flutter/material.dart';

// /// ::::: Common App Bar :::::

// AppBar commonAppBarWidget({
//   required Size size,
//   required VoidCallback onTapBack,
//    VoidCallback? onTapProfile,
//   Color? backgroundColor = Colors.transparent,
//   bool showAction = true,
// }) {
//   return AppBar(
//     scrolledUnderElevation: 0.0,
//     backgroundColor: backgroundColor ?? Colors.transparent,

//     /// Back-button
//     leading: InkWell(
//       onTap: onTapBack,
//       splashColor: CommonColor.whiteColor,
//       highlightColor: CommonColor.whiteColor,
//       child: Container(
//         height: size.width * numD12,
//         width: size.width * numD12,
//         margin: EdgeInsets.all(size.width * numD025),
//         padding: EdgeInsets.all(size.width * numD015),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               blurRadius: 2,
//               offset: const Offset(0, 1),
//             ),
//           ],
//           color: Colors.white,
//         ),
//         child: Image.asset(
//           'assets/icons/ic_back.png',
//           fit: BoxFit.contain,
//         ),
//       ),
//     ),
//     automaticallyImplyLeading: false,

//     actions: [
//       if (showAction)
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * numD035),
//           child: InkWell(
//             splashColor: CommonColor.whiteColor,
//             highlightColor: CommonColor.whiteColor,
//             onTap: onTapProfile,
//             child: ClipOval(
//               child: Image.network(
//                 imageBaseURL +
//                     otherUsersData[0][PreferenceKeys.profileImageKey],
//                 height: size.width * numD1,
//                 width: size.width * numD1,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         )
//     ],
//   );
// }
