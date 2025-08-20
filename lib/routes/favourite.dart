import 'package:coffeshop/models/coffee.dart';
import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/widgets/coffecart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();
  String toSearch = "";
  late List<Map> favs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
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
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<CoffeeProvider>(
      builder: (context, coffeeProvider, _) {
        favs = coffeeProvider.favorites;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Your Favourite coffees !!",
                style: TextStyle(color: Colors.white, fontSize: 27),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(
                controller: _textController,
                textStyle: const WidgetStatePropertyAll(
                  TextStyle(color: Colors.white),
                ),
                hintText: 'Find your coffee',
                hintStyle: const WidgetStatePropertyAll(
                  TextStyle(color: Colors.grey, fontSize: 18),
                ),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20),
                ),
                backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 49, 51, 54),
                ),
                leading: const Icon(Icons.search, size: 30, color: Colors.grey),
                onChanged: (query) => setState(() => toSearch = query),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                dividerHeight: 0,
                isScrollable: true,
                indicatorColor: const Color(0xffe57734),
                labelColor: const Color(0xffe57734),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: Color(0xffe57734)),
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
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
                children: [
                  _buildTabContent("all"),
                  _buildTabContent("Milk-Based"),
                  _buildTabContent("Strong"),
                  _buildTabContent("Classic"),
                  _buildTabContent("Cold"),
                  _buildTabContent("Chocolate-Based"),
                  _buildTabContent("Dessert"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(String type) {
    final List<Map> allFavs = favs; // favs is set in builder via provider

    List<Map> coffeeList = type == "all"
        ? allFavs
        : allFavs.where((c) => c['type'] == type).toList();

    if (toSearch.isNotEmpty) {
      RegExp regex = RegExp('^$toSearch', caseSensitive: false);
      coffeeList =
          coffeeList.where((item) => regex.hasMatch(item['name'])).toList();
    }

    if (coffeeList.isEmpty) {
      return const Center(
        child: Text(
          'No favorites found',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: coffeeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return CoffeCart(coffe: coffeeList[index]);
        },
      ),
    );
  }
}
