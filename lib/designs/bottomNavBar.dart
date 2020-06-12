import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srmcapp/shared/colors.dart';

class BottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: ClipPath(
            clipper: NavBarClipper(),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      bottomNavBottomCenterColor,
                      bottomNavTopCenterColor
                    ]),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildNavItem(Icons.person_outline, false),
              SizedBox(
                width: 1,
              ),
              _buildNavItem(Icons.list, true),
              SizedBox(
                width: 1,
              ),
              _buildNavItem(Icons.favorite, false),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Profile',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                'List',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                'Favourite',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

_buildNavItem(IconData icon, bool active) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: bottomNavButtonColor,
    child: CircleAvatar(
      radius: 25,
      backgroundColor:
          active ? Colors.white.withOpacity(0.9) : Colors.transparent,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);

    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
