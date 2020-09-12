type t = {apiKey: string}

let make = apiKey => {
  {apiKey: apiKey}
}

module Parameter = {
  type t = (string, string)

  let make = (name: string, value: string) => {
    (name, value)
  }

  let buildQuerystring = parameters => {
    Belt.List.reduce(parameters, "", (acc, item) => {
      let (name, value) = item
      switch acc {
      | "" => name ++ "=" ++ value
      | _ => acc ++ "&" ++ name ++ "=" ++ value
      }
    })
  }
}

module Article = {
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
}

module Source = {
  type t = {
    id: string,
    name: string,
    description: string,
    url: string,
    language: string,
    country: string,
  }

  let fromAPI = (apiSource: Fetcher.source) => {
    {
      id: apiSource.id,
      name: apiSource.name,
      description: apiSource.description,
      url: apiSource.url,
      language: apiSource.language,
      country: apiSource.country,
    }
  }
}

let topHeadlines = (api, parameters) => {
  Parameter.buildQuerystring(parameters)
  |> Fetcher.url(Fetcher.TopHeadlines)
  |> Fetcher.getFetchPromise(api.apiKey)
  |> Fetcher.getArticles(articles => Array.map(Article.fromAPI, articles))
}

let everything = (api, parameters) => {
  Parameter.buildQuerystring(parameters)
  |> Fetcher.url(Fetcher.Everything)
  |> Fetcher.getFetchPromise(api.apiKey)
  |> Fetcher.getArticles(articles => Array.map(Article.fromAPI, articles))
}

let sources = (api, parameters) => {
  Parameter.buildQuerystring(parameters)
  |> Fetcher.url(Fetcher.Sources)
  |> Fetcher.getFetchPromise(api.apiKey)
  |> Fetcher.getSources(sources => Array.map(Source.fromAPI, sources))
}
