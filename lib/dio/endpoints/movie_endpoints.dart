class MovieEndpoints {
  const MovieEndpoints._();

  static String popular(int page) => '/movie/popular?language=en_US&page=$page';

  static const String genres = '/genre/movie/list';
}
