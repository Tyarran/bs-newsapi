%%raw(`require('isomorphic-fetch')`)

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

type articleResponse = {
  status: string,
  totalResults: int,
  articles: array<article>,
}

type sourceResponse = {
  status: string,
  sources: array<source>,
}

type endpoint = TopHeadlines | Everything | Sources

@bs.scope("JSON") @bs.val external parseArticleResponse: string => articleResponse = "parse"
@bs.scope("JSON") @bs.val external parseSourceResponse: string => sourceResponse = "parse"

let rec buildQuerystring = (~url=?, params, paramReader) => {
  let url = switch url {
  | Some(url) => url
  | None => ""
  }
  switch params {
  | list{} => url
  | list{param, ...rest} => {
      let (name, value) = paramReader(param)
      let prefix = switch url {
      | "" => ""
      | _ => "&"
      }
      let newUrl = url ++ prefix ++ name ++ "=" ++ value
      buildQuerystring(~url=newUrl, rest, paramReader)
    }
  }
}

let fetch = (apiKey, endpoint, querystring) => {
  let url = switch endpoint {
  | TopHeadlines => "https://newsapi.org/v2/top-headlines?" ++ querystring
  | Everything => "https://newsapi.org/v2/everything?" ++ querystring
  | Sources => "https://newsapi.org/v2/sources?" ++ querystring
  }
  Fetch.fetchWithInit(
    url,
    Fetch.RequestInit.make(
      ~headers=Fetch.HeadersInit.make({"Authorization": "Bearer " ++ apiKey}),
      (),
    ),
  )
  |> Js.Promise.then_(Fetch.Response.text)
  |> Js.Promise.then_(text => Ok(text) |> Js.Promise.resolve)
  |> Js.Promise.catch(_ => Error("Error") |> Js.Promise.resolve)
}

let fetchArticles = (apiKey, endpoint, querystring) => {
  let response = fetch(apiKey, endpoint, querystring)
  response |> Js.Promise.then_(responseText => {
    switch responseText {
    | Ok(text) => {
        let response = parseArticleResponse(text)
        switch response.status {
        | "ok" => Ok(response)
        | _ => Error(text)
        } |> Js.Promise.resolve
      }
    | Error(text) => Error(text) |> Js.Promise.resolve
    }
  })
}

let fetchSources = (apiKey, endpoint, querystring) => {
  let response = fetch(apiKey, endpoint, querystring)
  response |> Js.Promise.then_(responseText => {
    switch responseText {
    | Ok(text) => {
        let response = parseSourceResponse(text)
        switch response.status {
        | "ok" => Ok(response)
        | _ => Error(text)
        } |> Js.Promise.resolve
      }
    | Error(text) => Error(text) |> Js.Promise.resolve
    }
  })
}
