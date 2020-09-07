type t = (string, string)

let countryCodes = list{
  "ae",
  "ar",
  "at",
  "au",
  "be",
  "bg",
  "br",
  "ca",
  "ch",
  "cn",
  "co",
  "cu",
  "cz",
  "de",
  "eg",
  "fr",
  "gb",
  "gr",
  "hk",
  "hu",
  "id",
  "ie",
  "il",
  "in",
  "it",
  "jp",
  "kr",
  "lt",
  "lv",
  "ma",
  "mx",
  "my",
  "ng",
  "nl",
  "no",
  "nz",
  "ph",
  "pl",
  "pt",
  "ro",
  "rs",
  "ru",
  "sa",
  "se",
  "sg",
  "si",
  "sk",
  "th",
  "tr",
  "tw",
  "ua",
  "us",
  "ve",
  "za",
}

let categories = list{
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
}

let languages = list{
  "ar",
  "de",
  "en",
  "es",
  "fr",
  "he",
  "it",
  "nl",
  "no",
  "pt",
  "ru",
  "se",
  "ud",
  "zh",
}

let country = countryCode => {
  let country = switch Belt.List.has(countryCodes, countryCode, (a, b) => a == b) {
  | true => countryCode
  | false => raise(Not_found)
  }
  ("country", country)
}

let category = categoryName => {
  let category = switch Belt.List.has(categories, categoryName, (a, b) => a == b) {
  | true => categoryName
  | false => raise(Not_found)
  }
  ("category", category)
}

let language = languageCode => {
  let language = switch Belt.List.has(languages, languageCode, (a, b) => a == b) {
  | true => languageCode
  | false => raise(Not_found)
  }
  ("language", language)
}

let stringParameter = (parameterName: string, stringValue: string) => {
  (parameterName, stringValue)
}

let intParameter = (parameterName: string, intValue: int) => {
  (parameterName, string_of_int(intValue))
}

let source = stringParameter("source")

let q = stringParameter("q")

let pageSize = intParameter("pageSize")

let page = intParameter("page")
let apiKey = stringParameter("apiKey")

let rec buildQuerystring = (~url=?, parameters) => {
  let url = switch url {
  | Some(url) => url
  | None => ""
  }
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
