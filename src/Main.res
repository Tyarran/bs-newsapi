@bs.scope("process") @bs.val external env: Js.Dict.t<string> = "env"

let apiKey = switch Js.Dict.get(env, "NEWSAPI_API_KEY") {
| Some(value) => value
| None => raise(Not_found)
}
let api = NewsAPI.make(apiKey)

let parameters = list{
  NewsAPI.Parameter.make("country", "fr"),
  NewsAPI.Parameter.make("category", "health"),
}

let other = list{NewsAPI.Parameter.make("language", "fr"), NewsAPI.Parameter.make("q", "bitcoin")}

NewsAPI.topHeadlines(api, parameters) |> Js.Promise.then_(value =>
  Js.log(value) |> Js.Promise.resolve
)
NewsAPI.everything(api, other) |> Js.Promise.then_(value => Js.log(value) |> Js.Promise.resolve)
NewsAPI.sources(api, list{}) |> Js.Promise.then_(value => Js.log(value) |> Js.Promise.resolve)
