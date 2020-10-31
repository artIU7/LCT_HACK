import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // configures your application
        if let databaseURL = Environment.get("DATABASE_URL") {
            app.databases.use(try .postgres(
                url: databaseURL
            ), as: .psql)
        } else {
            app.databases.use(.postgres(hostname: "localhost", username: "admin_metro_db", password: "", database: "metro_service_db"), as: .psql)
        }
    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
}
