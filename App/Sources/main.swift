import Vapor

let drop = Droplet()

drop.get("hello") { req in
  return "Hello, Vapor!"
}

drop.get("hash", String.self) { req, name in
  return try drop.hash.make(name)
}

drop.run()
