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
