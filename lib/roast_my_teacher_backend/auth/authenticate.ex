defmodule RMT.Auth.Authenticate do

  import Comeonin.Bcrypt
  import Ecto.Query, only: [from: 2]
  alias RMT.Auth.Key
  alias RMT.Repo

   def gen_access_token(id) do
      #TODO: Check for valid ID
      hash = hashpwsalt(id)
      case Repo.one(from k in Key, where: k.hash == ^hash) do
        nil ->
          key = Key.changeset(%Key{}, %{"hash" => hash})
          Repo.insert!(key)
          {:ok, hash}

        key -> {:ok, key.hash}
      end
   end

   def verify(access_token) do
    case Repo.one(from k in Key, where: k.hash == ^access_token) do
      key ->
        :ok
      nil ->
        :invalid
    end
   end

end