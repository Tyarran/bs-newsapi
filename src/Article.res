type sourceReference = {
  id: option<string>,
  name: string,
}

type t = {
  source: sourceReference,
  author: option<string>,
  title: string,
  description: string,
  url: string,
  urlToImage: string,
  publishedAt: Js.Date.t,
  content: string,
}

let sourceRefFromAPI = (apiSource: Fetcher.sourceReference) => {
  {
    id: apiSource.id,
    name: apiSource.name,
  }
}

let fromAPI = (apiArticle: Fetcher.article) => {
  {
    source: sourceRefFromAPI(apiArticle.source),
    author: apiArticle.author,
    title: apiArticle.title,
    description: apiArticle.description,
    url: apiArticle.url,
    urlToImage: apiArticle.urlToImage,
    publishedAt: Js.Date.fromString(apiArticle.publishedAt),
    content: apiArticle.content,
  }
}
