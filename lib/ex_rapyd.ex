defmodule ExRapyd do
  @moduledoc """
  Elixir wrapper for the Rapyds API
  """

  @doc """
  Create a client to be used with each HTTP function (`get`, `post`, etc.) using default settings
  from `config.exs` or dynamically in runtime

  ## Examples
      iex> ExRapyd.client
      %Tesla.Client{
        pre: [
          {Tesla.Middleware.BaseUrl, :call, ["https://sandboxapi.rapyd.net/v1"]},
          {Tesla.Middleware.JSON, :call, [[]]},
          {Tesla.Middleware.Query, :call, [[]]},
          {Tesla.Middleware.Headers, :call, [[{"Content-Type", "application/json"}, {"access_key", "..."} ... ]]},
          {Tesla.Middleware.PathParams, :call, [[]]}
        ]}

  Returns
  %Tesla.Client{}

  """

  require Logger

  def client(%{path: path, http_method: http_method, body: body} = _settings, options \\ [])
    when is_binary(http_method) and is_binary(path) do
    defaults = %{
      base_url: Application.get_env(:ex_rapyd, :base_url),
      access_key: Application.get_env(:ex_rapyd, :access_key),
      secret_key: Application.get_env(:ex_rapyd, :secret_key),
      api_version: Application.get_env(:ex_rapyd, :api_version)
    }

    # Pattern match to extract values from options or use default configs
    %{
      base_url: base_url,
      access_key: access_key,
      secret_key: secret_key,
      api_version: api_version
    } = Enum.into(options, defaults)

    path = "#{api_version}#{path}"
    salt = create_salt()
    timestamp = create_timestamp()

    Logger.debug "#### Access key: #{access_key}"
    Logger.debug "#### Secret key: #{secret_key}"
    Logger.debug "#### Path: #{path}"
    Logger.debug "#### Salt: #{salt}"
    Logger.debug "#### Timestamp: #{timestamp}"
    
    # Signature is hash of a concatenation of specific strings according to the formula according to
    # https://docs.rapyd.net/build-with-rapyd/reference/message-security#request-signatures
    # signature = BASE64 ( HASH ( http_method + url_path + salt + timestamp + access_key + secret_key + body_string ) )
    to_sign = create_to_sign(http_method, path, salt, timestamp, access_key, secret_key, body)
    
    mac = :crypto.mac(:hmac, :sha256, secret_key, to_sign) |> Base.encode16(case: :lower)

    signature = Base.url_encode64(mac)

    Logger.debug "#### Signature: #{signature}"

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      Tesla.Middleware.JSON,
      Tesla.Middleware.Query,
      {Tesla.Middleware.Headers, [
        {"Content-Type", "application/json"},
        {"access_key", "#{access_key}"},
        {"salt", "#{salt}"},
        {"timestamp", "#{timestamp}"},
        {"signature", "#{signature}"}
      ]},
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middleware)
  end

  @spec create_to_sign(String.t(), String.t(), String.t(), String.t(), String.t(), String.t(), String.t()) :: String.t()
  defp create_to_sign(http_method, path, salt, timestamp, access_key, secret_key, body)
    when is_binary(http_method) and is_binary(path) and is_binary(salt) and is_binary(timestamp) and is_binary(access_key)
    and is_binary(secret_key) and is_binary(body) do
    "#{http_method}#{path}#{salt}#{timestamp}#{access_key}#{secret_key}#{body}"
  end

  @spec create_salt() :: String.t()
  defp create_salt() do
    # Salt is a random numeric string for each request of length 8-16 digits
    :crypto.strong_rand_bytes(8) |> Base.encode16(case: :lower)
  end

  @spec create_timestamp() :: String.t()
  defp create_timestamp() do
    # Time of request in Unix time
    Integer.to_string(System.system_time(:second))
  end
end
