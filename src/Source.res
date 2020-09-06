type source = {
  id: string,
  name: string,
  description: string,
  url: string,
  language: string,
  country: string,
}

let fromAPI = (apiSource: Fetcher.source) => {
  {
    id: apiSource.id,
    name: apiSource.name,
    description: apiSource.description,
    url: apiSource.url,
    language: apiSource.language,
    country: apiSource.country,
  }
}
