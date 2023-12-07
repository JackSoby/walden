defmodule Walden.Repo do
  use Ecto.Repo,
    otp_app: :walden,
    adapter: Ecto.Adapters.Postgres
end
