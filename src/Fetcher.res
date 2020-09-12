%%raw(`require('isomorphic-fetch')`)

let baseUrl = "https://newsapi.org/v2/"

type sourceReference = {
  id: option<string>,
  name: string,
}

type article = {
  source: sourceReference,
  author: option<string>,
  title: string,
  description: string,
  url: string,
  urlToImage: string,
  publishedAt: string,
  content: string,
}

type source = {
  id: string,
  name: string,
  description: string,
  url: string,
  language: string,
  country: string,
}

type articlePayload = {
  status: string,
  totalResults: int,
  articles: array<article>,
}

type sourcePayload = {
  status: string,
  sources: array<source>,
}

type endpoint = TopHeadlines | Everything | Sources

@bs.scope("JSON") @bs.val external parseArticleResponse: string => articlePayload = "parse"
@bs.scope("JSON") @bs.val external parseSourceResponse: string => sourcePayload = "parse"

let url = (endpoint, querystring) => {
  switch endpoint {
  | TopHeadlines => baseUrl ++ "top-headlines?" ++ querystring
  | Everything => baseUrl ++ "everything?" ++ querystring
  | Sources => baseUrl ++ "sources?" ++ querystring
  }
}

let fetch = promise => {
  promise |> Js.Promise.then_(Fetch.Response.text) |> Js.Promise.catch(error => {
    Js.log(error)
    "error " |> Js.Promise.resolve
  })
}

let getFetchPromise = (apiKey, url) => {
  Fetch.fetchWithInit(
    url,
    Fetch.RequestInit.make(
      ~headers=Fetch.HeadersInit.make({"Authorization": "Bearer " ++ apiKey}),
      (),
    ),
  )
}

let getArticles = (readArticles, promise) => {
  fetch(promise) |> Js.Promise.then_(text => {
    let payload = parseArticleResponse(text)
    readArticles(payload.articles) |> Js.Promise.resolve
  })
}

let getSources = (readSources, promise) => {
  fetch(promise) |> Js.Promise.then_(text => {
    let payload = parseSourceResponse(text)
    readSources(payload.sources) |> Js.Promise.resolve
  })
}
