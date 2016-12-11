import Vapor
import HTTP

final class PostController {
  func index(_ request: Request) throws -> ResponseRepresentable {
    return try JSON(node: ["index": "yes"])
  }

  func create(_ request: Request) throws -> ResponseRepresentable {
    guard let json = request.json else {
      throw Abort.badRequest
    }

    var post = try Post(node: json)
    try post.save()
    return post
  }

  func show(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    return post
  }

  func replace(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    return try JSON(node: ["replace": "yes"])
  }

  func update(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    return try JSON(node: ["update": "yes"])
  }

  func delete(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    return try JSON(node: ["delete": "yes"])
  }
}

extension PostController: ResourceRepresentable {
  func makeResource() -> Resource<Post> {
    return Resource(
      index: index,
      store: create,
      show: show,
      replace: replace,
      modify: update,
      destroy: delete
    )
  }
}
