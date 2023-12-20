class MyNews {
  final String title;
  final String image;
  final String description;
  final String pubDate;
  final List<String> content;

  MyNews({
    required this.title,
    required this.image,
    required this.description,
    required this.pubDate,
    required this.content,
  });
}

// Create a sample instance of MyNews
MyNews sampleNews = MyNews(
  title: "Sample News Title",
  image: "https://example.com/sample-image.jpg",
  description: "This is a sample news description.",
  pubDate: "October 6, 2023",
  content: [
    "This is the content of the news article.",
    "<i>This is italic text.</i>",
    "<b>This is bold text.</b>",
    '<a href="https://example.com">Visit Example</a>',
  ],
);