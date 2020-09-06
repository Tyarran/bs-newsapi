type t = {apiKey: string}

let make = apiKey => {
  {apiKey: apiKey}
}

let topHeadlines = (api, parameters) => {
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchArticles(api.apiKey, Fetcher.TopHeadlines, querystring) |> Js.Promise.then_(data => {
    switch data {
    | Ok(value: Fetcher.articleResponse) => {
        let articles = value.articles |> Array.map(Article.fromAPI)
        Ok(articles) |> Js.Promise.resolve
      }
    | Error(value) => Error(value) |> Js.Promise.resolve
    }
  })
}

let everything = (api, parameters) => {
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchArticles(api.apiKey, Fetcher.Everything, querystring) |> Js.Promise.then_(data => {
    switch data {
    | Ok(value: Fetcher.articleResponse) => {
        let articles = value.articles |> Array.map(Article.fromAPI)
        Ok(articles) |> Js.Promise.resolve
      }
    | Error(value) => Error(value) |> Js.Promise.resolve
    }
  })
}

let sources = (api, parameters) => {
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchSources(api.apiKey, Fetcher.Sources, querystring) |> Js.Promise.then_(data => {
    switch data {
    | Ok(value: Fetcher.sourceResponse) => {
        let sources = value.sources |> Array.map(Source.fromAPI)
        Ok(sources) |> Js.Promise.resolve
      }
    | Error(value) => Error(value) |> Js.Promise.resolve
    }
  })
}
