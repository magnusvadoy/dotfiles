# Display time
SPACESHIP_TIME_SHOW=true

# Custom Git prefix
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX=""

# Do not truncate path in repos
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0

# Do not show gcloud config (its always the same)
SPACESHIP_GCLOUD_SHOW=false

# Show kubectl context
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_KUBECTL_SYMBOL="󱃾 "

# Custom symbol for golang
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_GOLANG_SYMBOL=" "

# Custom symbol for jobs
SPACESHIP_JOBS_SHOW=true
SPACESHIP_JOBS_SYMBOL="󱈵 "

# Disable docker
SPACESHIP_DOCKER_SHOW=false

# prompt order
SPACESHIP_PROMPT_ORDER=(
  user           # Username section
  dir            # Current directory section
  host           # Hostname section
  git            # Git section (git_branch + git_status)
  hg             # Mercurial section (hg_branch  + hg_status)
  package        # Package version
  node           # Node.js section
  bun            # Bun section
  deno           # Deno section
  ruby           # Ruby section
  python         # Python section
  elm            # Elm section
  elixir         # Elixir section
  xcode          # Xcode section
  swift          # Swift section
  golang         # Go section
  perl           # Perl section
  php            # PHP section
  rust           # Rust section
  haskell        # Haskell Stack section
  scala          # Scala section
  kotlin         # Kotlin section
  java           # Java section
  lua            # Lua section
  dart           # Dart section
  julia          # Julia section
  crystal        # Crystal section
  docker         # Docker section
  docker_compose # Docker section
  aws            # Amazon Web Services section
  gcloud         # Google Cloud Platform section
  azure          # Azure section
  venv           # virtualenv section
  conda          # conda virtualenv section
  dotnet         # .NET section
  ocaml          # OCaml section
  vlang          # V section
  zig            # Zig section
  purescript     # PureScript section
  erlang         # Erlang section
  ansible        # Ansible section
  terraform      # Terraform workspace section
  pulumi         # Pulumi stack section
  ibmcloud       # IBM Cloud section
  nix_shell      # Nix shell
  gnu_screen     # GNU Screen section
  exec_time      # Execution time
  async          # Async jobs indicator
  line_sep       # Line break
  battery        # Battery level and status
  jobs           # Background jobs indicator
  exit_code      # Exit code section
  sudo           # Sudo indicator
  char           # Prompt character
)

# right prompt order
SPACESHIP_RPROMPT_ORDER=(
  kubectl        # Kubectl context section
  time           # Time stamps section
)
