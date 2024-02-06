import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteListCard extends StatefulWidget {
  const FavouriteListCard({Key? key}) : super(key: key);

  @override
  State<FavouriteListCard> createState() => _FavouriteListCardState();
}

class _FavouriteListCardState extends State<FavouriteListCard> {
  List<Quote> _favoriteQuotes = [];
  bool _isLoading = true;
  // bool isFavorite = true;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    // Simulate loading data
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // Initialize your favorite quotes here, or fetch them from a database
        _favoriteQuotes = [
          Quote(content: "Favorite quote 1", author: "Author 1"),
          Quote(content: "Favorite quote 2", author: "Author 2"),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(209, 196, 233, 1),
        appBar: appBar(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _favoriteQuotes.isNotEmpty
                ? ListView.builder(
                    itemCount: _favoriteQuotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: IntrinsicHeight(
                          child: _buildQuoteContainer(
                            _favoriteQuotes[index].content,
                            _favoriteQuotes[index].author,
                            index,
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No favourites',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .4,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildQuoteContainer(String quote, String author, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 10),
            child: Text(
              quote,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .4,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Toggle isFavorite status and show snackbar
                  setState(() {
                    _favoriteQuotes[index].isFavorite =
                        !_favoriteQuotes[index].isFavorite;

                    if (!_favoriteQuotes[index].isFavorite) {
                      // If the quote is removed from favorites, remove it from the list
                      _favoriteQuotes.removeWhere((quote) => !quote.isFavorite);
                    }
                  });

                  final snackBar = SnackBar(
                    backgroundColor: _favoriteQuotes[index].isFavorite
                        ? Colors.green
                        : Colors.red,
                    content: Text(
                      _favoriteQuotes[index].isFavorite
                          ? 'Added to Favorites'
                          : 'Removed from Favorites',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );

                  const Duration(microseconds: 3);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: Icon(
                  _favoriteQuotes[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.deepPurple,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 30, bottom: 5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "-$author",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.deepPurple.shade400,
      foregroundColor: Colors.black,
      title: Text(
        "Favorites",
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class Quote {
  final String content;
  final String author;
  bool isFavorite;

  Quote({required this.content, required this.author, this.isFavorite = false});
}
