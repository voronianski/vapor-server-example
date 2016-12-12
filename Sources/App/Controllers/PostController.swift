import Vapor
import HTTP

final class PostController {
  func index(_ request: Request) throws -> ResponseRepresentable {
    return try Post.all().makeNode().converted(to: JSON.self)
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

  func update(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    guard let json = request.json else {
      throw Abort.badRequest
    }

    let updates = try Post(node: json)
    var post = post

    post.merge(updates)
    try post.save()

    return post
  }

  func delete(_ request: Request, _ post: Post) throws -> ResponseRepresentable {
    try post.delete()

    return JSON([:])
  }

  func clear(_ request: Request) throws -> ResponseRepresentable {
    try Post.query().delete()

    return JSON([])
  }
}

extension PostController: ResourceRepresentable {
  func makeResource() -> Resource<Post> {
    return Resource(
      index: index,
      store: create,
      show: show,
      modify: update,
      destroy: delete,
      clear: clear
    )
  }
}
