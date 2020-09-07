type t

let make: string => t

let topHeadlines: (t, list<Parameter.t>) => Js.Promise.t<array<Article.t>>
let everything: (t, list<Parameter.t>) => Js.Promise.t<array<Article.t>>
let sources: (t, list<Parameter.t>) => Js.Promise.t<array<Source.t>>
