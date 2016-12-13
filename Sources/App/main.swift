import Vapor
import VaporMongo

let drop = Droplet()

// add mongodb provider
try drop.addProvider(VaporMongo.Provider.self)

// add Fluent model preparations
drop.preparations.append(Post.self)

// add middleware to all endpoints
drop.middleware.append(CorsMiddleware())

// Plain text
drop.get("hello") { _ in
  return "Hello, Vapor!"
}

// Hashing the param
drop.get("hash", String.self) { req, name in
  return try drop.hash.make(name)
}

// Responding JSON on GET
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

// Accessing JSON on POST
drop.post("json") { req in
  return try JSON(node: [
    "data": req.json
  ])
}

// Request params and query
drop.get("data", Int.self) { req, int in
  return try JSON(node: [
    "int": int,
    "hello": req.data["hello"]?.string,
    "name": req.query?["name"] ?? "no name"
  ])
}

// Plain html
drop.get("html") { _ in
  return try drop.view.make("index.html")
}

// Templating with leaf
drop.get("leaf") { req in
  return try drop.view.make("page", [
    "name": req.query?["name"] ?? "Stranger"
  ])
}

// Proxy data requests
drop.get("image") { req in
  return try drop.client.get("http://example.vapor.codes/images/vapor-logo.png")
}

// Fluent models and controller example
let posts = PostController()
drop.resource("posts", posts)

drop.run()
