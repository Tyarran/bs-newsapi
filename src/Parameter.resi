type t

let country: string => t
let category: string => t
let language: string => t
let stringParameter: (string, string) => t
let intParameter: (string, int) => t
let source: string => t
let q: string => t
let pageSize: int => t
let page: int => t
let apiKey: string => t
let buildQuerystring: (~url: string=?, list<t>) => string
