import Vapor
import VaporMongo

let drop = Droplet()

try drop.addProvider(VaporMongo.Provider.self)

drop.get("hello") { _ in
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

drop.get("data", Int.self) { req, int in
  return try JSON(node: [
    "int": int,
    "hello": req.data["hello"]?.string,
    "name": req.query?["name"] ?? "no name"
  ])
}

drop.get("html") { _ in
  return try drop.view.make("index.html")
}

drop.get("leaf") { req in
  return try drop.view.make("page", [
    "name": req.query?["name"] ?? "Stranger"
  ])
}

let posts = PostController(droplet: drop)
drop.resource("posts", posts)

drop.run()
