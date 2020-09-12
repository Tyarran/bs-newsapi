open Jest
open Expect
open NewsAPI

describe("Parameter tests", () => {
  test("Test buildQueryString", () => {
    let parameters = list{Parameter.make("name", "value")}
    expect(Parameter.buildQuerystring(parameters)) |> toBe("name=value")
  })

  test("Test buildQueryString with multiple parametes", () => {
    let parameters = list{
      Parameter.make("name", "value"),
      Parameter.make("otherName", "otherValue"),
    }
    expect(Parameter.buildQuerystring(parameters)) |> toBe("name=value&otherName=otherValue")
  })
})
