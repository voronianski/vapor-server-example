import HTTP
import JSON
import Vapor

class CorsMiddleware: Middleware {
  func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    // check if it is preflight request
    if request.method == .options && request.headers["Access-Control-Request-Method"] != nil {
      return Response(status: .noContent)
    }

    // immediately pass to next as we will modify response only
    let response = try next.respond(to: request)

    response.headers["Access-Control-Allow-Origin"] = request.headers["Origin"] ?? "*"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With,Origin,Content-Type,Accept"
    response.headers["Access-Control-Allow-Methods"] = "POST,GET,PUT,OPTIONS,DELETE,PATCH"

    return response
  }
}
