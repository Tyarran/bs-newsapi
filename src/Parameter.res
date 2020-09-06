module Country = {
  type t =
    | Ae
    | Ar
    | At
    | Au
    | Be
    | Bg
    | Br
    | Ca
    | Ch
    | Cn
    | Co
    | Cu
    | Cz
    | De
    | Eg
    | Fr
    | Gb
    | Gr
    | Hk
    | Hu
    | Id
    | Ie
    | Il
    | In
    | It
    | Jp
    | Kr
    | Lt
    | Lv
    | Ma
    | Mx
    | My
    | Ng
    | Nl
    | No
    | Nz
    | Ph
    | Pl
    | Pt
    | Ro
    | Rs
    | Ru
    | Sa
    | Se
    | Sg
    | Si
    | Sk
    | Th
    | Tr
    | Tw
    | Ua
    | Us
    | Ve
    | Za

  let make = countryName => {
    switch countryName {
    | "ae" => Ae
    | "ar" => Ar
    | "at" => At
    | "au" => Au
    | "be" => Be
    | "bg" => Bg
    | "br" => Br
    | "ca" => Ca
    | "ch" => Ch
    | "cn" => Cn
    | "co" => Co
    | "cu" => Cu
    | "cz" => Cz
    | "de" => De
    | "eg" => Eg
    | "fr" => Fr
    | "gb" => Gb
    | "gr" => Gr
    | "hk" => Hk
    | "hu" => Hu
    | "id" => Id
    | "ie" => Ie
    | "il" => Il
    | "in" => In
    | "it" => It
    | "jp" => Jp
    | "kr" => Kr
    | "lt" => Lt
    | "lv" => Lv
    | "ma" => Ma
    | "mx" => Mx
    | "my" => My
    | "ng" => Ng
    | "nl" => Nl
    | "no" => No
    | "nz" => Nz
    | "ph" => Ph
    | "pl" => Pl
    | "pt" => Pt
    | "ro" => Ro
    | "rs" => Rs
    | "ru" => Ru
    | "sa" => Sa
    | "se" => Se
    | "sg" => Sg
    | "si" => Si
    | "sk" => Sk
    | "th" => Th
    | "tr" => Tr
    | "tw" => Tw
    | "ua" => Ua
    | "us" => Us
    | "ve" => Ve
    | "za" => Za
    | _ => raise(Not_found)
    }
  }

  let toString = country => {
    switch country {
    | Ae => "ae"
    | Ar => "ar"
    | At => "at"
    | Au => "au"
    | Be => "be"
    | Bg => "bg"
    | Br => "br"
    | Ca => "ca"
    | Ch => "ch"
    | Cn => "cn"
    | Co => "co"
    | Cu => "cu"
    | Cz => "cz"
    | De => "de"
    | Eg => "eg"
    | Fr => "fr"
    | Gb => "gb"
    | Gr => "gr"
    | Hk => "hk"
    | Hu => "hu"
    | Id => "id"
    | Ie => "ie"
    | Il => "il"
    | In => "in"
    | It => "it"
    | Jp => "jp"
    | Kr => "kr"
    | Lt => "lt"
    | Lv => "lv"
    | Ma => "ma"
    | Mx => "mx"
    | My => "my"
    | Ng => "ng"
    | Nl => "nl"
    | No => "no"
    | Nz => "nz"
    | Ph => "ph"
    | Pl => "pl"
    | Pt => "pt"
    | Ro => "ro"
    | Rs => "rs"
    | Ru => "ru"
    | Sa => "sa"
    | Se => "se"
    | Sg => "sg"
    | Si => "si"
    | Sk => "sk"
    | Th => "th"
    | Tr => "tr"
    | Tw => "tw"
    | Ua => "ua"
    | Us => "us"
    | Ve => "ve"
    | Za => "za"
    }
  }
}

module Category = {
  type t =
    | Business
    | Entertainment
    | General
    | Health
    | Science
    | Sports
    | Technology

  let toString = category => {
    switch category {
    | Business => "business"
    | Entertainment => "entertainment"
    | General => "general"
    | Health => "health"
    | Science => "science"
    | Sports => "sports"
    | Technology => "technology"
    }
  }
}

module Language = {
  type t =
    | Ar
    | De
    | En
    | Es
    | Fr
    | He
    | It
    | Nl
    | No
    | Pt
    | Ru
    | Se
    | Ud
    | Zh

  let toString = language => {
    switch language {
    | Ar => "ar"
    | De => "de"
    | En => "en"
    | Es => "es"
    | Fr => "fr"
    | He => "he"
    | It => "it"
    | Nl => "nl"
    | No => "no"
    | Pt => "pt"
    | Ru => "ru"
    | Se => "se"
    | Ud => "ud"
    | Zh => "zh"
    }
  }
}

type t =
  | Country(Country.t)
  | Category(Category.t)
  | Source(string)
  | Q(string)
  | PageSize(int)
  | Page(int)
  | APIKey(string)
  | Language(Language.t)

let parameterReader = param => {
  switch param {
  | Country(country) => ("country", Country.toString(country))
  | Category(category) => ("category", Category.toString(category))
  | Source(value) => ("source", value)
  | Q(values) => ("q", values)
  | PageSize(value) => ("pageSize", string_of_int(value))
  | Page(value) => ("Page", string_of_int(value))
  | APIKey(value) => ("apiKey", value)
  | Language(language) => ("language", Language.toString(language))
  }
}

let rec buildQuerystring = (~url=?, params) => {
  let url = switch url {
  | Some(url) => url
  | None => ""
  }
  switch params {
  | list{} => url
  | list{param, ...rest} => {
      let (name, value) = parameterReader(param)
      let prefix = switch url {
      | "" => ""
      | _ => "&"
      }
      let newUrl = url ++ prefix ++ name ++ "=" ++ value
      buildQuerystring(~url=newUrl, rest)
    }
  }
}
