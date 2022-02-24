import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :inmana, Inmana.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "inmana_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :inmana, InmanaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+4kK0p/7l4u7esw6ewqQbIM2BdEkV22P/3kOFIKABD4pCdrH+T1hRjyQD4VsOOyo",
  server: false

config :inmana, Inmana.Mailer, adapter: Bamboo.TestAdapter

# In test we don't send emails.
# config :inmana, Inmana.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
