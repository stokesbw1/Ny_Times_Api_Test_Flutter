part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleError extends ArticleState {}

class ArticleErrorLoadingBrowser extends ArticleState {
  final String url;

  const ArticleErrorLoadingBrowser({required this.url});

  @override
  List<Object> get props => [url];
}

class ArticleSuccess extends ArticleState {
  final List<Article> articles;
  final bool isConnected;

  const ArticleSuccess( {required this.isConnected, required this.articles});

  @override
  List<Object> get props => [articles, isConnected];
}
