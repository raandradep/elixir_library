use Mix.Config

config :library_mongo, MongoHandler,
  url: "mongodb://localhost:27017",
  username: "library_user",
  password: "123456",
  database: "library_db",
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :library_mongo, LibraryMongoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
