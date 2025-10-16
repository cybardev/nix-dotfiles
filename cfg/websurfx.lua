port = "8080"
binding_ip = "0.0.0.0"

safe_search = 0

theme = "simple"
colorscheme = "catppuccin-mocha"
animation = "simple-frosted-glow"

upstream_search_engines = {
	DuckDuckGo = true,
	Searx = false,
	Brave = false,
	Startpage = false,
	LibreX = false,
	Mojeek = false,
	Bing = false,
	Wikipedia = false,
	Yahoo = false,
}

logging = true
debug = false
threads = 10
production_use = false
request_timeout = 30
tcp_connection_keep_alive = 30
pool_idle_connection_timeout = 30
rate_limiter = {
	number_of_requests = 20,
	time_limit = 3,
}
https_adaptive_window_size = true
operating_system_tls_certificates = true
number_of_https_connections = 10
client_connection_keep_alive = 120
proxy = nil
redis_url = "redis://0.0.0.0:8082"
cache_expiry_time = 600
