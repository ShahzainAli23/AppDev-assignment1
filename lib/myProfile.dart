import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myProfile extends StatefulWidget {
  @override
  myProfileState createState() => myProfileState();
}

class myProfileState extends State<myProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int postCount;
  late int commentCount;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    postCount = _posts.length;
    commentCount = _comments.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildProfileHeader(),
          TabBar(
            controller: _tabController,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: "Posts"),
              Tab(text: "Comments"),
              Tab(text: "Stats"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPostsSection(),
                _buildCommentsSection(),
                _buildStatsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: ProfileHeaderClipper(),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        Positioned(
          top: 140,
          child: CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
        ),
        Positioned(
          top: 290,
          child: Column(
            children: [
              Text(
                "Shahzain Ali",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "CS Student at IBA, trying to learn flutter :(",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsSection() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _buildEventCard(
          _posts[index]['title']!,
          _posts[index]['dateTime']!,
          _posts[index]['location']!,
          _posts[index]['host']!,
          _posts[index]['imagePath']!,
        );
      },
    );
  }

  Widget _buildCommentsSection() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return _buildCommentTile(
          _comments[index]['title']!,
          _comments[index]['comment']!,
          _comments[index]['date']!,
        );
      },
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem(postCount.toString(), "Posts"),
            _buildStatItem(commentCount.toString(), "Comments"),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String dateTime,
    String location,
    String host,
    String imagePath,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 6, offset: Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    dateTime,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    host,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentTile(String title, String comment, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 0),
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          leading: Transform.translate(
            offset: Offset(0, -12),
            child: Transform.rotate(
              angle: 3.14 / 2,
              child: Icon(
                Icons.subdirectory_arrow_left,
                color: Colors.grey[400],
                size: 24,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"$comment"',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Color.fromARGB(255, 114, 114, 114),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.8, color: Colors.grey[300]),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }
}

List<Map<String, String>> _posts = [
  {
    "title": "Pakistan vs New Zealand",
    "dateTime": "19 Feb 2025, 02:00 PM",
    "location": "National Stadium, Karachi",
    "host": "Shahzain Ali",
    "imagePath": "assets/event1.jpg",
  },
  {
    "title": "IBA Con",
    "dateTime": "23 Feb 2025, 12:00 PM",
    "location": "IBA Karachi, KU",
    "host": "Shahzain Ali",
    "imagePath": "assets/event2.jpg",
  },
  {
    "title": "DAA PSet Submission Meeting",
    "dateTime": "3 March 2025, 11:30 PM",
    "location": "FSF Headquarters, Classified Info",
    "host": "Shahzain Ali",
    "imagePath": "assets/event3.jpg",
  },
  {
    "title": "Fatima Birthday!!!",
    "dateTime": "18 March 2025, 12:00 AM",
    "location": "Sakhi Hassan, Nazimabad",
    "host": "Shahzain Ali",
    "imagePath": "assets/event4.jpg",
  },
  {
    "title": "Eid",
    "dateTime": "31 March 2025, 06:30 AM",
    "location": "NORE-1, Mai Kolachi",
    "host": "Shahzain Ali",
    "imagePath": "assets/event5.jpeg",
  },
];

List<Map<String, String>> _comments = [
  {
    "title": "Pak vs NZ",
    "comment":
        "Looking forward to that match! Me Predicts Dat Pak Shall Win!!!",
    "date": "19 February 2025, 02:00 PM",
  },
  {
    "title": "IBA Con",
    "comment": "Can't go due to match :(",
    "date": "23 February 2025, 12:00 PM",
  },
  {
    "title": "DAA PSet meeting",
    "comment": "I'm scared...",
    "date": "3 March 2025, 11:30 PM",
  },
  {
    "title": "Fatima Birthday",
    "comment": "HOW WE GON EAT DURING RAMZANNNNN",
    "date": "18 March 2025, 12:00 AM",
  },
  {
    "title": "Eid",
    "comment": "Can you please describe what exactly we'll be doing?",
    "date": "31 March 2025, 06:30 AM",
  },
];

class ProfileHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 180); // Start from the left bottom

    // First curve (rising up)
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 230,
      size.width * 0.5,
      size.height - 180,
    );

    // Second curve (going down)
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 130,
      size.width,
      size.height - 180,
    );

    path.lineTo(size.width, 0); // Right top corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
