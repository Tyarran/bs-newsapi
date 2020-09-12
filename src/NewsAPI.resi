type t

let make: string => t

module Parameter: {
  type t

  let make: (string, string) => t
  let buildQuerystring: list<t> => string
}

module Article: {
  type t

  let fromAPI: Fetcher.article => t
}

module Source: {
  type t

  let fromAPI: Fetcher.source => t
}

let topHeadlines: (t, list<Parameter.t>) => Js.Promise.t<array<Article.t>>
let everything: (t, list<Parameter.t>) => Js.Promise.t<array<Article.t>>
let sources: (t, list<Parameter.t>) => Js.Promise.t<array<Source.t>>
