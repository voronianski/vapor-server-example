import Vapor

let drop = Droplet()

drop.get("hello") { req in
  return "Hello, Vapor!"
}

drop.get("hash", String.self) { req, name in
  return try drop.hash.make(name)
}

drop.get("json") { req in
  return try JSON(node: [
    "foo": "bar",
    "num": 123,
    "array": [1, 2, 3],
    "dict": [
      "name": "Vapor",
      "lang": "Swifty"
    ]
  ])
}

drop.run()
