use Mix.Config

config :betfair, [
  "username": "barack",
  "password": "obama",
  "certfile": "test/fixture/certs/test.crt",
  "keyfile": "test/fixture/certs/test.key",
  "app_key": "app_k3y"]

config :exvcr, [
  filter_sensitive_data: [
    # [pattern: "sessionToken\"\:\".+\"", placeholder: "sessionToken\"\:\"sessionToken\""]
  ],
  filter_url_params: false,
  response_headers_blacklist: ["Set-Cookie", "Server", "X-Authentication", "X-Application"],
  vcr_cassette_library_dir: "test/fixture/vcr_cassettes"
]