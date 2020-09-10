open Jest
open Expect
open Parameter

describe("Parameter tests", () => {
  test("Test buildQueryString", () => {
    let parameters = list{make("name", "value")}
    expect(buildQuerystring(parameters)) |> toBe("name=value")
  })

  test("Test buildQueryString with multiple parametes", () => {
    let parameters = list{
      make("name", "value"),
      make("otherName", "otherValue"),
    }
    expect(buildQuerystring(parameters)) |> toBe("name=value&otherName=otherValue")
  })

})
