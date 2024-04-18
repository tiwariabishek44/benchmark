class Stream {
  final String name;
  final String image;

  Stream({
    required this.name,
    required this.image,
  });
}

List<Stream> allStreams = [
  Stream(
    image: 'assets/11science.png',
    name: '11 science',
  ),
  Stream(
    image: 'assets/12science.jpg',
    name: '12 science',
  ),
  Stream(
    image: 'assets/11management.jpg',
    name: '11 management',
  ),
  Stream(
    image: 'assets/12science.jpg',
    name: '12 management',
  ),
];
