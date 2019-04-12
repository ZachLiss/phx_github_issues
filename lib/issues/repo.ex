defmodule Issues.Repo do
  use Ecto.Repo,
    otp_app: :issues,
    adapter: Ecto.Adapters.Postgres
end
