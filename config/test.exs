use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :multiple_select_example, MultipleSelectExampleWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :multiple_select_example, MultipleSelectExample.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "multiple_select_example_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
