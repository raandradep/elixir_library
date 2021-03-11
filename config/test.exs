use Mix.Config

config :library_mongo, LibraryMongo.Repo,
  url: "mongodb://localhost:27017",
  username: "root",
  password: "example",
  database: "admin",
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :library_mongo, LibraryMongoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
