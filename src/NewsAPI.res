type t = {apiKey: string}

let make = apiKey => {
  {apiKey: apiKey}
}

module Parameter = {
  type t = (string, string)

  let make = (name: string, value: string) => {
    (name, value)
  }

  let rec buildQuerystring = (~url="", parameters) => {
    switch parameters {
    | list{} => url
    | list{param, ...rest} => {
        let (name, value) = param
        let prefix = switch url {
        | "" => ""
        | _ => "&"
        }
        let newUrl = url ++ prefix ++ name ++ "=" ++ value
        buildQuerystring(~url=newUrl, rest)
      }
    }
  }
}

let topHeadlines = (api, parameters) => {
  open Js.Promise
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchArticles(
    api.apiKey,
    Fetcher.TopHeadlines,
    querystring,
  ) |> then_((response: Fetcher.articlePayload) => {
    Array.map(Article.fromAPI, response.articles) |> resolve
  })
}

let everything = (api, parameters) => {
  open Js.Promise
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchArticles(
    api.apiKey,
    Fetcher.Everything,
    querystring,
  ) |> then_((response: Fetcher.articlePayload) => {
    Array.map(Article.fromAPI, response.articles) |> resolve
  })
}

let sources = (api, parameters) => {
  open Js.Promise
  let querystring = Parameter.buildQuerystring(parameters)
  Fetcher.fetchSources(
    api.apiKey,
    Fetcher.Sources,
    querystring,
  ) |> then_((response: Fetcher.sourcePayload) => {
    Array.map(Source.fromAPI, response.sources) |> resolve
  })
}
