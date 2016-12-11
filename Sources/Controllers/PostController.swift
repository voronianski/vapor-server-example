import HTTP
import Vapor

final class PostController: ResourceRepresentable {
  func index(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: [
      "route": "index"
    ])
  }

  func create(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: [
      "route": "create"
    ])
  }

  func makeResource() -> Resource<Post> {
    return Resource(
      index: index,
      store: create
    )
  }
}
