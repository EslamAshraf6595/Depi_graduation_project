import 'package:fitness_app/profile/settings.dart';
import 'package:fitness_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  static String routeName = 'profile';

  @override
  State<UserProfile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<UserProfile> {
  int selectedTab = 0;

  final List<List<String>> _tabImages = [
    [
      'https://images.unsplash.com/photo-1579758629938-03607ccdbaba',
      'https://images.unsplash.com/photo-1571019613914-85f342c8a22e',
      'https://images.unsplash.com/photo-1594737625785-cdef0f3e500d',
      'https://images.unsplash.com/photo-1599058917212-d750089bc07e',
    ],
    [
      'https://images.unsplash.com/photo-1598970434795-0c54fe7c0648',
      'https://images.unsplash.com/photo-1595152772835-219674b2a8a6',
      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61',
      'https://images.unsplash.com/photo-1605296867304-46d5465a13f1',
    ],
    [
      'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519',
      'https://images.unsplash.com/photo-1526401485004-2fda9f4a8ce9',
      'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb',
      'https://images.unsplash.com/photo-1550345332-09e3ac987658',
    ]
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.orangeAccent),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildUserInfo(userProvider.username!),
            const SizedBox(height: 16),
            _buildButtons(),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 10),
            Expanded(child: _buildPostsGrid()),
          ],
        ),
      ),
    );
  }

  // ---------------- Header ----------------

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1598970434795-0c54fe7c0648',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -35,
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Colors.orangeAccent,
            child: CircleAvatar(
              radius: 42,
              backgroundImage: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1595152772835-219674b2a8a6',
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- User Info ----------------

  Widget _buildUserInfo(String firstname) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0),
      child: Column(
        children: [
          Text(
            "${firstname}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Workout Streak: ",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "11 days ",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 14),
              ),
              Icon(Icons.local_fire_department,
                  color: Colors.orangeAccent, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Buttons ----------------

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _profileButton("Post Pump Picture", Icons.camera_alt),
        const SizedBox(width: 12),
        _profileButton("Post Pr Video", Icons.video_library),
      ],
    );
  }

  Widget _profileButton(String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A2A2D),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // ---------------- Tabs ----------------

  Widget _buildTabs() {
    final List<IconData> icons = [
      Icons.grid_on,
      Icons.video_collection_outlined,
      Icons.emoji_events_outlined,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(icons.length, (index) {
        final bool isActive = selectedTab == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () => setState(() => selectedTab = index),
            borderRadius: BorderRadius.circular(12),
            child: Icon(
              icons[index],
              color: isActive ? Colors.orangeAccent : Colors.grey,
              size: isActive ? 28 : 25,
            ),
          ),
        );
      }),
    );
  }

  // ---------------- Grid Images with Cache ----------------

  Widget _buildPostsGrid() {
    final images = _tabImages[selectedTab];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        itemCount: images.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
