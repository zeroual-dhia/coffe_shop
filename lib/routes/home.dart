import 'package:coffeshop/models/coffee.dart';
import 'package:coffeshop/models/navigation.dart';
import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/routes.dart';
import 'package:coffeshop/routes/carte.dart';
import 'package:coffeshop/routes/favourite.dart';
import 'package:coffeshop/routes/loading.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/coffecart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();
  String toSearch = "";
  final Map<String, List> _coffeeCache = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    // Remove the listener that causes rebuilds
    // _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const Loading();
    }

    final pages = [_buildMainBody(), const Favourite(), const Cart()];

    return ChangeNotifierProvider(
      create: (context) => CoffeeProvider(user.uid),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212325),
          leading: InkWell(
            onTap: () {},
            child: const Icon(Icons.sort_rounded, color: Colors.grey, size: 35),
          ),
          actions: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => Navigator.pushNamed(context, RouteGenerator.profile),
              child: const Icon(Icons.person, size: 35, color: Colors.grey),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Consumer<NavigationProvider>(
          builder: (context, navigation, child) {
            return pages[navigation.getIndex];
          },
        ),
        bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (context, navigation, child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              selectedItemColor: const Color(0xffe57734),
              unselectedItemColor: Colors.white,
              iconSize: 28,
              backgroundColor: const Color(0xff212325),
              currentIndex: navigation.getIndex,
              onTap: (index) => navigation.ChangePage(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: " "),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: " "),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_shopping_cart), label: " "),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainBody() {
    print("main running");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("It's a great day for coffee",
              style: TextStyle(color: Colors.white, fontSize: 27)),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar(
            controller: _textController,
            textStyle:
                const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
            hintText: 'Find your coffee',
            hintStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.grey, fontSize: 18)),
            shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20)),
            backgroundColor:
                const WidgetStatePropertyAll(Color.fromARGB(255, 49, 51, 54)),
            leading: const Icon(Icons.search, size: 30, color: Colors.grey),
            onChanged: (query) => setState(() => toSearch = query),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            dividerHeight: 0,
            isScrollable: true,
            controller: _tabController,
            indicatorColor: const Color(0xffe57734),
            labelColor: const Color(0xffe57734),
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: Color(0xffe57734)),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Milk-Based"),
              Tab(text: "Strong"),
              Tab(text: "Classic"),
              Tab(text: "Cold"),
              Tab(text: "Chocolate-Based"),
              Tab(text: "Dessert"),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            children: [
              _TabContent(
                  coffeeType: "all", toSearch: toSearch, onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Milk-Based",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Strong",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Classic",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Cold",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Chocolate-Based",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
              _TabContent(
                  coffeeType: "Dessert",
                  toSearch: toSearch,
                  onFetch: _fetchCoffee),
            ],
          ),
        ),
      ],
    );
  }

  Future<List> _fetchCoffee(String coffeeType) async {
    if (_coffeeCache.containsKey(coffeeType)) {
      return _coffeeCache[coffeeType]!;
    }

    try {
      final url = coffeeType == "all"
          ? 'http://172.20.10.2:3000/coffee'
          : 'http://172.20.10.2:3000/coffee?type=$coffeeType';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _coffeeCache[coffeeType] = data;
        return data;
      } else {
        throw Exception(
            'Failed to load data - Status Code: ${response.statusCode}');
      }
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }
}

class _TabContent extends StatefulWidget {
  final String coffeeType;
  final String toSearch;
  final Future<List> Function(String) onFetch;

  const _TabContent({
    required this.coffeeType,
    required this.toSearch,
    required this.onFetch,
  });

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    print("TabContent building: ${widget.coffeeType}");

    return FutureBuilder(
      future: widget.onFetch(widget.coffeeType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Failed to load data',
                  style: TextStyle(color: Colors.white)));
        } else {
          List coffeeList = snapshot.data as List;
          if (widget.toSearch.isNotEmpty) {
            RegExp regex = RegExp('^${widget.toSearch}', caseSensitive: false);
            coffeeList = coffeeList
                .where((item) => regex.hasMatch(item['name']))
                .toList();
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                return CoffeCart(coffe: coffeeList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
