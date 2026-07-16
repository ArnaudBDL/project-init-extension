#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# project.sh
# -----------------------------------------------------------------------------
# Single-file project scaffold generator.
#
# Goal:
# - Copy this file into any folder.
# - Execute it.
# - Generate a complete project structure with AI/project documentation.
#
# Design rules:
# - One single file.
# - No external templates.
# - No external config.
# - Static content is grouped in registries.
# - Functions are used for behavior, not for storing one-line labels.
###############################################################################


readonly RESET=$'\033[0m'

readonly BOLD=$'\033[1m'

readonly BLACK=$'\033[30m'
readonly RED=$'\033[31m'
readonly GREEN=$'\033[32m'
readonly YELLOW=$'\033[33m'
readonly BLUE=$'\033[34m'
readonly MAGENTA=$'\033[35m'
readonly CYAN=$'\033[36m'
readonly WHITE=$'\033[37m'

readonly BRIGHT_BLACK=$'\033[90m'
readonly BRIGHT_RED=$'\033[91m'
readonly BRIGHT_GREEN=$'\033[92m'
readonly BRIGHT_YELLOW=$'\033[93m'
readonly BRIGHT_BLUE=$'\033[94m'
readonly BRIGHT_MAGENTA=$'\033[95m'
readonly BRIGHT_CYAN=$'\033[96m'
readonly BRIGHT_WHITE=$'\033[97m'


###############################################################################
# CHOICES
###############################################################################

# Stacks
# --

readonly STACKS_FRONTEND=(
  "angular:Angular"
  "react:React"
  "vue:Vue"
  "svelte:Svelte"
  "solid:SolidJS"
  "preact:Preact"
  "astro:Astro"
  "qwik:Qwik"
  "html-js-css:HTML/CSS/JS"
)
readonly STACKS_BACKEND=(
  "go:Go"
  "node:Node.js"
  "php:PHP"
  "python:Python"
  "dotnet:.NET"
  "java:Java"
  "kotlin:Kotlin"
  "rust:Rust"
  "ruby:Ruby"
)


# Shells
# --

readonly SHELLS_DESKTOP=(
  "tauri:Tauri"
  "wails:Wails"
  "electron:Electron"
)
readonly SHELLS_MOBILE=(
  "capacitor:Capacitor"
  "flutter:Flutter"
  "react-native:React Native"
)
readonly SHELLS_WEB=(
  "docker:Docker"
)


# Data Services
# --

readonly DATABASES=(
  "postgresql:PostgreSQL"
  "mysql:MySQL"
  "mariadb:MariaDB"
  "sqlite:SQLite"
  "sql-server:SQL Server"
  "mongodb:MongoDB"
  "redis:Redis"
  "clickhouse:ClickHouse"
)
readonly SEARCH_ENGINES=(
  "elasticsearch:Elasticsearch"
  "opensearch:OpenSearch"
  "meilisearch:Meilisearch"
  "typesense:Typesense"
  "algolia:Algolia"
)


# Variants & Frameworks
# --

readonly VARIANTS_ANGULAR=(
  "analog:Analog"
)
readonly VARIANTS_REACT=(
  "nextjs:Next.js"
  "react-router:React Router"
)
readonly VARIANTS_VUE=(
  "nuxt:Nuxt"
)
readonly VARIANTS_SVELTE=(
  "sveltekit:SvelteKit"
)
readonly VARIANTS_SOLID=(
  "solidstart:SolidStart"
)
readonly VARIANTS_PREACT=(
  "fresh:Fresh"
)
readonly VARIANTS_QWIK=(
  "qwik-city:Qwik City"
)

readonly FRAMEWORKS_GO=(
  "stdlib:Standard Library"
  "gin:Gin"
  "fiber:Fiber"
  "echo:Echo"
)
readonly FRAMEWORKS_NODE=(
  "nestjs:NestJS"
  "express:Express"
  "fastify:Fastify"
  "hono:Hono"
)
readonly FRAMEWORKS_PHP=(
  "symfony:Symfony"
  "laravel:Laravel"
  "api-platform:API Platform"
)
readonly FRAMEWORKS_PYTHON=(
  "fastapi:FastAPI"
  "django:Django"
  "flask:Flask"
)
readonly FRAMEWORKS_DOTNET=(
  "aspnet-core:ASP.NET Core"
)
readonly FRAMEWORKS_JAVA=(
  "spring-boot:Spring Boot"
  "quarkus:Quarkus"
  "micronaut:Micronaut"
  "jakarta-ee:Jakarta EE"
)
readonly FRAMEWORKS_KOTLIN=(
  "ktor:Ktor"
  "spring-boot:Spring Boot"
)
readonly FRAMEWORKS_RUST=(
  "axum:Axum"
  "actix-web:Actix Web"
  "rocket:Rocket"
)
readonly FRAMEWORKS_RUBY=(
  "rails:Ruby on Rails"
  "sinatra:Sinatra"
)


###############################################################################
# DEFAULT CONFIGURATION
###############################################################################

PROJECT_NAME=""
PROJECT_SLUG=""
PROJECT_LEGACY="false"

FRONTEND_STACK="none"
FRONTEND_VARIANT="none"

BACKEND_STACK="none"
BACKEND_FRAMEWORK="none"

ENABLED_SERVER_LOCAL="false"
ENABLED_SERVER_REMOTE="false"
ENABLED_SERVER_ASSETS="false"

ENABLED_SHELL_DESKTOP="false"
ENABLED_SHELL_MOBILE="false"
ENABLED_SHELL_WEB="false"

SHELL_DESKTOP="none"
SHELL_MOBILE="none"
SHELL_WEB="none"


DATABASES_SELECTED=()
SEARCH_ENGINES_SELECTED=()


# create  = première génération
# missing = compléter uniquement les éléments absents
GENERATION_MODE="create"


###############################################################################
# PROJECT PROFILE
###############################################################################

PROJECT_HAS_FRONTEND="false"
PROJECT_HAS_SERVER="false"
PROJECT_HAS_DESKTOP="false"
PROJECT_HAS_MOBILE="false"
PROJECT_HAS_WEB="false"
PROJECT_HAS_LEGACY="false"

PROJECT_FRONTEND_NAME=""
PROJECT_FRONTEND_VARIANT_NAME=""

PROJECT_BACKEND_NAME=""
PROJECT_BACKEND_FRAMEWORK_NAME=""

PROJECT_DATABASE_NAMES=""
PROJECT_SEARCH_ENGINE_NAMES=""

PROJECT_DESKTOP_SHELL_NAME=""
PROJECT_MOBILE_SHELL_NAME=""
PROJECT_WEB_SHELL_NAME=""


###############################################################################
# HELPERS
###############################################################################

# CLI Helpers
# --

usage() {
  echo "Usage:"
  echo "  ./project.sh [options]"
  echo ""
  echo "Execution model:"
  echo ""
  echo "  1. Create or enter a project directory"
  echo "  2. Run project.sh"
  echo "  3. Answer the technical bootstrap questions"
  echo "  4. Let the generated AI workflow perform the real project framing"
  echo ""
  echo "Examples:"
  echo ""
  echo "  mkdir cargo-sdw"
  echo "  cd cargo-sdw"
  echo "  ./project.sh"
  echo ""
  echo "Options:"
  echo ""
  echo "  --help"
  echo "      Show this help message."
  echo ""
  echo "Notes:"
  echo ""
  echo "  - The project name is detected from the current directory."
  echo "  - You may override the detected project name."
  echo "  - Technical choices such as frontend, runtime and shell targets"
  echo "    are collected during the bootstrap interview."
  echo "  - Product framing, goals, users, constraints and roadmap are"
  echo "    handled later by the AI startup workflow."
}
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --help|-h)
        usage
        exit 0
        ;;
      --*)
        echo "[ERROR] Unknown option: $1" >&2
        usage
        exit 1
        ;;
      *)
        echo "[ERROR] Unexpected argument: $1" >&2
        echo ""
        echo "project.sh does not accept positional arguments."
        echo "Run the script inside the target project directory."
        echo ""
        usage
        exit 1
        ;;
    esac
  done
}


# Project State Helpers
# --

project_already_initialized() {
  [[ -f "00-META/context/stack.yml" ]]
}
load_existing_project_profile() {
  local stack_file="00-META/context/stack.yml"
  local property
  local value

  if [[ ! -f "$stack_file" ]]; then
    printf "${RED}[ERROR]${RESET} Missing project profile: %s\n" \
      "$stack_file" >&2
    exit 1
  fi

  DATABASES_SELECTED=()
  SEARCH_ENGINES_SELECTED=()

  while IFS=$'\t' read -r property value; do
    case "$property" in
      project.name)
        PROJECT_NAME="$value"
        ;;

      project.slug)
        PROJECT_SLUG="$value"
        ;;

      legacy.enabled)
        PROJECT_LEGACY="$value"
        ;;

      frontend.stack)
        FRONTEND_STACK="$value"
        ;;

      frontend.variant)
        FRONTEND_VARIANT="$value"
        ;;

      server.stack)
        BACKEND_STACK="$value"
        ;;

      server.framework)
        BACKEND_FRAMEWORK="$value"
        ;;

      server.local)
        ENABLED_SERVER_LOCAL="$value"
        ;;

      server.remote)
        ENABLED_SERVER_REMOTE="$value"
        ;;

      server.assets)
        ENABLED_SERVER_ASSETS="$value"
        ;;

      data.database)
        DATABASES_SELECTED+=("$value")
        ;;

      data.searchEngine)
        SEARCH_ENGINES_SELECTED+=("$value")
        ;;

      shell.desktop.enabled)
        ENABLED_SHELL_DESKTOP="$value"
        ;;

      shell.desktop.stack)
        SHELL_DESKTOP="$value"
        ;;

      shell.mobile.enabled)
        ENABLED_SHELL_MOBILE="$value"
        ;;

      shell.mobile.stack)
        SHELL_MOBILE="$value"
        ;;

      shell.web.enabled)
        ENABLED_SHELL_WEB="$value"
        ;;

      shell.web.stack)
        SHELL_WEB="$value"
        ;;
    esac
  done < <(
    awk '
      function yaml_value(line, value) {
        value = line
        sub(/^[^:]+:[[:space:]]*/, "", value)
        sub(/^"/, "", value)
        sub(/"$/, "", value)
        gsub(/\\"/, "\"", value)
        gsub(/\\\\/, "\\", value)

        return value
      }

      /^[^[:space:]]/ {
        section = $0
        sub(/:.*$/, "", section)

        shell_target = ""
        data_group = ""

        next
      }

      section == "shell" &&
      /^  (desktop|mobile|web):[[:space:]]*$/ {
        shell_target = $0
        sub(/^[[:space:]]*/, "", shell_target)
        sub(/:.*$/, "", shell_target)

        next
      }

      section == "data" &&
      /^  databases:/ {
        data_group = "databases"
        next
      }

      section == "data" &&
      /^  searchEngines:/ {
        data_group = "searchEngines"
        next
      }

      section == "project" && /^  name:/ {
        print "project.name\t" yaml_value($0)
        next
      }

      section == "project" && /^  slug:/ {
        print "project.slug\t" yaml_value($0)
        next
      }

      section == "frontend" && /^  stack:/ {
        print "frontend.stack\t" yaml_value($0)
        next
      }

      section == "frontend" && /^  variant:/ {
        print "frontend.variant\t" yaml_value($0)
        next
      }

      section == "server" && /^  stack:/ {
        print "server.stack\t" yaml_value($0)
        next
      }

      section == "server" && /^  framework:/ {
        print "server.framework\t" yaml_value($0)
        next
      }

      section == "server" && /^  local:/ {
        print "server.local\t" yaml_value($0)
        next
      }

      section == "server" && /^  remote:/ {
        print "server.remote\t" yaml_value($0)
        next
      }

      section == "server" && /^  assets:/ {
        print "server.assets\t" yaml_value($0)
        next
      }

      section == "data" &&
      data_group == "databases" &&
      /^    - key:/ {
        print "data.database\t" yaml_value($0)
        next
      }

      section == "data" &&
      data_group == "searchEngines" &&
      /^    - key:/ {
        print "data.searchEngine\t" yaml_value($0)
        next
      }

      section == "shell" &&
      shell_target != "" &&
      /^    enabled:/ {
        print "shell." shell_target ".enabled\t" yaml_value($0)
        next
      }

      section == "shell" &&
      shell_target != "" &&
      /^    stack:/ {
        print "shell." shell_target ".stack\t" yaml_value($0)
        next
      }

      /^legacy:[[:space:]]*$/ {
        section = "legacy"
        next
      }

      section == "legacy" && /^[[:space:]]+enabled:[[:space:]]*/ {
        print "legacy.enabled\t" yaml_value($0)
        next
      }
    ' "$stack_file"
  )
}
resolve_project_profile() {
  PROJECT_HAS_FRONTEND="false"
  PROJECT_HAS_SERVER="false"
  PROJECT_HAS_DESKTOP="false"
  PROJECT_HAS_MOBILE="false"
  PROJECT_HAS_WEB="false"
  PROJECT_HAS_LEGACY="false"

  if [[ "$FRONTEND_STACK" != "none" ]]; then
    PROJECT_HAS_FRONTEND="true"
  fi

  if [[ "$BACKEND_STACK" != "none" ||
        "$ENABLED_SERVER_LOCAL" == "true" ||
        "$ENABLED_SERVER_REMOTE" == "true" ||
        "$ENABLED_SERVER_ASSETS" == "true" ]]; then
    PROJECT_HAS_SERVER="true"
  fi

  if [[ "$ENABLED_SHELL_DESKTOP" == "true" ]]; then
    PROJECT_HAS_DESKTOP="true"
  fi

  if [[ "$ENABLED_SHELL_MOBILE" == "true" ]]; then
    PROJECT_HAS_MOBILE="true"
  fi

  if [[ "$ENABLED_SHELL_WEB" == "true" ]]; then
    PROJECT_HAS_WEB="true"
  fi

  if [[ "$PROJECT_LEGACY" == "true" ]]; then
    PROJECT_HAS_LEGACY="true"
  fi

  if [[ "$FRONTEND_STACK" == "none" ]]; then
    PROJECT_FRONTEND_NAME="None"
  else
    PROJECT_FRONTEND_NAME="$(
      registry_label \
        "$FRONTEND_STACK" \
        "${STACKS_FRONTEND[@]}"
    )"
  fi

  if [[ "$FRONTEND_VARIANT" == "none" ]]; then
    PROJECT_FRONTEND_VARIANT_NAME="None"
  else
    PROJECT_FRONTEND_VARIANT_NAME="$(
      frontend_variant_label \
        "$FRONTEND_STACK" \
        "$FRONTEND_VARIANT"
    )"
  fi

  if [[ "$BACKEND_STACK" == "none" ]]; then
    PROJECT_BACKEND_NAME="None"
  else
    PROJECT_BACKEND_NAME="$(
      registry_label \
        "$BACKEND_STACK" \
        "${STACKS_BACKEND[@]}"
    )"
  fi

  if [[ "$BACKEND_FRAMEWORK" == "none" ]]; then
    PROJECT_BACKEND_FRAMEWORK_NAME="None"
  else
    PROJECT_BACKEND_FRAMEWORK_NAME="$(
      backend_framework_label \
        "$BACKEND_STACK" \
        "$BACKEND_FRAMEWORK"
    )"
  fi

  PROJECT_DATABASE_NAMES="$(database_selection_summary)"
  PROJECT_SEARCH_ENGINE_NAMES="$(search_engine_selection_summary)"

  if [[ "$SHELL_DESKTOP" == "none" ]]; then
    PROJECT_DESKTOP_SHELL_NAME="None"
  else
    PROJECT_DESKTOP_SHELL_NAME="$(
      registry_label \
        "$SHELL_DESKTOP" \
        "${SHELLS_DESKTOP[@]}"
    )"
  fi

  if [[ "$SHELL_MOBILE" == "none" ]]; then
    PROJECT_MOBILE_SHELL_NAME="None"
  else
    PROJECT_MOBILE_SHELL_NAME="$(
      registry_label \
        "$SHELL_MOBILE" \
        "${SHELLS_MOBILE[@]}"
    )"
  fi

  if [[ "$SHELL_WEB" == "none" ]]; then
    PROJECT_WEB_SHELL_NAME="None"
  else
    PROJECT_WEB_SHELL_NAME="$(
      registry_label \
        "$SHELL_WEB" \
        "${SHELLS_WEB[@]}"
    )"
  fi
}


# Registry Helpers
# --

registry_label() {
  local key="$1"
  shift

  local entry
  local entry_key
  local entry_label

  for entry in "$@"; do

    entry_key="${entry%%:*}"
    entry_label="${entry#*:}"

    if [[ "$entry_key" == "$key" ]]; then
      printf '%s\n' "$entry_label"
      return
    fi

  done

  printf '%s\n' "$key"
}
registry_contains_key() {
  local expected="$1"
  shift

  local entry

  for entry in "$@"; do
    if [[ "${entry%%:*}" == "$expected" ]]; then
      return 0
    fi
  done

  return 1
}


# Frontend Variants Helpers
# --

frontend_variant_registry() {
  case "$1" in
    angular)
      printf '%s\n' "${VARIANTS_ANGULAR[@]}"
      ;;
    react)
      printf '%s\n' "${VARIANTS_REACT[@]}"
      ;;
    vue)
      printf '%s\n' "${VARIANTS_VUE[@]}"
      ;;
    svelte)
      printf '%s\n' "${VARIANTS_SVELTE[@]}"
      ;;
    solid)
      printf '%s\n' "${VARIANTS_SOLID[@]}"
      ;;
    preact)
      printf '%s\n' "${VARIANTS_PREACT[@]}"
      ;;
    astro)
      ;;
    qwik)
      printf '%s\n' "${VARIANTS_QWIK[@]}"
      ;;
    html-js-css)
      ;;
  esac
}
frontend_variant_label() {
  local stack="$1"
  local variant="$2"
  local entry

  if [[ "$variant" == "none" ]]; then
    printf '%s\n' "None"
    return
  fi

  while IFS= read -r entry; do
    if [[ "${entry%%:*}" == "$variant" ]]; then
      printf '%s\n' "${entry#*:}"
      return
    fi
  done < <(frontend_variant_registry "$stack")

  printf '%s\n' "$variant"
}


# Backend Helpers
# --

backend_framework_registry() {
  case "$1" in
    go)
      printf '%s\n' "${FRAMEWORKS_GO[@]}"
      ;;
    node)
      printf '%s\n' "${FRAMEWORKS_NODE[@]}"
      ;;
    php)
      printf '%s\n' "${FRAMEWORKS_PHP[@]}"
      ;;
    python)
      printf '%s\n' "${FRAMEWORKS_PYTHON[@]}"
      ;;
    dotnet)
      printf '%s\n' "${FRAMEWORKS_DOTNET[@]}"
      ;;
    java)
      printf '%s\n' "${FRAMEWORKS_JAVA[@]}"
      ;;
    kotlin)
      printf '%s\n' "${FRAMEWORKS_KOTLIN[@]}"
      ;;
    rust)
      printf '%s\n' "${FRAMEWORKS_RUST[@]}"
      ;;
    ruby)
      printf '%s\n' "${FRAMEWORKS_RUBY[@]}"
      ;;
  esac
}
backend_framework_label() {
  local stack="$1"
  local framework="$2"
  local entry

  if [[ "$framework" == "none" ]]; then
    printf '%s\n' "None"
    return
  fi

  while IFS= read -r entry; do
    if [[ "${entry%%:*}" == "$framework" ]]; then
      printf '%s\n' "${entry#*:}"
      return
    fi
  done < <(backend_framework_registry "$stack")

  printf '%s\n' "$framework"
}


# Data Helpers
# --

database_selection_summary() {
  local database
  local label
  local summary=""

  if [[ -z "${DATABASES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "None"
    return
  fi

  for database in "${DATABASES_SELECTED[@]}"; do
    label="$(registry_label "$database" "${DATABASES[@]}")"

    if [[ -z "$summary" ]]; then
      summary="$label"
    else
      summary+=", $label"
    fi
  done

  printf '%s\n' "$summary"
}
search_engine_selection_summary() {
  local search_engine
  local label
  local summary=""

  if [[ -z "${SEARCH_ENGINES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "None"
    return
  fi

  for search_engine in "${SEARCH_ENGINES_SELECTED[@]}"; do
    label="$(registry_label "$search_engine" "${SEARCH_ENGINES[@]}")"

    if [[ -z "$summary" ]]; then
      summary="$label"
    else
      summary="$summary, $label"
    fi
  done

  printf '%s\n' "$summary"
}


# Array Helpers
# --

array_contains() {
  local expected="$1"
  shift

  local value

  for value in "$@"; do
    if [[ "$value" == "$expected" ]]; then
      return 0
    fi
  done

  return 1
}


# String Helpers
# --

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g' \
    | sed -E 's/^-+|-+$//g'
}


# Filesystem Helpers
# --

create_tree() {
  local d

  for d in "$@"; do
    touch_keep "$d"
  done
}
touch_keep() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    return
  fi

  mkdir -p "$dir"
  : > "$dir/.gitkeep"
}
cleanup_gitkeep_files() {
  local root
  local keep_file
  local dir
  local entry_count

  local managed_roots=(
    ".github"
    "00-META"
    "01-FOUNDATION"
    "02-DESIGN"
    "03-PRODUCT"
    "04-ENGINEERING"
    "05-LAB"
    "09-LEGACY"
  )

  for root in "${managed_roots[@]}"; do
    if [[ ! -d "$root" ]]; then
      continue
    fi

    while IFS= read -r keep_file; do
      dir="$(dirname "$keep_file")"
      entry_count="$(find "$dir" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ')"

      if (( entry_count > 1 )); then
        rm -f "$keep_file"
      fi
    done < <(find "$root" -name ".gitkeep" -type f)
  done
}

# Document Helpers
# --

write_document() {
  local file="$1"

  mkdir -p "$(dirname "$file")"

  if [[ "$GENERATION_MODE" == "missing" && -e "$file" ]]; then
    return
  fi

  while IFS= read -r line; do
    line="${line#  }"
    printf '%s\n' "$line"
  done > "$file"
}
write_embedded_lines() {
  local first="true"
  local line

  while IFS= read -r line; do
    if [[ "$first" == "true" ]]; then
      printf '%s\n' "$line"
      first="false"
    else
      printf '  %s\n' "$line"
    fi
  done
}


# YAML Helpers
# --

write_yaml_data_section() {
  local key
  local name

  printf '%s\n' "data:"

  if [[ -z "${DATABASES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "  databases: []"
  else
    printf '%s\n' "  databases:"

    for key in "${DATABASES_SELECTED[@]}"; do
      name="$(registry_label "$key" "${DATABASES[@]}")"
      printf '%s\n' "    - key: \"$(yaml_escape "$key")\""
      printf '%s\n' "      name: \"$(yaml_escape "$name")\""
    done
  fi

  if [[ -z "${SEARCH_ENGINES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "  searchEngines: []"
  else
    printf '%s\n' "  searchEngines:"

    for key in "${SEARCH_ENGINES_SELECTED[@]}"; do
      name="$(registry_label "$key" "${SEARCH_ENGINES[@]}")"
      printf '%s\n' "    - key: \"$(yaml_escape "$key")\""
      printf '%s\n' "      name: \"$(yaml_escape "$name")\""
    done
  fi
}
yaml_escape() {
  local value="$1"

  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"

  printf '%s' "$value"
}


# Runtime Helpers
# --

launch_ai_prompt() {
  local prompt_file="$PWD/.github/prompts/project-start.prompt.md"
  local opened="false"

  if command -v code >/dev/null 2>&1; then
    code "$PWD" "$prompt_file" >/dev/null 2>&1 || true
    opened="true"
  elif [[ "${OSTYPE:-}" == darwin* ]] && command -v open >/dev/null 2>&1; then
    open -a "Visual Studio Code" "$PWD" >/dev/null 2>&1 || true
    open -a "Visual Studio Code" "$prompt_file" >/dev/null 2>&1 || true
    opened="true"
  fi

  echo ""
  echo "===================================================="
  echo "AI PROJECT START"
  echo "===================================================="
  echo ""

  if [[ "$opened" == "true" ]]; then
    echo "VS Code workspace opened."
  else
    echo "VS Code could not be opened automatically."
  fi

  echo ""
  echo "NEXT STEP:"
  echo ""
  echo "1. Wait for VS Code to open."
  echo "2. Open Copilot Chat."
  echo "3. Open:"
  echo "   .github/prompts/project-start.prompt.md"
  echo "4. Copy the ENTIRE file content."
  echo "5. Paste it into Copilot Chat."
  echo "6. Send the message."
  echo "7. Complete the framing interview."
  echo "8. Update:"
  echo "   00-META/context/framing.md"
  echo ""
  echo "The framing interview becomes the source of truth for:"
  echo "  - identity"
  echo "  - vision"
  echo "  - specifications"
  echo "  - kanban"
  echo "  - architecture decisions"
  echo ""
  echo "Prompt path:"
  echo "  $prompt_file"
  echo ""
}



###############################################################################
# CLI INTERVIEW
###############################################################################

# Project interview
# --
interview__project_name() {
  local detected_name
  local custom_name

  detected_name="$(basename "$PWD")"

  echo ""
  printf "${CYAN}${BOLD}> Project name ${YELLOW}(%s)${RESET}: " \
    "$detected_name"

  read -r custom_name

  if [[ -z "$custom_name" ]]; then
    PROJECT_NAME="$detected_name"
  else
    PROJECT_NAME="$custom_name"
  fi

  PROJECT_SLUG="$(slugify "$PROJECT_NAME")"

  if [[ -z "$PROJECT_SLUG" ]]; then
    printf "${RED}[ERROR]${RESET} Project slug cannot be empty.\n" >&2
    exit 1
  fi
}

# Frontend interview
# --
interview__frontend_stack() {
  local choice
  local entry
  local none_index
  local labels=()
  local old_ps3="${PS3:-}"

  echo ""
  printf "${CYAN}${BOLD}> Select frontend stack${RESET}:\n"

  PS3="${CYAN}${BOLD}Frontend stack${RESET}: "

  for entry in "${STACKS_FRONTEND[@]}"; do
    labels+=("${entry#*:}")
  done

  labels+=("None")
  none_index="${#labels[@]}"

  select choice in "${labels[@]}"; do
    if [[ "$REPLY" =~ ^[0-9]+$ ]] && (( REPLY >= 1 && REPLY <= ${#labels[@]} )); then
      if (( REPLY == none_index )); then
        FRONTEND_STACK="none"
      else
        FRONTEND_STACK="${STACKS_FRONTEND[$((REPLY - 1))]%%:*}"
      fi
      break
    fi

    printf "${RED}[ERROR]${RESET} Invalid choice\n"
  done

  PS3="$old_ps3"
}
interview__frontend_variant() {
  local choice
  local entry
  local none_index
  local labels=()
  local variants=()
  local old_ps3="${PS3:-}"

  FRONTEND_VARIANT="none"

  if [[ "$FRONTEND_STACK" == "none" ]]; then
    return
  fi

  while IFS= read -r entry; do
    [[ -z "$entry" ]] && continue

    variants+=("${entry%%:*}")
    labels+=("${entry#*:}")
  done < <(frontend_variant_registry "$FRONTEND_STACK")

  if (( ${#variants[@]} == 0 )); then
    return
  fi

  labels+=("None")
  none_index="${#labels[@]}"

  echo ""
  printf "${CYAN}${BOLD}> Select frontend variant${RESET}:\n"

  PS3="${CYAN}${BOLD}Frontend variant${RESET}: "

  select choice in "${labels[@]}"; do
    if [[ "$REPLY" =~ ^[0-9]+$ ]] &&
       (( REPLY >= 1 && REPLY <= ${#labels[@]} )); then

      if (( REPLY == none_index )); then
        FRONTEND_VARIANT="none"
      else
        FRONTEND_VARIANT="${variants[$((REPLY - 1))]}"
      fi

      break
    fi

    printf "${RED}[ERROR]${RESET} Invalid choice\n"
  done

  PS3="$old_ps3"
}

# Backend interview
# --
interview__backend_stack() {
  local choice
  local entry
  local none_index
  local labels=()
  local old_ps3="${PS3:-}"

  echo ""
  printf "${CYAN}${BOLD}> Select backend stack${RESET}\n"

  PS3="${CYAN}${BOLD}Backend stack${RESET}: "

  for entry in "${STACKS_BACKEND[@]}"; do
    labels+=("${entry#*:}")
  done
  
  labels+=("None")
  none_index="${#labels[@]}"

  select choice in "${labels[@]}"; do
    if [[ "$REPLY" =~ ^[0-9]+$ ]] &&
       (( REPLY >= 1 && REPLY <= ${#labels[@]} )); then

      if (( REPLY == none_index )); then
        BACKEND_STACK="none"
      else
        BACKEND_STACK="${STACKS_BACKEND[$((REPLY - 1))]%%:*}"
      fi
      break
    fi

    printf "${RED}[ERROR]${RESET} Invalid choice\n"
  done

  PS3="$old_ps3"
}
interview__backend_framework() {
  local choice
  local entry
  local none_index
  local old_ps3="${PS3:-}"

  local frameworks=()
  local labels=()

  BACKEND_FRAMEWORK="none"

  if [[ "$BACKEND_STACK" == "none" ]]; then
    return
  fi

  while IFS= read -r entry; do
    [[ -z "$entry" ]] && continue

    frameworks+=("${entry%%:*}")
    labels+=("${entry#*:}")
  done < <(backend_framework_registry "$BACKEND_STACK")

  labels+=("None")
  none_index="${#labels[@]}"

  echo ""
  printf "${CYAN}${BOLD}> Select backend framework${RESET}\n"

  PS3="${CYAN}${BOLD}Backend framework${RESET}: "

  select choice in "${labels[@]}"; do
    if [[ "$REPLY" =~ ^[0-9]+$ ]] &&
       (( REPLY >= 1 && REPLY <= ${#labels[@]} )); then

      if (( REPLY == none_index )); then
        BACKEND_FRAMEWORK="none"
      else
        BACKEND_FRAMEWORK="${frameworks[$((REPLY - 1))]}"
      fi

      break
    fi

    printf "${RED}[ERROR]${RESET} Invalid choice\n"
  done

  PS3="$old_ps3"
}

# Server interview
# --
interview__server_targets() {
  local answer

  if [[ "$BACKEND_STACK" == "none" ]]; then
    return
  fi

  echo ""
  printf "${CYAN}${BOLD}> Add local server${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      ENABLED_SERVER_LOCAL="true"
      ;;
  esac

  echo ""
  printf "${CYAN}${BOLD}> Add remote server${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      ENABLED_SERVER_REMOTE="true"
      ;;
  esac
}
interview__server_assets() {
  local answer

  ENABLED_SERVER_ASSETS="false"

  echo ""
  printf "${CYAN}${BOLD}> Add asset server${RESET} [y/N]: "
  read -r answer

  case "${answer:-N}" in
    Y|y)
      ENABLED_SERVER_ASSETS="true"
      ;;
  esac
}

# Data interview
# --
interview__databases() {
  local choice
  local entry
  local selected_key
  local done_index
  local labels=()
  local old_ps3="${PS3:-}"

  DATABASES_SELECTED=()

  echo ""
  printf "${CYAN}${BOLD}> Select databases and data stores${RESET}\n"
  printf "${BRIGHT_BLACK}Select one item at a time, then select Done.${RESET}\n"

  for entry in "${DATABASES[@]}"; do
    labels+=("${entry#*:}")
  done

  labels+=("Done")
  done_index="${#labels[@]}"

  PS3="${CYAN}${BOLD}Database / data store${RESET}: "

  while true; do
    select choice in "${labels[@]}"; do
      if [[ ! "$REPLY" =~ ^[0-9]+$ ]] ||
         (( REPLY < 1 || REPLY > ${#labels[@]} )); then

        printf "${RED}[ERROR]${RESET} Invalid choice\n"
        break
      fi

      if (( REPLY == done_index )); then
        PS3="$old_ps3"
        return
      fi

      selected_key="${DATABASES[$((REPLY - 1))]%%:*}"

      if array_contains \
        "$selected_key" \
        "${DATABASES_SELECTED[@]-}"; then

        printf "${YELLOW}[SKIP]${RESET} %s is already selected.\n" \
          "$(registry_label "$selected_key" "${DATABASES[@]}")"
      else
        DATABASES_SELECTED+=("$selected_key")

        printf "${GREEN}[ADD]${RESET} %s\n" \
          "$(registry_label "$selected_key" "${DATABASES[@]}")"
      fi

      break
    done
  done
}
interview__search_engines() {
  local choice
  local entry
  local selected_key
  local done_index
  local labels=()
  local old_ps3="${PS3:-}"

  SEARCH_ENGINES_SELECTED=()

  echo ""
  printf "${CYAN}${BOLD}> Select search engines${RESET}\n"
  printf "${BRIGHT_BLACK}Select one item at a time, then select Done.${RESET}\n"

  for entry in "${SEARCH_ENGINES[@]}"; do
    labels+=("${entry#*:}")
  done

  labels+=("Done")
  done_index="${#labels[@]}"

  PS3="${CYAN}${BOLD}Search engine${RESET}: "

  while true; do
    select choice in "${labels[@]}"; do
      if [[ ! "$REPLY" =~ ^[0-9]+$ ]] ||
         (( REPLY < 1 || REPLY > ${#labels[@]} )); then

        printf "${RED}[ERROR]${RESET} Invalid choice\n"
        break
      fi

      if (( REPLY == done_index )); then
        PS3="$old_ps3"
        return
      fi

      selected_key="${SEARCH_ENGINES[$((REPLY - 1))]%%:*}"

      if array_contains \
        "$selected_key" \
        "${SEARCH_ENGINES_SELECTED[@]-}"; then

        printf "${YELLOW}[SKIP]${RESET} %s is already selected.\n" \
          "$(registry_label "$selected_key" "${SEARCH_ENGINES[@]}")"
      else
        SEARCH_ENGINES_SELECTED+=("$selected_key")

        printf "${GREEN}[ADD]${RESET} %s\n" \
          "$(registry_label "$selected_key" "${SEARCH_ENGINES[@]}")"
      fi

      break
    done
  done
}

# Shell interview
# --
interview__shell_targets() {
  local answer
  local choice
  local entry
  local desktop_labels=()
  local mobile_labels=()
  local old_ps3="${PS3:-}"

  ENABLED_SHELL_DESKTOP="false"
  ENABLED_SHELL_MOBILE="false"
  ENABLED_SHELL_WEB="false"

  SHELL_DESKTOP="none"
  SHELL_MOBILE="none"
  SHELL_WEB="none"

  echo ""
  printf "${CYAN}${BOLD}> Add desktop shell${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      ENABLED_SHELL_DESKTOP="true"
      ;;
  esac

  if [[ "$ENABLED_SHELL_DESKTOP" == "true" ]]; then
    for entry in "${SHELLS_DESKTOP[@]}"; do
      desktop_labels+=("${entry#*:}")
    done

    echo ""
    printf "${CYAN}${BOLD}> Select desktop shell${RESET}\n"

    PS3="${CYAN}${BOLD}Desktop shell${RESET}: "

    select choice in "${desktop_labels[@]}"; do
      if [[ "$REPLY" =~ ^[0-9]+$ ]] &&
         (( REPLY >= 1 && REPLY <= ${#desktop_labels[@]} )); then

        SHELL_DESKTOP="${SHELLS_DESKTOP[$((REPLY - 1))]%%:*}"
        break
      fi

      printf "${RED}[ERROR]${RESET} Invalid choice\n"
    done
  fi

  echo ""
  printf "${CYAN}${BOLD}> Add mobile shell${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      ENABLED_SHELL_MOBILE="true"
      ;;
  esac

  if [[ "$ENABLED_SHELL_MOBILE" == "true" ]]; then
    for entry in "${SHELLS_MOBILE[@]}"; do
      mobile_labels+=("${entry#*:}")
    done

    echo ""
    printf "${CYAN}${BOLD}> Select mobile shell${RESET}\n"

    PS3="${CYAN}${BOLD}Mobile shell${RESET}: "

    select choice in "${mobile_labels[@]}"; do
      if [[ "$REPLY" =~ ^[0-9]+$ ]] &&
         (( REPLY >= 1 && REPLY <= ${#mobile_labels[@]} )); then

        SHELL_MOBILE="${SHELLS_MOBILE[$((REPLY - 1))]%%:*}"
        break
      fi

      printf "${RED}[ERROR]${RESET} Invalid choice\n"
    done
  fi

  echo ""
  printf "${CYAN}${BOLD}> Add web shell${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      ENABLED_SHELL_WEB="true"
      SHELL_WEB="docker"
      ;;
  esac

  PS3="$old_ps3"
}

# Legacy interview
# --
interview__legacy_project() {
  local answer

  PROJECT_LEGACY="false"

  echo ""
  printf "${CYAN}${BOLD}> Existing codebase to migrate?${RESET} [y/N]: "
  read -r answer

  case "${answer:-N}" in
    Y|y)
      PROJECT_LEGACY="true"
      ;;
  esac
}

# Summary & Confirmation
# --
interview__summary() {
  local frontend_stack_name
  local frontend_variant_name

  local backend_stack_name
  local backend_framework_name

  local server_local="No"
  local server_remote="No"
  local asset_server="No"

  local databases_name
  local search_engines_name

  local desktop_shell_name
  local mobile_shell_name
  local web_shell_name

  local legacy="No"


  if [[ "$FRONTEND_STACK" == "none" ]]; then
    frontend_stack_name="None"
  else
    frontend_stack_name="$(registry_label "$FRONTEND_STACK" "${STACKS_FRONTEND[@]}")"
  fi

  if [[ "$FRONTEND_VARIANT" == "none" ]]; then
    frontend_variant_name="None"
  else
    frontend_variant_name="$(
      frontend_variant_label "$FRONTEND_STACK" "$FRONTEND_VARIANT"
    )"
  fi

  if [[ "$BACKEND_STACK" == "none" ]]; then
    backend_stack_name="None"
  else
    backend_stack_name="$(registry_label "$BACKEND_STACK" "${STACKS_BACKEND[@]}")"
  fi
  
  if [[ "$BACKEND_FRAMEWORK" == "none" ]]; then
    backend_framework_name="None"
  else
    backend_framework_name="$(
      backend_framework_label "$BACKEND_STACK" "$BACKEND_FRAMEWORK"
    )"
  fi

  [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && server_local="Yes"
  [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && server_remote="Yes"
  [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && asset_server="Yes"

  if [[ "$SHELL_DESKTOP" == "none" ]]; then
    desktop_shell_name="None"
  else
    desktop_shell_name="$(registry_label "$SHELL_DESKTOP" "${SHELLS_DESKTOP[@]}")"
  fi

  if [[ "$SHELL_MOBILE" == "none" ]]; then
    mobile_shell_name="None"
  else
    mobile_shell_name="$(registry_label "$SHELL_MOBILE" "${SHELLS_MOBILE[@]}")"
  fi

  if [[ "$SHELL_WEB" == "none" ]]; then
    web_shell_name="None"
  else
    web_shell_name="$(registry_label "$SHELL_WEB" "${SHELLS_WEB[@]}")"
  fi

  databases_name="$(database_selection_summary)"
  search_engines_name="$(search_engine_selection_summary)"

  [[ "$PROJECT_LEGACY" == "true" ]] && legacy="Yes"


  echo ""
  printf "${CYAN}${BOLD}"
  echo "========================================="
  echo "          INTERVIEW SUMMARY"
  echo "========================================="
  printf "${RESET}\n"

  printf "${BRIGHT_WHITE}${BOLD}> Project${RESET}\n"

  printf "${BRIGHT_BLACK}Project name${RESET} ......... : ${GREEN}%s${RESET}\n" \
    "$PROJECT_NAME"

  printf "${BRIGHT_BLACK}Project slug${RESET} ......... : ${YELLOW}%s${RESET}\n\n" \
    "$PROJECT_SLUG"


  printf "${BRIGHT_WHITE}${BOLD}> Frontend${RESET}\n"

  printf "${BRIGHT_BLACK}Frontend Stack${RESET} ....... : ${GREEN}%s${RESET}\n" \
    "$frontend_stack_name"

  printf "${BRIGHT_BLACK}Frontend Variant${RESET} ... : ${GREEN}%s${RESET}\n\n" \
    "$frontend_variant_name"


  printf "${BRIGHT_WHITE}${BOLD}> Backend${RESET}\n"

  printf "${BRIGHT_BLACK}Backend Stack${RESET} ........ : ${GREEN}%s${RESET}\n" \
    "$backend_stack_name"

  printf "${BRIGHT_BLACK}Backend Framework${RESET} .... : ${GREEN}%s${RESET}\n\n" \
    "$backend_framework_name"


  printf "${BRIGHT_WHITE}${BOLD}> App Servers${RESET}\n"

  printf "${BRIGHT_BLACK}Local Server${RESET} ......... : ${GREEN}%s${RESET}\n" \
    "$server_local"

  printf "${BRIGHT_BLACK}Remote Server${RESET} ........ : ${GREEN}%s${RESET}\n" \
    "$server_remote"

  printf "${BRIGHT_BLACK}Asset Server${RESET} ......... : ${GREEN}%s${RESET}\n\n" \
    "$asset_server"


  printf "${BRIGHT_WHITE}${BOLD}> Data${RESET}\n"

  printf "${BRIGHT_BLACK}Databases${RESET} ............ : ${GREEN}%s${RESET}\n" \
    "$databases_name"
  
  printf "${BRIGHT_BLACK}Search Engines${RESET} ....... : ${GREEN}%s${RESET}\n\n" \
    "$search_engines_name"


  printf "${BRIGHT_WHITE}${BOLD}> App Shells${RESET}\n"

  printf "${BRIGHT_BLACK}Desktop Shell${RESET} ........ : ${GREEN}%s${RESET}\n" \
    "$desktop_shell_name"

  printf "${BRIGHT_BLACK}Mobile Shell${RESET} ......... : ${GREEN}%s${RESET}\n" \
    "$mobile_shell_name"

  printf "${BRIGHT_BLACK}Web Shell${RESET} ............ : ${GREEN}%s${RESET}\n\n" \
    "$web_shell_name"


  printf "${BRIGHT_WHITE}${BOLD}> Legacy${RESET}\n"

  printf "${BRIGHT_BLACK}Legacy migration${RESET} ..... : ${GREEN}%s${RESET}\n" \
    "$legacy"

  echo ""
}
interview__confirm_generation() {
  local answer

  echo ""
  printf "${CYAN}${BOLD}> Generate project structure${RESET} [Y/n]: "
  read -r answer

  case "${answer:-Y}" in
    Y|y)
      printf "${YELLOW}[OK]${RESET} Generating...\n"
      return
      ;;
    *)
      echo ""
      printf "${YELLOW}[CANCELLED]${RESET} Project generation cancelled.\n"
      exit 0
      ;;
  esac
}
confirm_existing_project_completion() {
  local answer

  echo ""
  printf "${YELLOW}${BOLD}An existing project scaffold was detected.${RESET}\n"
  echo ""
  echo "Existing files will not be overwritten."
  echo ""
  printf "${CYAN}${BOLD}Complete missing project files?${RESET} [y/N]: "
  read -r answer

  case "${answer:-N}" in
    Y|y)
      GENERATION_MODE="missing"
      ;;
    *)
      echo "Cancelled."
      exit 0
      ;;
  esac
}

# Output
# --
print_success_message() {
  if [[ "$GENERATION_MODE" == "missing" ]]; then
    echo ""
    printf "${GREEN}${BOLD}[OK]${RESET} Missing project scaffold files completed.\n"
    echo ""
    echo "Existing files were preserved."
    echo "Engineering files were not modified."
    echo ""
    return
  fi

  echo ""
  printf "${GREEN}${BOLD}[OK]${RESET} Project scaffold generated for ${GREEN}%s${RESET} (${YELLOW}%s${RESET})\n" \
    "$PROJECT_NAME" \
    "$PROJECT_SLUG"

  echo ""
  echo "Start here:"
  echo "  - README.md"
  echo "  - AGENTS.md"
  echo "  - .github/prompts/project-start.prompt.md"
  echo ""
  echo "Engineering:"
  echo "  - 04-ENGINEERING/"
}

# Agent Interview
# --
confirm_launch_ai_prompt() {
  local answer

  echo ""
  printf "${CYAN}${BOLD}Open VS Code and the generated AI startup prompt?${RESET} [y/N]: "
  read -r answer

  case "${answer:-N}" in
    Y|y)
      launch_ai_prompt
      ;;
    *)
      echo ""
      echo "AI startup skipped."
      echo ""
      echo "Later you can:"
      echo ""
      echo "1. Open VS Code"
      echo "2. Open Copilot Chat"
      echo "3. Open:"
      echo "   .github/prompts/project-start.prompt.md"
      echo "4. Copy the entire file"
      echo "5. Paste it into Copilot Chat"
      echo "6. Start the framing interview"
      echo ""
      ;;
  esac
}




###############################################################################
# Root Documents
###############################################################################

write_root_documents() {
  write_root_readme
  write_root_agents
  write_root_gitignore
  write_root_editorconfig
}


write_root_readme() {
  write_document "README.md" <<EOF
  # ${PROJECT_NAME}

  ## Start Here

  This repository is organized around a project source of truth and a generated
  engineering workspace.

  ## Main Directories

  - 00-META: project context, governance, skills, playbooks, decisions and templates
  - 01-FOUNDATION: research, inspirations, benchmarks and raw assets
  - 02-DESIGN: brand, design system, tokens, typography and UI references
  - 03-PRODUCT: specifications, features, UX flows, roadmap and Kanban
  - 04-ENGINEERING: generated implementation workspace
  - 05-LAB: prototypes and playground work
  $(if [[ "$PROJECT_HAS_LEGACY" == "true" ]]; then
    printf '%s\n' "- 09-LEGACY: existing codebase and migration workspace" |
      write_embedded_lines
  fi)

  ## Project Context

  Start with:

  - 00-META/context/README.md
  - 00-META/context/open-arbitrations.md
  - 00-META/context/risks.md
  - 00-META/context/identity.md
  - 00-META/context/vision.md
  - 00-META/context/stack.yml
  - 00-META/context/architecture.md
  - 00-META/context/framing.md

  ## Engineering Workspace

  Runnable implementation code belongs in:

  \`\`\`txt
  04-ENGINEERING/
  \`\`\`

  ## AI Collaboration

  AI agents should start from:

  - AGENTS.md
  - 00-META/context/README.md
  - 00-META/governance/README.md
  - 00-META/skills/README.md
  - 00-META/playbooks/README.md

  ## Rules

  - Do not treat placeholders as confirmed project facts.
  - Keep project truth in 00-META/context.
  - Keep durable decisions in 00-META/decisions.
  - Keep runnable code inside 04-ENGINEERING.
EOF
}
write_root_agents() {
  write_document "AGENTS.md" <<EOF
  # Agents

  This repository is structured for human and AI-assisted project work.

  ## Mandatory Reading Order

  Before generating or modifying project files, AI agents must read:

  1. 00-META/context/README.md
  2. 00-META/context/open-arbitrations.md
  3. 00-META/context/risks.md
  4. 00-META/context/identity.md
  5. 00-META/context/vision.md
  6. 00-META/context/stack.yml
  7. 00-META/context/architecture.md
  8. 00-META/context/framing.md
  9. 00-META/governance/README.md
  10. Relevant files in 00-META/governance/
  11. 00-META/skills/README.md
  12. Relevant skills in 00-META/skills/
  13. Relevant playbook in 00-META/playbooks/

  ## Skill Selection

  Always read:

  - 00-META/skills/README.md

  Then read only the specialized skills relevant to the requested work.

  Read a technology skill when:

  - the selected technology is involved in the requested change
  - code or configuration for that technology will be created or modified

  Read 00-META/skills/specs/SKILL.md when:

  - creating a specification
  - modifying a specification
  - reviewing specification structure or consistency

  Read 00-META/skills/kanban/SKILL.md when:

  - creating a Kanban task
  - modifying a Kanban task
  - moving a task between columns
  - modifying TASKS.md
  - creating or modifying a task detail file
  - reviewing Kanban structure or consistency

  Do not load specialized skills unrelated to the requested work.

  When one task affects multiple specialized areas, read every relevant skill.

  ## Project Rules

  - Do not invent missing project facts.
  - Do not apply a technology skill that is not selected in 00-META/context/stack.yml.
  - Keep frontend, server, shell and delivery concerns separated.
  - Keep durable decisions in 00-META/decisions/.
  - Keep runnable implementation code in 04-ENGINEERING/.
  - Update context or governance documents when project truth changes.
  - Open arbitrations are not confirmed project facts.
  - Accepted arbitrations become project facts when reflected in the appropriate project documents.
  - Dropped arbitrations must not be reintroduced unless explicitly requested by the user.
  - Record confirmed project risks in 00-META/context/risks.md.
  - Do not use risks.md for open decisions or implementation tasks.
  - A mitigation requiring implementation must be tracked in the Kanban.
  - A mitigation requiring an unresolved choice must be tracked as an open arbitration.


  ## Project Workflow

  AI agents must use the following workflow according to the requested scope.

  ### 1. Framing

  Before creating specifications, tasks or implementation code:

  - verify that the requested scope is sufficiently confirmed
  - read 00-META/context/framing.md
  - read 00-META/context/open-arbitrations.md
  - identify unresolved decisions affecting the requested scope
  - do not create implementation work from open arbitrations

  The entire project framing does not need to be complete when the requested
  scope is independently confirmed.

  Blocking decisions for the requested scope must be resolved before continuing.

  ### 2. Specifications

  A functional change must be covered by a specification in:

  - 03-PRODUCT/specs/

  Before creating or modifying a specification, follow:

  - 00-META/skills/specs/SKILL.md
  - .github/prompts/project-specs.prompt.md

  A specification must use the Ready status before implementation tasks are
  created from it.

  A new specification is not required for:

  - documentation-only corrections
  - technical corrections without functional impact
  - bugs whose expected behavior is already documented
  - internal maintenance without product impact

  These exceptions must still follow the relevant playbook and project rules.

  ### 3. Kanban

  Confirmed implementation work must be tracked in:

  - 03-PRODUCT/kanban/TASKS.md

  Before creating or modifying tasks, follow:

  - 00-META/skills/kanban/SKILL.md
  - .github/prompts/project-kanban.prompt.md

  Implementation tasks created from a specification must reference the relevant
  specification in their detail file.

  A task must:

  - represent one concrete deliverable
  - remain in BACKLOG until work begins
  - contain only confirmed implementation work
  - not duplicate the complete specification

  ### 4. Implementation

  When implementation begins:

  - move the active task from BACKLOG to DOING
  - select the relevant playbook
  - read the applicable technology skills
  - modify only the confirmed task scope
  - keep implementation code in 04-ENGINEERING/

  Use:

  - 00-META/playbooks/feature.md for feature work
  - 00-META/playbooks/bugfix.md for defect correction
  - 00-META/playbooks/migration.md for migrations

  Do not start implementation when a blocking decision remains unresolved.

  ### 5. Review

  When implementation is complete:

  - move the task from DOING to REVIEW
  - use .github/prompts/project-review.prompt.md
  - follow 00-META/playbooks/review.md
  - verify the implementation against the specification and acceptance criteria
  - verify architecture, governance and applicable skills
  - verify that no unrelated changes were introduced

  Do not move a task directly from DOING to DONE unless the work is explicitly
  exempted from review because it is trivial and has no functional,
  architectural or security impact.

  ### 6. Completion

  After successful review:

  - move the task from REVIEW to DONE
  - update the affected specification when necessary
  - mark a specification as Implemented only when its complete scope is delivered
    and validated
  - update Engineering documentation when commands, structure or usage changed
  - create or update an ADR when implementation introduced a durable decision
  - update project context only when the confirmed project truth changed

  Do not update unrelated documents.

  ### Workflow Transitions

  Workflow transitions are never automatic.

  AI agents must:

  - verify that the current stage is complete
  - report blocking decisions
  - recommend the next valid workflow
  - wait for explicit user instruction before starting another major workflow

  The standard sequence is:

  Framing → Specification → Kanban → Implementation → Review → Completion

  Do not skip a required stage.

  ## Engineering Rules

  - Frontend code belongs in the generated client section when present.
  - Backend/runtime code belongs in the generated server section when present.
  - Platform shell code belongs in the generated shell section when present.
  - Experimental work belongs in 05-LAB until reviewed and promoted.
  $(if [[ "$PROJECT_HAS_LEGACY" == "true" ]]; then
    {
      printf '%s\n' "- Legacy source code belongs in 09-LEGACY/codebase/."
      printf '%s\n' "- Legacy migration analysis and planning belong in 09-LEGACY/migration/."
      printf '%s\n' "- Target implementation code belongs in 04-ENGINEERING/."
      printf '%s\n' "- Do not modify legacy code without explicit migration work."
    } | write_embedded_lines
  fi)
EOF
}
write_root_gitignore() {
  write_document ".gitignore" <<'EOF'
  # OS / IDE
  .DS_Store
  Thumbs.db
  .idea/
  .vscode/

  # Logs
  *.log

  # Environment / secrets
  .env
  .env.*
  !.env.example

  # Dependencies
  node_modules/
  vendor/

  # Build outputs
  dist/
  build/
  coverage/
  out/
  tmp/
  temp/

  # Cache
  .cache/
  .parcel-cache/
  .turbo/
  .vite/
EOF
}
write_root_editorconfig() {
  write_document ".editorconfig" <<'EOF'
  root = true

  [*]
  charset = utf-8
  end_of_line = lf
  insert_final_newline = true
  indent_style = space
  indent_size = 2
  trim_trailing_whitespace = true

  [*.md]
  trim_trailing_whitespace = false

  [*.sh]
  indent_size = 2
EOF
}



###############################################################################
# GitHub Documents
###############################################################################

create_github_tree() {
  create_tree \
    ".github" \
    ".github/prompts"
}
write_github_documents() {
  write_github_copilot_instructions
  write_github_prompts_readme
  write_github_prompt_project_start
  write_github_prompt_project_specs
  write_github_prompt_project_kanban
  write_github_prompt_project_review
}


write_github_copilot_instructions() {
  write_document ".github/copilot-instructions.md" <<'EOF'
  # Copilot Instructions

  This repository is structured for AI-assisted project work.

  Copilot must treat 00-META as the project source of truth.

  ## Mandatory Reading Order

  Before generating or modifying project files, read:

  1. 00-META/context/README.md
  2. 00-META/context/open-arbitrations.md
  3. 00-META/context/risks.md
  4. 00-META/context/identity.md
  5. 00-META/context/vision.md
  6. 00-META/context/stack.yml
  7. 00-META/context/architecture.md
  8. 00-META/context/framing.md
  9. 00-META/governance/README.md
  10. Relevant files in 00-META/governance/
  11. 00-META/skills/README.md
  12. Relevant skills in 00-META/skills/
  13. Relevant playbook in 00-META/playbooks/

  ## Skill Selection

  Always read 00-META/skills/README.md.

  Load only the specialized skills relevant to the requested work.

  - Read technology skills when the corresponding technology is involved.
  - Read specs/SKILL.md when creating, modifying or reviewing specifications.
  - Read kanban/SKILL.md when creating, modifying, moving or reviewing tasks.
  - Read every relevant skill when a task affects multiple specialized areas.
  - Do not load unrelated specialized skills.


  ## Project Boundaries

  - Project truth belongs in 00-META/context.
  - Mandatory rules belong in 00-META/governance.
  - Specialized technology, workflow and structured-format constraints belong in 00-META/skills.
  - Reusable workflows belong in 00-META/playbooks.
  - Durable decisions belong in 00-META/decisions.
  - Legacy source code belongs in 09-LEGACY/codebase/ when legacy migration is enabled.
  - Legacy migration analysis and planning belong in 09-LEGACY/migration/ when legacy migration is enabled.
  - Target implementation code belongs in 04-ENGINEERING/.
  - Do not modify legacy code without explicit migration work.

  ## Agent Rules

  - Do not invent missing project facts.
  - Do not apply a technology skill that is not selected in 00-META/context/stack.yml.
  - Keep frontend, server, shell and delivery concerns separated.
  - Do not introduce unnecessary abstractions.
  - Do not treat TODO placeholders as confirmed requirements.
  - Update context or governance files when project truth changes.
  - Open arbitrations are not confirmed project facts.
  - Accepted arbitrations become project facts when reflected in the appropriate project documents.
  - Dropped arbitrations must not be reintroduced unless explicitly requested by the user.
  - Record confirmed project risks in 00-META/context/risks.md.
  - Do not use risks.md for open decisions or implementation tasks.
  - A mitigation requiring implementation must be tracked in the Kanban.
  - A mitigation requiring an unresolved choice must be tracked as an open arbitration.

  ## Project Workflow

  Follow the project lifecycle according to the requested scope:

  1. Verify that framing is sufficient for the requested work.
  2. Do not use open arbitrations as confirmed project facts.
  3. Create or update a specification for functional changes.
  4. Require a Ready specification before creating implementation tasks.
  5. Track confirmed implementation work in the project Kanban.
  6. Move the active task from BACKLOG to DOING when implementation begins.
  7. Apply the relevant playbook and technology skills.
  8. Keep implementation code in 04-ENGINEERING/.
  9. Move completed implementation from DOING to REVIEW.
  10. Apply the review prompt and review playbook.
  11. Move validated work from REVIEW to DONE.
  12. Synchronize only the affected specifications, documentation, decisions and
      context files.

  A new specification is not required for:

  - documentation-only corrections
  - technical corrections without functional impact
  - bugs whose expected behavior is already documented
  - internal maintenance without product impact

  Workflow transitions are not automatic.

  Do not:

  - implement work from an open arbitration
  - skip unresolved blocking decisions
  - use Kanban tasks as specifications
  - move unreviewed non-trivial work directly to DONE
  - update unrelated project documents
  - start the next major workflow without explicit user instruction

  ## Engineering Rules

  - Frontend code belongs in the generated client section when present.
  - Backend/runtime code belongs in the generated server section when present.
  - Platform shell code belongs in the generated shell section when present.
  - Experimental work belongs in 05-LAB until reviewed and promoted.
EOF
}
write_github_prompts_readme() {
  write_document ".github/prompts/README.md" <<'EOF'
  # Prompt Library

  This directory contains reusable prompts for AI-assisted project work.

  ## Prompts

  - project-start.prompt.md: run the initial project framing interview.
  - project-specs.prompt.md: generate and maintain project specifications.
  - project-kanban.prompt.md: generate and maintain the project Kanban.
  - project-review.prompt.md: review project consistency within a defined scope.

  ## Rules

  - Prompts must use 00-META as the source of truth.
  - Prompts must not invent project facts.
  - Prompts must respect the selected stack in 00-META/context/stack.yml.
  - Prompts must guide the user toward confirmed decisions before implementation.
EOF
}
write_github_prompt_project_start() {
  write_document ".github/prompts/project-start.prompt.md" <<EOF
  ---
  description: "Start a token-efficient factual project framing interview"
  name: "Project Start"
  argument-hint: "Optional brief, context or constraint"
  agent: "agent"
  ---

  You are starting the working session for ${PROJECT_NAME}.

  Your job is to run a short, factual and decision-oriented project framing
  interview.

  This is not a brainstorming session.

  ## Source Of Truth

  Read the project source of truth first:

  - ../../00-META/context/README.md
  - ../../00-META/context/open-arbitrations.md
  - ../../00-META/context/risks.md
  - ../../00-META/context/identity.md
  - ../../00-META/context/vision.md
  - ../../00-META/context/stack.yml
  - ../../00-META/context/architecture.md
  - ../../00-META/context/framing.md
  - ../../00-META/governance/README.md
  - ../../00-META/skills/README.md
  - ../../00-META/playbooks/README.md

  Use these files as the current factual baseline.

  ## Framing Source Of Truth

  framing.md defines:

  - confirmed framing decisions
  - unresolved framing decisions
  - interview objectives
  - expected framing outputs

  The interview must prioritize unresolved framing decisions.

  Do not ask questions about already confirmed decisions.

  ## Current Technical Profile

  The selected technical profile is documented in:

  - ../../00-META/context/stack.yml
  - ../../00-META/context/architecture.md

  Do not challenge the selected technical stack unless the user explicitly asks
  to change it.

  ## Goal


  Help the user complete the framing process documented in:

  - ../../00-META/context/framing.md

  Use framing.md as the primary framing source of truth.

  Only ask questions required to resolve missing framing decisions.

  ## No Invention Rule

  Do not invent product facts.

  Do not complete TODO fields with guessed content.

  Do not infer the business model, audience, roadmap, features, positioning or
  product scope beyond what is explicitly documented or confirmed by the user.

  If a field is unknown, keep it unknown and ask a targeted question.

  Any proposed option must be clearly labeled as an option, not as a fact.

  ## Interview Rules

  Be token-efficient.

  Ask only questions that reduce ambiguity or unlock a concrete documentation
  update.

  Prefer:

  - closed questions
  - multiple-choice questions
  - short factual questions
  - confirmation of explicit assumptions
  - tradeoff questions between concrete options

  Avoid:

  - vague questions
  - broad creative prompts
  - speculative product invention
  - asking the user to imagine the whole product from scratch
  - asking too many questions at once
  - expanding scope before the first project direction is clear

  When information is missing:

  1. state the missing decision
  2. explain why it matters in one short sentence
  3. ask the smallest useful question to resolve it

  ## Interview Scope

  Focus only on the first useful framing pass.

  Do not produce a full roadmap, backlog, specification or architecture proposal
  in the first response.

  The first pass should clarify:

  - primary audience
  - main problem
  - expected outcome
  - first useful milestone
  - explicit out-of-scope boundaries

  ## Behavior Rules

  - Use existing project files as the source of truth.
  - Do not treat TODO placeholders as confirmed requirements.
  - Clearly separate confirmed facts from assumptions and options.
  - Do not update project documentation before the user explicitly validates the understood decisions.
  - Respect the selected stack in ../../00-META/context/stack.yml.
  - Use relevant governance and skill files before proposing implementation.
  - Keep the interview short and precise.
  - Stop after the first set of questions and wait for the user's answers.
  - Do not generate specifications during the framing workflow.
  - Do not generate Kanban tasks during the framing workflow.
  - Do not begin implementation during the framing workflow.

  ## Document Responsibilities

  Keep each project fact in its appropriate document.

  ### identity.md

  Store only stable project identity information:

  - project name
  - project slug
  - concise description
  - mission
  - audience

  ### vision.md

  Store confirmed product direction:

  - product direction
  - target audience
  - value proposition
  - core problem
  - expected outcome
  - in-scope boundaries
  - out-of-scope boundaries
  - success signals

  ### framing.md

  Track the operational state of the framing process:

  - confirmed framing decisions
  - unresolved framing decisions
  - first milestone
  - explicit out-of-scope boundaries
  - confirmed constraints
  - framing completion status

  Confirmed constraints may include:

  - budget constraints
  - schedule constraints
  - team constraints
  - technical constraints
  - legal or compliance constraints
  - organizational constraints
  - operational constraints

  Record only constraints explicitly confirmed by the user.

  Do not generate empty constraint categories.

  Do not duplicate technical choices already represented in stack.yml.

  Do not duplicate mandatory recurring rules already represented in governance.

  Do not duplicate complete identity or vision content in framing.md.

  framing.md may reference confirmed decisions in concise form when required to
  track framing completion.

  ### architecture.md

  Store confirmed technical architecture and delivery decisions:

  - architecture layers
  - runtime boundaries
  - CI/CD
  - hosting
  - observability

  CI/CD, hosting and observability must remain Not defined until explicitly
  confirmed by the user.

  Do not infer a provider, platform or implementation from the selected stack.

  ### open-arbitrations.md

  Store only unresolved decisions for which multiple valid options remain.

  An open arbitration is not a confirmed project fact.

  Do not create an arbitration for a simple missing value that can be resolved by
  a direct factual question.

  ### risks.md

  Store only confirmed project risks.

  A risk describes a possible adverse outcome that may affect the project.

  Do not use risks.md for:

  - unresolved decisions
  - implementation tasks
  - generic concerns without confirmed project context
  - outcomes already known to have occurred

  When a risk is identified, record:

  - its area
  - its impact
  - its likelihood
  - its mitigation
  - its trigger
  - its related files

  ### decisions/

  Create an ADR only when a confirmed decision:

  - has durable architectural, technical, product or workflow consequences
  - selects between meaningful alternatives
  - must remain understandable over time

  Do not create an ADR for every framing answer.

  ## Answer Processing Workflow

  After the user answers the framing questions:

  1. Interpret only the information explicitly provided by the user.
  2. Compare the answers with the existing project source of truth.
  3. Identify contradictions, ambiguities, confirmed constraints and remaining missing decisions.
  4. Summarize the decisions understood from the answers.
  5. Clearly separate:
     - confirmed decisions
     - proposed interpretations
     - unresolved decisions
     - required arbitrations
  6. Ask the user to validate or correct the summarized decisions.
  7. Do not modify project files before this explicit validation.

  If an answer is ambiguous:

  - do not select an interpretation silently
  - state the ambiguity
  - ask the smallest useful clarification question
  - keep the affected decision unresolved

  If an answer contradicts an existing confirmed project fact:

  - identify the contradiction
  - identify the affected document
  - do not replace the existing fact silently
  - request explicit confirmation of the change

  ## Confirmed Update Workflow

  After the user explicitly validates the summarized decisions:

  1. Update ../../00-META/context/identity.md with confirmed identity information.
  2. Update ../../00-META/context/vision.md with confirmed product direction.
  3. Update ../../00-META/context/architecture.md only when architecture or delivery decisions were explicitly confirmed.
  4. Update ../../00-META/context/framing.md with:
     - newly confirmed framing decisions
     - remaining missing decisions
     - first milestone
     - explicit out-of-scope boundaries
     - explicitly confirmed constraints
     - current framing status
  5. Update ../../00-META/context/open-arbitrations.md only when:
     - multiple valid options remain
     - the decision cannot yet be confirmed
     - the unresolved decision affects project direction, scope, architecture or workflow
  6. Update ../../00-META/context/risks.md only when a project risk is explicitly identified from confirmed context.
  7. Create or update an ADR only when the validated decision has durable and consequential impact.
  8. Re-read all modified context documents.
  9. Check for contradictions, duplicated facts and unresolved placeholders.
  10. Report every modified file.

  When a risk is confirmed:

  - assign a stable RISK-XXX identifier
  - record it in the Active section
  - use only supported area, impact and likelihood values
  - keep mitigation and trigger factual
  - create a Kanban task when mitigation requires confirmed implementation work
  - create an open arbitration when mitigation requires an unresolved choice
  - create or update an ADR when the response produces a durable and consequential decision
  - move the risk to Closed only when the risk is resolved or no longer applicable
  - do not delete closed risks

  When a constraint is confirmed:

  - record it in framing.md only when it affects project scope, delivery, architecture, implementation or operation
  - keep the wording factual and concise
  - do not create constraint categories that have no confirmed value
  - do not duplicate selected technologies from stack.yml
  - do not duplicate mandatory recurring rules from governance
  - create or update an ADR only when the constraint produces a durable and consequential decision
  - create an open arbitration when the constraint exposes multiple valid options that remain unresolved

  When CI/CD, hosting or observability is confirmed:

  - replace Not defined only with explicitly confirmed information
  - update architecture.md
  - create or update an ADR when the decision has durable architectural or operational consequences
  - do not change stack.yml unless the confirmed decision changes the technical profile represented there

  Do not remove an open arbitration merely because it was discussed.

  Move an arbitration out of the Open section only after the user explicitly
  accepts or drops it.

  When an arbitration is accepted:

  - reflect the accepted decision in the appropriate project source-of-truth file
  - record an ADR when the decision has durable consequences
  - keep the arbitration record consistent with the accepted project state

  When an arbitration is dropped:

  - do not introduce the dropped option into project documents
  - preserve enough information to prevent the proposal from being silently reintroduced

  ## Framing Completion Criteria

  The initial framing pass is complete only when all of the following decisions
  are explicitly confirmed:

  - primary audience
  - core problem
  - expected outcome
  - first useful milestone
  - explicit out-of-scope boundaries

  Framing is not complete when:

  - one of these decisions remains TODO
  - one of these decisions remains ambiguous
  - a known constraint affecting the first milestone remains undefined
  - an unresolved arbitration blocks the first milestone
  - identity.md, vision.md and framing.md contradict each other

  When the initial framing is complete:

  - update framing.md to reflect completion
  - list any non-blocking open arbitrations that remain
  - report the modified files
  - recommend the specification workflow

  Recommend:

  - ../../.github/prompts/project-specs.prompt.md

  Do not execute the specification workflow automatically.

  ## Post-Update Response

  After updating the validated project documents, produce only:

  1. Confirmed decisions
     - list the decisions recorded during this framing cycle

  2. Modified files
     - list every file that was created or modified
     - state briefly what changed in each file

  3. Remaining decisions
     - list only unresolved decisions
     - identify blocking decisions separately

  4. Open arbitrations
     - list arbitrations created, accepted or dropped during this cycle

  5. Risks
     - list risks created, updated or closed during this cycle
     - identify risks blocking the first milestone

  6. Framing status
     - INCOMPLETE when required framing decisions remain unresolved
     - COMPLETE when all initial framing completion criteria are satisfied

  7. Recommended next action
     - continue the framing interview when status is INCOMPLETE
     - use project-specs.prompt.md when status is COMPLETE

  Do not generate specifications, Kanban tasks or implementation code in this response.

  ## Expected First Response

  Produce only:

  1. Known facts
     - maximum 5 bullets
     - only facts found in the project files

  2. Missing decisions
     - maximum 5 bullets
     - each item must explain why the decision matters

  3. First interview questions
     - maximum 5 questions
     - prefer multiple-choice or short factual answers
     - avoid vague creative questions

  4. Documentation targets
     - list which files should be updated after the user confirms answers

  Do not write or rewrite project documentation in the first response.
EOF
}
write_github_prompt_project_specs() {
  write_document ".github/prompts/project-specs.prompt.md" <<'EOF'
  ---
  description: "Generate and maintain project specifications from confirmed requirements"
  ---

  Read first:

  - ../../00-META/context/framing.md
  - ../../00-META/context/open-arbitrations.md
  - ../../00-META/context/identity.md
  - ../../00-META/context/vision.md
  - ../../00-META/context/stack.yml
  - ../../00-META/decisions/
  - ../../00-META/skills/specs/SKILL.md
  - ../../00-META/templates/specs/SPEC-TEMPLATE.md
  - ../../03-PRODUCT/specs/README.md
  - ../../03-PRODUCT/features/
  - ../../03-PRODUCT/ux-flows/

  ## Goal

  Create or update project specifications from confirmed project requirements.

  ## Source Of Truth

  Active specifications belong in:

  - ../../03-PRODUCT/specs/

  Specification rules are defined in:

  - ../../00-META/skills/specs/SKILL.md

  ## Mandatory Rules

  - Use only confirmed requirements.
  - Do not invent missing requirements.
  - Do not treat TODO placeholders as confirmed requirements.
  - Do not silently decide open arbitrations.
  - Do not reintroduce dropped arbitrations.
  - Do not create a duplicate specification.
  - Update an existing specification when its scope already covers the requested change.
  - Follow the required specification structure and naming convention.

  ## Workflow

  1. Read the confirmed project context.
  2. Read accepted decisions relevant to the requested scope.
  3. Check open-arbitrations.md for unresolved decisions.
  4. Search existing specifications for overlapping scope.
  5. Identify confirmed requirements.
  6. Identify missing decisions and open questions.
  7. Create or update the smallest coherent specification.
  8. Keep implementation task planning outside the specification.

  ## Specifications And Kanban

  Do not create Kanban tasks unless explicitly requested.

  When Kanban work is requested:

  - use only Ready specifications
  - follow ../../00-META/skills/kanban/SKILL.md
  - create implementation tasks in ../../03-PRODUCT/kanban/TASKS.md

  ## Expected Output

  Before modifying files, report:

  - existing specification affected, if any
  - confirmed requirements
  - missing decisions
  - open arbitrations affecting the scope
  - target specification file

  Then create or update the specification only when enough confirmed information exists.

  If required information is missing, identify the smallest decisions needed and stop before inventing content.
EOF
}
write_github_prompt_project_kanban() {
  write_document ".github/prompts/project-kanban.prompt.md" <<'EOF'
  ---
  description: "Generate and maintain the project kanban"
  ---

  Read first:

  - ../../00-META/context/framing.md
  - ../../00-META/decisions/
  - ../../00-META/skills/kanban/SKILL.md
  - ../../03-PRODUCT/kanban/TASKS.md
  - ../../00-META/context/open-arbitrations.md

  ## Goal

  Maintain the project kanban using the Markdown Kanban Roadmap format.

  ## Source Of Truth

  The project kanban is:

  - ../../03-PRODUCT/kanban/TASKS.md

  Detailed task files are stored in:

  - ../../03-PRODUCT/kanban/tasks/

  ## Mandatory Rules

  - Follow all rules defined in:
    ../../00-META/skills/kanban/SKILL.md
  - Do not invent a custom kanban format.
  - Do not invent unsupported columns.
  - Do not invent unsupported task properties.
  - Do not create alternative task boards.
  - Do not duplicate kanban information elsewhere.

  ## Scope Rules

  - Create tasks only for confirmed project work.
  - Use framing.md as the primary source of project scope.
  - Use specifications and ADRs when available.
  - Do not invent features.
  - Do not invent milestones.
  - Do not create implementation tasks from open arbitrations.
  - Accepted arbitrations may become tasks only after they are reflected in the appropriate project documents.
  - Dropped arbitrations must not be reintroduced.

  ## Task Rules

  - One task = one deliverable.
  - Keep tasks reviewable.
  - Avoid oversized tasks.
  - Split large work into multiple tasks.
  - Keep task titles concise and explicit.

  ## Status Rules

  Task status is defined by its column.

  Never add:

  - status
  - state
  - progress

  ## Detail Files

  When a task contains:

  detail: ./tasks/T-XXX.md

  the file must exist.

  The detail file:

  - must match the task id
  - must contain implementation context when needed
  - must not duplicate TASKS.md metadata

  ## Expected Output

  When updating the kanban:

  - explain created tasks
  - explain modified tasks
  - explain moved tasks
  - explain removed tasks

  Keep the board compatible with the Markdown Kanban Roadmap extension.
EOF
}
write_github_prompt_project_review() {
  write_document ".github/prompts/project-review.prompt.md" <<'EOF'
  ---
  description: "Review project consistency without expanding the requested scope"
  ---

  ## Required Reading

  Read first:

  - ../../00-META/context/README.md
  - ../../00-META/context/open-arbitrations.md
  - ../../00-META/context/risks.md
  - ../../00-META/context/identity.md
  - ../../00-META/context/vision.md
  - ../../00-META/context/stack.yml
  - ../../00-META/context/architecture.md
  - ../../00-META/context/framing.md
  - ../../00-META/governance/README.md
  - ../../00-META/governance/architecture-rules.md
  - ../../00-META/governance/naming-rules.md
  - ../../00-META/governance/security-rules.md
  - ../../00-META/decisions/
  - ../../00-META/skills/README.md
  - ../../00-META/playbooks/review.md

  Read relevant technology, Kanban and specification skills according to the
  review scope.

  ## Goal

  Review the requested project scope for consistency, correctness and compliance
  with the documented project source of truth.

  A review identifies problems.

  A review must not become an unrelated redesign, migration or refactoring task.

  ## Review Scope

  If the user identifies files, directories or changes, review only that scope
  and the directly affected project documents.

  If no explicit scope is provided, perform a project-wide consistency review.

  Do not expand the review scope without a concrete dependency or documented
  inconsistency.

  ## Sources Of Truth

  Use:

  - context for current project facts
  - open-arbitrations.md for unresolved, accepted and dropped arbitrations
  - governance for mandatory project-wide rules
  - skills for specialized technology, workflow and format rules
  - playbooks for reusable workflows
  - decisions for durable accepted decisions
  - specifications for confirmed expected behavior
  - Kanban for implementation task state
  - risks.md for confirmed project risks and their mitigation status

  ## Review Checks

  Verify:

  - consistency between context documents
  - consistency between stack.yml and generated engineering sections
  - compliance with governance rules
  - compliance with relevant skills
  - compliance with accepted decisions
  - absence of reintroduced dropped arbitrations
  - absence of open arbitrations presented as confirmed facts
  - absence of invented requirements
  - specification consistency
  - Kanban format consistency
  - references to existing files
  - naming consistency
  - architecture boundary compliance
  - documentation alignment with implementation structure
  - duplicated or contradictory project information
  - obsolete references
  - unsupported assumptions
  - changes outside the requested scope
  - risk register consistency
  - absence of generic or invented risks
  - validity of risk identifiers and supported values
  - consistency between risks, mitigations, arbitrations and Kanban tasks
  - closed risks remaining preserved in the Closed section

  ## Finding Severity

  Use only:

  - BLOCKING: prevents correct execution, generation or project use
  - MAJOR: creates contradiction, invalid structure or significant project risk
  - MINOR: creates limited inconsistency, ambiguity or maintainability cost

  Do not assign severity without identifying a concrete impact.

  ## Finding Format

  Each finding must contain:

  - Severity
  - Location
  - Finding
  - Evidence
  - Required Correction

  Use precise file paths and function, section or symbol names.

  Do not report vague findings.

  Do not report personal style preferences as defects.

  ## Correction Rules

  Separate findings into:

  - deterministic corrections
  - corrections requiring user arbitration

  A deterministic correction is directly required by an existing project rule,
  accepted decision or confirmed source of truth.

  An arbitration is required when:

  - multiple valid solutions exist
  - the project source of truth is incomplete
  - an open arbitration already covers the subject
  - the correction would change project scope or architecture

  Do not silently resolve an arbitration.

  Do not silently modify accepted decisions.

  Do not reintroduce dropped arbitrations.

  ## Modification Rules

  Do not modify files unless the user explicitly requests corrections.

  When corrections are requested:

  - modify only deterministic findings
  - preserve validated structure
  - avoid unrelated cleanup
  - avoid broad rewrites
  - list every modified file
  - leave arbitration items unchanged

  ## Specifications And Kanban

  Verify that specifications:

  - use confirmed requirements
  - follow the specifications skill
  - do not duplicate existing specification scope
  - do not silently resolve open questions

  Verify that the Kanban:

  - follows the Kanban skill
  - contains only supported columns and properties
  - does not create tasks from open arbitrations
  - does not use tasks as specifications
  - references existing detail files

  Do not generate specifications or Kanban tasks during a review unless explicitly
  requested.

  ## Risks

  Verify that risks:

  - follow the format defined in 00-META/context/risks.md
  - use unique and stable RISK-XXX identifiers
  - use supported area, impact and likelihood values
  - are grounded in confirmed project context
  - are not used as open decisions
  - are not used as implementation tasks
  - reference a Kanban task when mitigation requires confirmed implementation
  - reference an open arbitration when mitigation requires an unresolved choice
  - remain preserved when moved to Closed

  ## Expected Output

  Produce only:

  1. Review Scope
  2. Validated Elements
  3. Blocking Findings
  4. Major Findings
  5. Minor Findings
  6. Required Arbitrations
  7. Deterministic Corrections
  8. Recommended Commit

  Omit empty finding sections.

  If no issue is found, state that no issue was identified within the reviewed
  scope.

  Do not claim that unreviewed project areas are valid.
EOF
}



###############################################################################
# 00-META
###############################################################################

create_meta_tree() {
  local base_dir="00-META"
  local skill

  create_tree \
    "$base_dir" \
    "$base_dir/context" \
    "$base_dir/governance" \
    "$base_dir/playbooks" \
    "$base_dir/decisions" \
    "$base_dir/templates" \
    "$base_dir/templates/decisions" \
    "$base_dir/templates/kanban" \
    "$base_dir/templates/specs" \
    "$base_dir/skills" \
    "$base_dir/skills/kanban" \
    "$base_dir/skills/specs"

  for skill in \
    "$FRONTEND_STACK" \
    "$FRONTEND_VARIANT" \
    "$BACKEND_STACK" \
    "$BACKEND_FRAMEWORK" \
    "$SHELL_DESKTOP" \
    "$SHELL_MOBILE" \
    "$SHELL_WEB" \
    "${DATABASES_SELECTED[@]-}" \
    "${SEARCH_ENGINES_SELECTED[@]-}"; do

    if [[ -z "$skill" || "$skill" == "none" ]]; then
      continue
    fi

    create_tree "$base_dir/skills/$skill"
  done
}
write_meta_documents() {
  write_meta_context_readme
  write_meta_context_identity
  write_meta_context_vision
  write_meta_context_stack
  write_meta_context_architecture
  write_meta_context_framing
  write_meta_context_open_arbitrations
  write_meta_context_risks

  write_meta_governance_readme
  write_meta_governance_architecture_rules
  write_meta_governance_naming_rules
  write_meta_governance_git_rules
  write_meta_governance_security_rules

  write_meta_skills_readme
  write_meta_skill_documents
  write_meta_skill_kanban
  write_meta_skill_specs

  write_meta_playbooks_readme
  write_meta_playbook_feature
  write_meta_playbook_bugfix
  write_meta_playbook_review
  write_meta_playbook_release
  write_meta_playbook_migration

  write_meta_decisions_readme
  write_meta_templates_readme
  write_meta_template_decision_adr
  write_meta_template_kanban_tasks
  write_meta_template_kanban_task
  write_meta_template_spec
  write_meta_templates_specs_readme
}


write_meta_context_readme() {
  write_document "00-META/context/README.md" <<'EOF'
  # Context

  This directory contains the current source of truth for the project.

  It is intended to be read first by AI agents before modifying, generating or
  reviewing project files.

  ## Documents

  ### identity.md

  Describes the project identity: name, slug, description, mission and audience.

  ### vision.md

  Describes the product direction, target audience, value proposition and
  framing questions that still need to be answered.

  ### stack.yml

  Describes the selected technical stack in a machine-readable format.

  This document is used by AI agents to understand which frontend, backend,
  runtime, shell and delivery targets are active.

  ### architecture.md

  Describes the generated architecture in human-readable form.

  It explains how frontend, server, runtime and shell sections relate to each
  other according to the CLI interview answers.

  ### framing.md

  Tracks framing status, confirmed decisions, unresolved questions and the expected AI interview scope.

  ### open-arbitrations.md

  Tracks unresolved project decisions, accepted arbitrations and dropped proposals.

  Open arbitrations are not project facts.

  ### risks.md

  Tracks confirmed project risks, their impact, likelihood, mitigation and
  resolution state.

  Risks are not decisions, tasks or confirmed outcomes.

  ## Rules

  - Context files describe the current state of the project.
  - Context files should remain concise and stable.
  - Detailed implementation rules belong in 00-META/governance.
  - Specialized technology, workflow and structured-format constraints belong in 00-META/skills.
  - Durable decisions belong in 00-META/decisions.
EOF
}
write_meta_context_identity() {
  write_document "00-META/context/identity.md" <<EOF
  # Identity

  ## Project Name

  ${PROJECT_NAME}

  ## Project Slug

  ${PROJECT_SLUG}

  ## Description

  TODO

  ## Mission

  TODO

  ## Audience

  TODO

EOF
}
write_meta_context_stack() {
  write_document "00-META/context/stack.yml" <<EOF
  project:
    name: "$(yaml_escape "$PROJECT_NAME")"
    slug: "$(yaml_escape "$PROJECT_SLUG")"

  frontend:
    enabled: ${PROJECT_HAS_FRONTEND}
    stack: "$(yaml_escape "$FRONTEND_STACK")"
    name: "$(yaml_escape "$PROJECT_FRONTEND_NAME")"
    variant: "$(yaml_escape "$FRONTEND_VARIANT")"
    variantName: "$(yaml_escape "$PROJECT_FRONTEND_VARIANT_NAME")"

  server:
    enabled: ${PROJECT_HAS_SERVER}
    stack: "$(yaml_escape "$BACKEND_STACK")"
    name: "$(yaml_escape "$PROJECT_BACKEND_NAME")"
    framework: "$(yaml_escape "$BACKEND_FRAMEWORK")"
    frameworkName: "$(yaml_escape "$PROJECT_BACKEND_FRAMEWORK_NAME")"
    local: ${ENABLED_SERVER_LOCAL}
    remote: ${ENABLED_SERVER_REMOTE}
    assets: ${ENABLED_SERVER_ASSETS}

  $(write_yaml_data_section | write_embedded_lines)

  shell:
    desktop:
      enabled: ${PROJECT_HAS_DESKTOP}
      stack: "$(yaml_escape "$SHELL_DESKTOP")"
      name: "$(yaml_escape "$PROJECT_DESKTOP_SHELL_NAME")"

    mobile:
      enabled: ${PROJECT_HAS_MOBILE}
      stack: "$(yaml_escape "$SHELL_MOBILE")"
      name: "$(yaml_escape "$PROJECT_MOBILE_SHELL_NAME")"

    web:
      enabled: ${PROJECT_HAS_WEB}
      stack: "$(yaml_escape "$SHELL_WEB")"
      name: "$(yaml_escape "$PROJECT_WEB_SHELL_NAME")"

  legacy:
    enabled: ${PROJECT_HAS_LEGACY}
    codebase: "09-LEGACY/codebase"
    migration: "09-LEGACY/migration"
EOF
}
write_meta_context_vision() {
  write_document "00-META/context/vision.md" <<'EOF'
  # Vision

  ## Product Direction

  TODO

  ## Target Audience

  TODO

  ## Value Proposition

  TODO

  ## Core Problem

  TODO

  ## Expected Outcome

  TODO

  ## Scope

  ### In Scope

  TODO

  ### Out Of Scope

  TODO

  ## Success Signals

  TODO

  ## Open Questions

  - What concrete problem should this project solve first?
  - Who is the primary audience?
  - What outcome would make the first version successful?
  - What should explicitly stay out of scope?
  - Which constraint is most likely to shape the project?
EOF
}
write_meta_context_architecture() {
  local key

  write_document "00-META/context/architecture.md" <<EOF
  # Architecture

  This document describes the generated technical architecture for the project.

  It is based on the CLI interview answers and must stay aligned with
  stack.yml and 04-ENGINEERING.

  ## Generated Technical Profile

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- Frontend: ${PROJECT_FRONTEND_NAME}"
    [[ "$FRONTEND_VARIANT" != "none" ]] && printf '%s\n' "- Frontend Variant: ${PROJECT_FRONTEND_VARIANT_NAME}"
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- Backend: ${PROJECT_BACKEND_NAME}"
    [[ "$BACKEND_FRAMEWORK" != "none" ]] && printf '%s\n' "- Backend Framework: ${PROJECT_BACKEND_FRAMEWORK_NAME}"
    [[ -n "${DATABASES_SELECTED[0]+x}" ]] && printf '%s\n' "- Databases: ${PROJECT_DATABASE_NAMES}"
    [[ -n "${SEARCH_ENGINES_SELECTED[0]+x}" ]] && printf '%s\n' "- Search Engines: ${PROJECT_SEARCH_ENGINE_NAMES}"
    [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- Local Runtime: enabled"
    [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- Remote Runtime: enabled"
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- Asset Server: enabled"
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- Desktop Shell: ${PROJECT_DESKTOP_SHELL_NAME}"
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- Mobile Shell: ${PROJECT_MOBILE_SHELL_NAME}"
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- Web Shell: ${PROJECT_WEB_SHELL_NAME}"
    true
  } | write_embedded_lines )

  ## Layers

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- client: user interface application."
    [[ "$PROJECT_HAS_SERVER" == "true" ]] && printf '%s\n' "- server: runtime, backend or delivery material."
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- server/modules: reusable backend/runtime modules."
    [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- server/local: local runtime entry point."
    [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- server/remote: remote runtime entry point."
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- server/assets: shared asset delivery."
    [[ "$PROJECT_HAS_DESKTOP" == "true" || "$PROJECT_HAS_MOBILE" == "true" || "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell: platform shell layer."
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- shell/desktop: desktop shell implementation."
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- shell/mobile: mobile shell implementation."
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell/web: web exposure and runtime integration of the frontend client."
    true
  } | write_embedded_lines )

  ## Data Architecture

  ### Databases And Data Stores

  $(if [[ -z "${DATABASES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "None."
  else
    {
      for key in "${DATABASES_SELECTED[@]}"; do
        printf '%s\n' "- $(registry_label "$key" "${DATABASES[@]}")"
      done
    } | write_embedded_lines
  fi)

  ### Search Engines

  $(if [[ -z "${SEARCH_ENGINES_SELECTED[0]+x}" ]]; then
    printf '%s\n' "None."
  else
    {
      for key in "${SEARCH_ENGINES_SELECTED[@]}"; do
        printf '%s\n' "- $(registry_label "$key" "${SEARCH_ENGINES[@]}")"
      done
    } | write_embedded_lines
  fi)

  ## Architecture Rules

  - Keep frontend, server, shell and delivery concerns separated.
  - Runtime composition belongs to local or remote entry points.
  - Reusable backend/runtime logic belongs in server/modules when a backend stack is selected.
  - Shells expose or integrate the client with the selected target environment.
  - Runtime concerns and asset delivery concerns must remain separated.
  - The asset server is an autonomous server capability.
  - Asset delivery does not require a local runtime, remote runtime or backend stack.
  - The asset server technology must remain undefined until explicitly selected.
  - Shared asset delivery must remain separated from frontend assets, backend runtime logic and web shell responsibilities.
  - A frontend variant must not implicitly select or replace the backend stack.
  - Server-side capabilities required by a frontend variant remain part of the client or web shell integration unless explicitly modeled as backend runtime responsibilities.
  - Databases and search engines are independent infrastructure capabilities.
  - Selecting a database must not implicitly select a backend stack or framework.
  - Selecting a search engine must not implicitly select a database.
  - A search engine must not silently become the primary source of truth.
  - Data ownership, synchronization and indexing boundaries must be documented when relevant.
  - Multiple selected data services must have explicit responsibilities before implementation.

  ## Delivery

  ### CI/CD

  Not defined.

  ### Hosting

  Not defined.

  ### Observability

  Not defined.

  Delivery values must remain undefined until they are explicitly confirmed.

  Do not infer a CI/CD platform, hosting provider or observability stack from the
  selected application stack.

  ## Notes

  This document is a human-readable architecture summary.

  The machine-readable technical source of truth is:

  - stack.yml

  Detailed implementation constraints belong in:

  - 00-META/governance
  - 00-META/skills
EOF
}
write_meta_context_framing() {
  write_document "00-META/context/framing.md" <<EOF
  # Framing

  ## Confirmed

  ### Project

  - Name: ${PROJECT_NAME}
  - Slug: ${PROJECT_SLUG}

  ### Technical Profile

  - Frontend: ${PROJECT_FRONTEND_NAME}
  - Frontend Variant: ${PROJECT_FRONTEND_VARIANT_NAME}
  - Backend: ${PROJECT_BACKEND_NAME}
  - Backend Framework: ${PROJECT_BACKEND_FRAMEWORK_NAME}
  - Databases: ${PROJECT_DATABASE_NAMES}
  - Search Engines: ${PROJECT_SEARCH_ENGINE_NAMES}
  - Desktop Shell: ${PROJECT_DESKTOP_SHELL_NAME}
  - Mobile Shell: ${PROJECT_MOBILE_SHELL_NAME}
  - Web Shell: ${PROJECT_WEB_SHELL_NAME}
  - Legacy Migration: ${PROJECT_HAS_LEGACY}

  ## Framing Status

  ### Primary Audience

  TODO

  ### Core Problem

  TODO

  ### Expected Outcome

  TODO

  ### First Milestone

  TODO

  ### Explicit Out Of Scope

  TODO

  ## Confirmed Constraints

  None.

  ## Missing Decisions

  - Primary audience
  - Core problem
  - Expected outcome
  - First milestone
  - Out of scope boundaries

  ## Interview Instructions

  The next AI interview must focus on unresolved framing decisions.

  Do not ask about information already confirmed in this document.

  Prefer short factual questions.

  Prefer closed questions and explicit choices.

  Avoid brainstorming.

  Update this file as framing decisions become confirmed.
EOF
}
write_meta_context_open_arbitrations() {
  write_document "00-META/context/open-arbitrations.md" <<'EOF'
  # Open Arbitrations

  This document tracks unresolved project decisions.

  Open arbitrations are not project facts.

  AI agents must not silently decide an open arbitration unless explicitly instructed by the user.

  ------------------------------------------------------------------------

  ## Open

  None.

  ------------------------------------------------------------------------

  ## Accepted

  None.

  ------------------------------------------------------------------------

  ## Dropped

  None.

EOF
}
write_meta_context_risks() {
  write_document "00-META/context/risks.md" <<'EOF'
  # Risks

  This document tracks confirmed project risks.

  A risk is not a confirmed outcome.

  Do not use this document for open decisions, implementation tasks or
  unconfirmed generic concerns.

  ## Active

  None.

  ## Closed

  None.

  ## Risk Format

  ### RISK-XXX - Risk Title

  - area:
  - impact:
  - likelihood:
  - mitigation:
  - trigger:
  - relatedFiles:

  ## Allowed Areas

  - scope
  - product
  - design
  - engineering
  - security
  - delivery
  - operations
  - compliance

  ## Allowed Impact Values

  - low
  - medium
  - high
  - critical

  ## Allowed Likelihood Values

  - low
  - medium
  - high

  ## Rules

  - Record only risks identified from confirmed project context.
  - Keep risk identifiers unique and stable.
  - Do not use risks as open arbitrations.
  - Do not use risks as implementation tasks.
  - Do not invent generic risks.
  - Move resolved risks from Active to Closed.
  - Do not delete closed risks.
  - Create a Kanban task when a confirmed mitigation requires implementation.
  - Create an open arbitration when a mitigation requires an unresolved choice.
  - Create or update an ADR when the response to a risk produces a durable and consequential decision.
EOF
}


write_meta_governance_readme() {
  write_document "00-META/governance/README.md" <<'EOF'
  # Governance

  This directory contains mandatory project rules for humans and AI agents.

  Governance documents define how the project must be structured, named,
  modified, secured and maintained.

  ## Documents

  ### architecture-rules.md

  Defines global architecture rules that apply across frontend, backend,
  runtime, shell and documentation layers.

  ### naming-rules.md

  Defines naming conventions for files, folders, modules, components and
  technical concepts.

  ### git-rules.md

  Defines source control and commit rules.

  ### security-rules.md

  Defines baseline security expectations.

  ## Rules

  - Governance documents are mandatory.
  - AI agents must read governance rules before generating implementation code.
  - Specialized technology, workflow and structured-format rules belong in 00-META/skills.
  - Current project facts belong in 00-META/context.
  - Durable decisions belong in 00-META/decisions.
EOF
}
write_meta_governance_architecture_rules() {
  write_document "00-META/governance/architecture-rules.md" <<'EOF'
  # Architecture Rules

  ## Global Principles

  - Keep responsibilities separated.
  - Do not mix frontend, backend, shell and deployment concerns.
  - Prefer explicit structure over hidden conventions.
  - Avoid unnecessary abstraction.
  - Avoid premature microservices architecture.
  - Keep generated structure understandable by humans and AI agents.

  ## Frontend

  - Frontend code belongs in the client area.
  - Frontend must not contain backend runtime logic.
  - UI logic must remain separated from server execution concerns.

  ## Server

  - Server modules must remain reusable.
  - Runtime composition belongs to local or remote entry points.
  - Modules should not depend on whether they run locally or remotely.
  - Transport-specific concerns must stay at runtime boundaries.

  ## Shells

  - Shells wrap the client and connect it to the runtime environment.
  - Shells must not contain business modules directly.
  - Desktop, mobile and web shells must remain separated.

  ## Documentation

  - Context describes the current state.
  - Governance defines mandatory rules.
  - Skills define specialized technology, workflow and structured-format constraints.
  - Decisions store durable project decisions.
  - Templates store reusable document models.
EOF
}
write_meta_governance_naming_rules() {
  write_document "00-META/governance/naming-rules.md" <<'EOF'
  # Naming Rules

  ## General Rules

  - Use explicit names.
  - Avoid vague names such as misc, common, stuff or utils when a clearer name exists.
  - Prefer domain-oriented names over technical shortcuts.
  - Keep naming consistent across folders, files and documentation.

  ## Files And Folders

  - Use lowercase folder names.
  - Use kebab-case for multi-word folders and files.
  - Keep README.md files for directory-level explanations.
  - Use SKILL.md as the entry point for specialized AI skill instructions.

  ## Project Metadata

  - Project slug must remain lowercase and URL-safe.
  - The slug is used for generated engineering workspace paths.
  - Human-readable labels belong in documentation.
  - Machine-readable identifiers belong in YAML or configuration files.

  ## AI-Oriented Naming

  - Directory names must describe their role clearly.
  - context means current source of truth.
  - governance means mandatory rules.
  - skills means specialized technology, workflow and structured-format instructions.
  - playbooks means reusable workflows.
  - decisions means durable project decisions.
  - templates means reusable document models.
EOF
}
write_meta_governance_git_rules() {
  write_document "00-META/governance/git-rules.md" <<'EOF'
  # Git Rules

  ## Commit Format

  Use the following format when proposing commits:

  ```bash
  git add . && git commit -m "message"
  ```

  ## Commit Rules

  - Keep commits focused.
  - One commit should represent one coherent change.
  - Avoid mixing unrelated refactors and feature changes.
  - Do not commit temporary debug code.
  - Do not commit generated noise unless it is expected project output.

  ## Message Rules

  - Use concise commit messages.
  - Use lowercase imperative style when possible.
  - Describe the change, not the process.
  - Avoid vague messages such as update, fix stuff or changes.
EOF
}
write_meta_governance_security_rules() {
  write_document "00-META/governance/security-rules.md" <<'EOF'
  # Security Rules

  ## Baseline Rules

  - Do not commit secrets.
  - Do not hardcode credentials.
  - Do not store tokens in generated documentation.
  - Do not expose private infrastructure details unless explicitly required.

  ## Configuration

  - Sensitive values must be externalized.
  - Environment-specific values must not be mixed with source code.
  - Local development configuration must remain clearly separated from production configuration.

  ## AI Agent Rules

  - AI agents must not invent secrets, credentials or private endpoints.
  - AI agents must not generate insecure defaults without clearly marking them as temporary.
  - AI agents must prefer safe placeholders when security-sensitive values are required.

  ## Generated Projects

  - Security assumptions must be documented.
  - Authentication and authorization rules must be defined before production implementation.
  - External integrations must be reviewed before being treated as trusted.
EOF
}


write_meta_skills_readme() {
  local skill

  write_document "00-META/skills/README.md" <<EOF
  # Skills

  This directory contains specialized instructions for AI agents.

  Technology skills are generated from the CLI interview answers.

  Workflow and format skills may be generated independently when they define
  mandatory project conventions.

  Each skill directory describes how an AI agent must work with a selected
  technology, runtime, shell, workflow or structured format.

  ## Role

  Skills provide specialized implementation, workflow or format constraints.

  They are not the project identity.

  They are not global architecture rules.

  They are not historical decisions.

  ## Relationship With Other META Directories

  - 00-META/context describes the current project state.
  - 00-META/governance defines mandatory project-wide rules.
  - 00-META/skills defines specialized technology, workflow and structured-format rules.
  - 00-META/playbooks defines reusable workflows.
  - 00-META/decisions stores durable project decisions.

  ## Agent Rules

  - AI agents must read the relevant skill before generating code for a selected technology.
  - AI agents must combine skills with governance rules.
  - AI agents must not apply a technology skill that is not selected in context/stack.yml.
  - Workflow and format skills apply only when their documented project area is modified or reviewed.
  - AI agents must not invent technology constraints that are not documented here.

  ## Active Skills

  $( {
    [[ "$FRONTEND_STACK" != "none" ]] && printf '%s\n' "- ${PROJECT_FRONTEND_NAME}: frontend application technology."
    [[ "$FRONTEND_VARIANT" != "none" ]] && printf '%s\n' "- ${PROJECT_FRONTEND_VARIANT_NAME}: frontend application variant."
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- ${PROJECT_BACKEND_NAME}: backend/runtime implementation technology."
    [[ "$BACKEND_FRAMEWORK" != "none" ]] && printf '%s\n' "- ${PROJECT_BACKEND_FRAMEWORK_NAME}: backend application framework."
    [[ "$SHELL_DESKTOP" != "none" ]] && printf '%s\n' "- ${PROJECT_DESKTOP_SHELL_NAME}: desktop shell implementation technology."
    [[ "$SHELL_MOBILE" != "none" ]] && printf '%s\n' "- ${PROJECT_MOBILE_SHELL_NAME}: mobile shell implementation technology."
    [[ "$SHELL_WEB" != "none" ]] && printf '%s\n' "- ${PROJECT_WEB_SHELL_NAME}: web shell implementation technology."
    for skill in "${DATABASES_SELECTED[@]-}"; do
      [[ -z "$skill" ]] && continue
      printf '%s\n' "- $(registry_label "$skill" "${DATABASES[@]}"): database or data store."
    done

    for skill in "${SEARCH_ENGINES_SELECTED[@]-}"; do
      [[ -z "$skill" ]] && continue
      printf '%s\n' "- $(registry_label "$skill" "${SEARCH_ENGINES[@]}"): search engine."
    done

    true
  } | write_embedded_lines )

  - Kanban: project task management convention.
  - Specifications: project specification format and workflow.

  ## Generated Skill Directories

  $( {
    [[ "$FRONTEND_STACK" != "none" ]] && printf '%s\n' "- ${FRONTEND_STACK}/"
    [[ "$FRONTEND_VARIANT" != "none" ]] && printf '%s\n' "- ${FRONTEND_VARIANT}/"
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- ${BACKEND_STACK}/"
    [[ "$BACKEND_FRAMEWORK" != "none" ]] && printf '%s\n' "- ${BACKEND_FRAMEWORK}/"
    [[ "$SHELL_DESKTOP" != "none" ]] && printf '%s\n' "- ${SHELL_DESKTOP}/"
    [[ "$SHELL_MOBILE" != "none" ]] && printf '%s\n' "- ${SHELL_MOBILE}/"
    [[ "$SHELL_WEB" != "none" ]] && printf '%s\n' "- ${SHELL_WEB}/"
    for skill in "${DATABASES_SELECTED[@]-}"; do
      [[ -z "$skill" ]] && continue
      printf '%s\n' "- ${skill}/"
    done

    for skill in "${SEARCH_ENGINES_SELECTED[@]-}"; do
      [[ -z "$skill" ]] && continue
      printf '%s\n' "- ${skill}/"
    done

    true
  } | awk '!seen[$0]++' | write_embedded_lines )

  - kanban/
  - specs/
EOF
}
write_meta_skill_documents() {
  local skill
  local generated=""

  for skill in \
    "$FRONTEND_STACK" \
    "$FRONTEND_VARIANT" \
    "$BACKEND_STACK" \
    "$BACKEND_FRAMEWORK" \
    "$SHELL_DESKTOP" \
    "$SHELL_MOBILE" \
    "$SHELL_WEB" \
    "${DATABASES_SELECTED[@]-}" \
    "${SEARCH_ENGINES_SELECTED[@]-}"; do

    if [[ -z "$skill" || "$skill" == "none" ]]; then
      continue
    fi

    if [[ ":$generated:" == *":$skill:"* ]]; then
      continue
    fi

    case "$skill" in
      angular)
        write_meta_skill_angular
        ;;

      html-js-css)
        write_meta_skill_html_js_css
        ;;

      go)
        write_meta_skill_go
        ;;

      tauri)
        write_meta_skill_tauri
        ;;

      docker)
        write_meta_skill_docker
        ;;

      *)
        write_meta_skill_generic "$skill"
        ;;
    esac

    if [[ -z "$generated" ]]; then
      generated="$skill"
    else
      generated="$generated:$skill"
    fi
  done
}
write_meta_skill_kanban() {
  write_document "00-META/skills/kanban/SKILL.md" <<'EOF'
  # Kanban Skill

  This project uses the Markdown Kanban Roadmap format.

  Before modifying the kanban, read:

  - 03-PRODUCT/kanban/TASKS.md
  - 00-META/templates/kanban/TASKS-TEMPLATE.md
  - 00-META/templates/kanban/TASK-TEMPLATE.md

  ## Allowed Columns

  - BACKLOG
  - DOING
  - REVIEW
  - DONE
  - PAUSED



  ## Allowed Properties

  - id
  - tags
  - priority
  - workload
  - milestone
  - start
  - due
  - updated
  - detail
  - defaultExpanded



  ## Allowed Priority Values

  - low
  - medium
  - high



  ## Allowed Workload Values

  - Easy
  - Medium
  - Hard
  - Extreme



  ## Task Identifiers

  Tasks must use:

  - T-001
  - T-002
  - T-003

  Format:

  T-XXX


  ## Detail Files

  A task may reference:

  detail: ./tasks/T-XXX.md

  If a detail file is referenced:

  - the file must exist
  - the filename must match the task id
  - the title must match the task id


  ## Status Rules

  Task status is defined by its column.

  Never create:

  - status
  - state
  - progress


  ## Definition Of Ready

  A task is ready to move from BACKLOG to DOING only when:

  - the expected result is explicit
  - the task scope is confirmed
  - acceptance criteria are verifiable
  - known dependencies and blockers are documented
  - no open arbitration blocks the task
  - the related specification is Ready when a specification is required
  - the task detail file exists when referenced
  - the task represents one concrete deliverable

  A task that does not meet these conditions:

  - must remain in BACKLOG
  - must not move to DOING
  - must not trigger implementation work

  Missing information must remain explicit.

  AI agents must not silently complete missing task information or resolve a
  blocking arbitration.


  ## Milestone Format

  sprint-YY-MM_N

  Examples:

  - sprint-26-07_1
  - sprint-26-07_2
  - sprint-26-08_1


  ## Agent Rules

  - Do not invent unsupported properties.
  - Do not invent unsupported columns.
  - Keep ids unique.
  - Keep detail references valid.
  - Move tasks between columns to change status.
  - Do not create orphan detail files.
EOF
}
write_meta_skill_specs() {
  write_document "00-META/skills/specs/SKILL.md" <<'EOF'
  # Specifications Skill

  This skill defines how AI agents must create and maintain project specifications.

  ## Mandatory Reading

  Before creating or modifying a specification, read:

  - 00-META/context/framing.md
  - 00-META/context/open-arbitrations.md
  - 00-META/context/identity.md
  - 00-META/context/vision.md
  - 00-META/context/stack.yml
  - 00-META/decisions/
  - 00-META/templates/specs/SPEC-TEMPLATE.md
  - 03-PRODUCT/specs/README.md

  Read relevant feature and UX flow documents when they exist.

  ## Source Rules

  Specifications must use only:

  - confirmed project context
  - accepted decisions
  - explicitly confirmed user requirements
  - existing feature documents
  - existing UX flow documents

  Open arbitrations are not confirmed requirements.

  Dropped arbitrations must not be reintroduced.

  TODO placeholders are not confirmed requirements.

  ## File Naming

  Specification files must use:

  SPEC-XXX-short-title.md

  Examples:

  - SPEC-001-user-authentication.md
  - SPEC-002-data-import.md
  - SPEC-003-search-workflow.md

  Identifiers must remain unique and stable.

  ## Specification Scope

  One specification must describe one coherent functional scope.

  A specification may describe:

  - a feature
  - a workflow
  - a domain capability
  - a system behavior
  - an integration
  - a technical capability with product impact

  Do not combine unrelated scopes in one specification.

  ## Mandatory Sections

  Every specification must contain:

  - Status
  - Summary
  - Context
  - Goals
  - Requirements
  - Acceptance Criteria
  - Out Of Scope
  - Dependencies
  - Open Questions
  - Related Files

  ## Status Values

  Allowed status values:

  - Draft
  - Ready
  - Implementing
  - Implemented
  - Deprecated

  ## Requirement Rules

  Requirements must:

  - be explicit
  - be testable when possible
  - describe expected behavior
  - avoid implementation details unless technically required
  - use stable identifiers

  Requirement identifiers must use:

  REQ-001
  REQ-002
  REQ-003

  ## Acceptance Criteria Rules

  Acceptance criteria must:

  - correspond to documented requirements
  - describe observable validation conditions
  - avoid introducing new requirements
  - use checklist items

  ## Relationship With Features

  Feature documents explain:

  - what the capability is
  - why it exists
  - the value it provides

  Specifications define:

  - precise expected behavior
  - rules
  - constraints
  - acceptance criteria

  Do not duplicate full specifications in feature documents.

  ## Relationship With UX Flows

  UX flow documents describe user journeys and transitions.

  Specifications may reference UX flows but must not duplicate complete flow documentation.

  ## Relationship With Kanban

  Specifications define expected behavior.

  Kanban tasks define execution work.

  Do not use TASKS.md as a specification.

  Do not create Kanban tasks from:

  - unconfirmed requirements
  - open questions
  - open arbitrations

  ## Agent Rules

  - Do not invent requirements.
  - Do not silently resolve open questions.
  - Do not silently resolve open arbitrations.
  - Do not create empty specification files.
  - Do not duplicate an existing specification.
  - Update an existing specification when its scope already covers the requested change.
  - Keep implementation tasks outside specification files.
EOF
}
write_meta_skill_angular() {
  write_document "00-META/skills/angular/SKILL.md" <<'EOF'
  # Angular Skill

  ## Purpose

  This skill defines how AI agents should work with Angular in this project.

  It applies when:

  ```yaml
  frontend:
    stack: "angular"
  ```

  ## Role

  Angular is the frontend application framework.

  It owns:

  - screens
  - routes
  - UI state
  - components
  - frontend services
  - user interactions

  Angular must not own backend runtime logic.

  ## Mandatory Rules

  - Prefer standalone components.
  - Use feature-first organization.
  - Keep UI components focused on presentation and interaction.
  - Keep business/runtime logic outside components.
  - Keep shared utilities explicit and limited.
  - Avoid generic catch-all folders when a domain-specific name exists.
  - Keep routing readable and predictable.
  - Keep frontend state separate from backend runtime execution.

  ## Recommended Structure

  ```txt
  client/
  └── src/
      └── app/
          ├── core/
          ├── shared/
          ├── features/
          ├── layouts/
          └── routes/
  ```

  ## Forbidden

  - Do not place backend runtime logic in Angular.
  - Do not hardcode production data.
  - Do not generate fake services as final implementation.
  - Do not hide important UI behavior in unclear abstractions.
  - Do not change visual structure unless explicitly requested.

  ## Agent Instructions

  Before generating Angular code, AI agents must read:

  - 00-META/context/stack.yml
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - 00-META/skills/angular/SKILL.md
EOF
}
write_meta_skill_html_js_css() {
  write_document "00-META/skills/html-js-css/SKILL.md" <<'EOF'
  # HTML CSS JS Skill

  ## Purpose

  This skill defines how AI agents should work with a static frontend based on
  HTML, CSS and JavaScript.

  It applies when:

  ```yaml
  frontend:
    stack: "html-js-css"
  ```

  ## Role

  HTML/CSS/JS is used for simple static frontend implementations.

  It can be used for:

  - static pages
  - prototypes
  - lightweight interfaces
  - documentation-driven frontends
  - non-framework UI experiments

  ## Important Distinction

  Static JSON is not a frontend stack.

  Static JSON is a content or data mode.

  If static JSON becomes necessary later, it should be modeled separately from
  FRONTEND_STACK.

  ## Mandatory Rules

  - Keep HTML structure explicit.
  - Keep CSS readable and organized.
  - Keep JavaScript behavior separated from markup when possible.
  - Avoid unnecessary framework-like abstractions.
  - Avoid hidden state management.
  - Keep assets and data references clear.

  ## Forbidden

  - Do not simulate a framework architecture unless explicitly required.
  - Do not mix temporary prototype logic with durable implementation code.
  - Do not hardcode production data as final content.
EOF
}
write_meta_skill_go() {
  write_document "00-META/skills/go/SKILL.md" <<'EOF'
  # Go Skill

  ## Purpose

  This skill defines how AI agents should work with Go in this project.

  It applies when:

  ```yaml
  server:
    stack: "go"
  ```

  ## Role

  Go is the backend/runtime implementation language.

  It owns:

  - runtime composition
  - backend modules
  - local server execution
  - remote server execution
  - connectors
  - domain services
  - infrastructure adapters

  ## Mandatory Rules

  - Organize packages by domain or responsibility.
  - Keep modules isolated.
  - Keep runtime entry points thin.
  - Keep business logic out of transport handlers.
  - Keep local and remote execution boundaries explicit.
  - Avoid circular dependencies.
  - Prefer clear interfaces at module boundaries.
  - Keep configuration explicit.

  ## Recommended Structure

  ```txt
  server/
  ├── modules/
  ├── local/
  └── remote/
  ```

  ## Modules

  Modules should contain reusable business/runtime logic.

  Modules must not depend on whether they are executed locally or remotely.

  ## Local Runtime

  Local runtime composes modules for embedded, desktop or local-first execution.

  ## Remote Runtime

  Remote runtime exposes or runs modules as networked services or cloud processes.

  ## Forbidden

  - Do not put business logic directly in HTTP handlers.
  - Do not bind reusable modules to a single transport.
  - Do not duplicate business logic between local and remote runtimes.
  - Do not create microservices by default.
  - Do not introduce unnecessary abstraction layers.

  ## Agent Instructions

  Before generating Go code, AI agents must read:

  - 00-META/context/stack.yml
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/security-rules.md
  - 00-META/skills/go/SKILL.md
EOF
}
write_meta_skill_tauri() {
  write_document "00-META/skills/tauri/SKILL.md" <<'EOF'
  # Tauri Skill

  ## Purpose

  This skill defines how AI agents should work with Tauri in this project.

  It applies when:

  ```yaml
  shell:
    desktop:
      stack: "tauri"
  ```

  ## Role

  Tauri is a desktop shell.

  It wraps the frontend client and connects it to the runtime environment.

  Tauri must not become the business core of the application.

  ## Responsibilities

  Tauri owns:

  - desktop window lifecycle
  - native integration
  - filesystem permissions
  - command bridge
  - application packaging
  - desktop capabilities
  - controlled access to local runtime

  ## Mandatory Rules

  - Keep Tauri as a shell layer.
  - Keep business logic out of the shell.
  - Keep runtime logic in server/local when a local server exists.
  - Keep command handlers thin.
  - Keep permissions explicit.
  - Keep native integration separated from frontend code.
  - Keep frontend and backend responsibilities separated.

  ## Recommended Relationship

  ```txt
  shell/desktop/
      Tauri shell

  client/
      Frontend application

  server/local/
      Local runtime
  ```

  ## Forbidden

  - Do not place reusable business modules directly inside the Tauri shell.
  - Do not hardcode privileged filesystem access.
  - Do not bypass documented permissions.
  - Do not mix UI state and native runtime state without a clear boundary.

  ## Agent Instructions

  Before generating Tauri code, AI agents must read:

  - 00-META/context/stack.yml
  - 00-META/governance/security-rules.md
  - 00-META/skills/tauri/SKILL.md
EOF
}
write_meta_skill_docker() {
  write_document "00-META/skills/docker/SKILL.md" <<'EOF'
  # Docker Skill

  ## Purpose

  This skill defines how AI agents should work with Docker in this project.

  It applies when:

  ```yaml
  shell:
    web:
      stack: "docker"
  ```

  ## Role

  Docker is the selected implementation technology for the web shell.

  The web shell exposes the frontend client in a web environment and connects it
  to the required runtime services.

  Docker must not contain application business logic.

  ## Responsibilities

  The Docker-based web shell can own:

  - frontend web serving
  - web runtime wiring
  - environment wiring
  - service startup
  - container boundaries
  - reverse proxy integration
  - runtime connectivity
  - web packaging
  - deployment composition when required

  ## Architecture Boundaries

  The frontend application belongs in:

  ```txt
  client/
  ```

  The Docker-based web shell belongs in:

  ```txt
  shell/web/
  ```

  Backend runtime code belongs in:

  ```txt
  server/local/
  server/remote/
  ```

  Shared asset delivery belongs in:

  ```txt
  server/assets/
  ```

  The web shell must serve, expose and connect the client without duplicating
  frontend, backend or shared asset responsibilities.

  ## Mandatory Rules

  - Keep Docker configuration explicit.
  - Keep environment-specific values externalized.
  - Do not hardcode secrets.
  - Separate development and production assumptions.
  - Keep Docker concerns away from reusable business modules.
  - Document exposed ports and service dependencies.
  - Keep web serving concerns inside shell/web.
  - Keep shared asset delivery concerns inside server/assets when enabled.
  - Avoid overengineering orchestration for simple projects.

  ## Recommended Relationship

  ```txt
  client/
      Frontend application

  shell/web/
      Docker-based web shell

  server/remote/
      Remote runtime when enabled

  server/assets/
      Shared asset delivery when enabled
  ```

  ## Forbidden

  - Do not place application business logic in Docker files.
  - Do not place frontend application source code directly in shell/web.
  - Do not duplicate backend runtime logic in shell/web.
  - Do not move shared asset delivery responsibilities into shell/web.
  - Do not commit secrets in environment files.
  - Do not generate production credentials.
  - Do not assume cloud infrastructure without explicit project context.

  ## Agent Instructions

  Before generating Docker files, AI agents must read:

  - 00-META/context/stack.yml
  - 00-META/context/architecture.md
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/security-rules.md
  - 00-META/skills/docker/SKILL.md
EOF
}
write_meta_skill_generic() {
  local skill="$1"
  local label

  label="$(
    registry_label \
      "$skill" \
      "${STACKS_FRONTEND[@]}" \
      "${STACKS_BACKEND[@]}" \
      "${VARIANTS_ANGULAR[@]}" \
      "${VARIANTS_REACT[@]}" \
      "${VARIANTS_VUE[@]}" \
      "${VARIANTS_SVELTE[@]}" \
      "${VARIANTS_SOLID[@]}" \
      "${VARIANTS_PREACT[@]}" \
      "${VARIANTS_QWIK[@]}" \
      "${FRAMEWORKS_GO[@]}" \
      "${FRAMEWORKS_NODE[@]}" \
      "${FRAMEWORKS_PHP[@]}" \
      "${FRAMEWORKS_PYTHON[@]}" \
      "${FRAMEWORKS_DOTNET[@]}" \
      "${FRAMEWORKS_JAVA[@]}" \
      "${FRAMEWORKS_KOTLIN[@]}" \
      "${FRAMEWORKS_RUST[@]}" \
      "${FRAMEWORKS_RUBY[@]}" \
      "${SHELLS_DESKTOP[@]}" \
      "${SHELLS_MOBILE[@]}" \
      "${SHELLS_WEB[@]}" \
      "${DATABASES[@]}" \
      "${SEARCH_ENGINES[@]}"
  )"

  write_document "00-META/skills/$skill/SKILL.md" <<EOF
  # ${label} Skill

  ## Purpose

  This skill defines the baseline instructions for working with ${label} in this
  project.

  ## Project Context

  Read before implementation:

  - 00-META/context/stack.yml
  - 00-META/context/architecture.md
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - 00-META/governance/security-rules.md

  ## Rules

  - Respect the responsibility assigned to ${label} in stack.yml.
  - Keep frontend, backend and shell responsibilities separated.
  - Do not invent undocumented project requirements.
  - Do not hardcode production credentials or endpoints.
  - Keep configuration explicit.
  - Keep integration boundaries documented.
  - Do not introduce unnecessary abstractions.
  - Record durable consequential decisions in an ADR.
  - Record unresolved choices in open-arbitrations.md.

  ## Specialization

  This is a generic fallback skill.

  Replace or extend it with technology-specific rules only after explicit review.
EOF
}


write_meta_playbooks_readme() {
  write_document "00-META/playbooks/README.md" <<'EOF'
  # Playbooks

  This directory contains reusable workflows for humans and AI agents.

  Playbooks describe how work should be approached, sequenced and reviewed.

  They are not technology-specific rules.
  Technology-specific constraints belong in 00-META/skills.

  They are not project facts.
  Current project facts belong in 00-META/context.

  They are not historical decisions.
  Historical decisions belong in 00-META/decisions.

  ## Documents

  ### feature.md

  Workflow for designing and implementing a new feature.

  ### bugfix.md

  Workflow for investigating and fixing a defect.

  ### review.md

  Workflow for reviewing generated or modified work.

  ### release.md

  Workflow for preparing a release.

  ### migration.md

  Workflow for migrating architecture, code, data or tooling.

  ## Agent Rules

  - AI agents must select the playbook that matches the task.
  - AI agents must read context and governance before applying a playbook.
  - AI agents must read relevant skills before generating technology-specific code.
  - AI agents must not skip review steps when modifying project structure or architecture.
EOF
}
write_meta_playbook_feature() {
  write_document "00-META/playbooks/feature.md" <<'EOF'
  # Feature Playbook

  ## Purpose

  This playbook defines how to add a new feature to the project.

  It should be used when the task introduces new product behavior, a new screen,
  a new module, a new workflow or a new user-facing capability.

  ## Required Reading

  Before starting, read:

  - 00-META/context/README.md
  - 00-META/context/framing.md
  - 00-META/context/open-arbitrations.md
  - 00-META/context/identity.md
  - 00-META/context/vision.md
  - 00-META/context/stack.yml
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - 00-META/skills/specs/SKILL.md
  - 00-META/skills/kanban/SKILL.md
  - relevant 00-META/skills/*/SKILL.md files
  - the related specification
  - the related Kanban task

  ## Workflow

  1. Verify that the feature scope is confirmed.
  2. Verify that no open arbitration blocks the feature.
  3. Verify that the functional scope is covered by a Ready specification.
  4. Verify that a Kanban task references the specification.
  5. Move the active task from BACKLOG to DOING.
  6. Identify the affected product, design, client, server, shell and documentation layers.
  7. Read all applicable technology skills.
  8. Implement only the confirmed task scope.
  9. Update affected documentation when behavior, structure or usage changed.
  10. Move the completed task from DOING to REVIEW.
  11. Apply the review playbook before completion.

  ## Architecture Rules

  - Keep frontend, backend, shell and deployment responsibilities separated.
  - Do not introduce mock data as final implementation.
  - Do not hide important behavior behind unclear abstractions.
  - Do not change visual structure unless explicitly requested.
  - Prefer explicit, maintainable structure over clever shortcuts.

  ## Expected Output

  A feature implementation should include only the necessary files and changes.

  If code is requested, provide precise file locations and complete modified blocks
  or complete files according to the user preference.

  ## Commit Format

  ```bash
  git add . && git commit -m "add feature scope"
  ```
EOF
}
write_meta_playbook_bugfix() {
  write_document "00-META/playbooks/bugfix.md" <<'EOF'
  # Bugfix Playbook

  ## Purpose

  This playbook defines how to investigate and fix a defect.

  It should be used when something is broken, inconsistent, missing, incorrectly
  generated or not aligned with the expected behavior.

  ## Required Reading

  Before fixing, read:

  - 00-META/context/stack.yml
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - relevant 00-META/skills/*/SKILL.md files
  - 00-META/context/open-arbitrations.md
  - 00-META/skills/kanban/SKILL.md
  - 00-META/playbooks/review.md
  - the related specification when expected behavior is documented there
  - the related Kanban task

  ## Workflow

  1. Identify the exact symptom.
  2. Locate the smallest responsible area.
  3. Avoid broad rewrites.
  4. Fix the cause, not only the visible symptom.
  5. Preserve existing structure unless the bug is caused by the structure itself.
  6. Do not introduce unrelated improvements.
  7. Re-check affected generated files or documentation.
  8. Provide a focused commit message.
  9. Confirm the expected behavior from existing documentation or specification.
  10. Verify that no open arbitration blocks the correction.
  11. Verify that the confirmed correction is tracked in the Kanban.
  12. Move the active task from BACKLOG to DOING.
  13. Locate the smallest responsible area.
  14. Fix the cause without broad rewrites or unrelated changes.
  15. Re-check affected behavior, generated files and documentation.
  16. Move the completed task from DOING to REVIEW.
  17. Apply the review playbook.

  ## Rules

  - Do not guess missing file structure.
  - Ask for the exact missing file only when required.
  - Do not invent hidden dependencies.
  - Do not replace a working pattern without explicit reason.
  - Keep the fix minimal and understandable.

  ## Expected Output

  A bugfix should clearly identify:

  - the faulty area
  - the correction
  - the affected files
  - any remaining limitation if relevant

  ## Commit Format

  ```bash
  git add . && git commit -m "fix identified issue"
  ```
EOF
}
write_meta_playbook_review() {
  write_document "00-META/playbooks/review.md" <<'EOF'
  # Review Playbook

  ## Purpose

  This playbook defines how humans and AI agents must review generated or
  modified project work.

  A review validates a defined scope against the project source of truth.

  A review must not become an unrelated redesign, migration or refactoring task.

  ## Required Reading

  Before reviewing, read:

  - 00-META/context/README.md
  - 00-META/context/open-arbitrations.md
  - 00-META/context/risks.md
  - 00-META/context/identity.md
  - 00-META/context/vision.md
  - 00-META/context/stack.yml
  - 00-META/context/architecture.md
  - 00-META/context/framing.md
  - 00-META/governance/README.md
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - 00-META/governance/security-rules.md
  - 00-META/decisions/
  - 00-META/skills/README.md

  Read the relevant technology, Kanban and specification skills according to the
  reviewed scope.

  ## Review Scope

  When the task identifies files, directories or changes:

  - review the identified scope
  - review directly affected project documents
  - do not expand the review without a concrete dependency

  When no scope is identified:

  - perform a project-wide consistency review
  - state explicitly that the review is project-wide

  ## Workflow

  1. Define the exact review scope.
  2. Read the applicable context, governance, decisions and skills.
  3. Identify the expected structure or behavior.
  4. Compare the reviewed work with the applicable project rules.
  5. Record factual findings with precise locations.
  6. Classify each finding by severity.
  7. Separate deterministic corrections from required arbitrations.
  8. Apply corrections only when explicitly requested.
  9. Re-check modified files after correction.
  10. Provide one focused commit command when changes were made.

  ## Review Checklist

  Verify:

  - context consistency
  - stack and engineering alignment
  - architecture boundary compliance
  - governance compliance
  - relevant skill compliance
  - accepted decision compliance
  - open arbitration handling
  - absence of reintroduced dropped arbitrations
  - absence of invented project facts
  - absence of unsupported requirements
  - specification consistency
  - Kanban consistency
  - file reference validity
  - naming consistency
  - documentation alignment
  - duplicated information
  - obsolete references
  - changes outside the requested scope
  - risk register consistency
  - risk mitigation alignment
  - consistency between risks, arbitrations and Kanban tasks

  ## Finding Severity

  Use only:

  ### BLOCKING

  The issue prevents correct execution, generation or project use.

  Examples:

  - invalid generated syntax
  - missing mandatory file
  - reference to a required file that cannot exist
  - project structure incompatible with an accepted convention

  ### MAJOR

  The issue creates a contradiction, invalid structure or significant project
  risk without necessarily preventing immediate execution.

  Examples:

  - contradiction between context and implementation
  - violation of an accepted architecture decision
  - open arbitration treated as a confirmed fact
  - dropped arbitration reintroduced
  - unsupported Kanban or specification structure

  ### MINOR

  The issue creates limited inconsistency, ambiguity or maintainability cost.

  Examples:

  - obsolete wording
  - incomplete directory documentation
  - inconsistent terminology without functional impact

  Do not assign severity without describing the concrete impact.

  ## Finding Format

  Each finding must contain:

  Severity:
  Location:
  Finding:
  Evidence:
  Required Correction:

  Location must identify the exact file and, when possible, the function, section
  or symbol.

  ## Deterministic Corrections

  A correction is deterministic when it is directly required by:

  - a confirmed context document
  - an accepted decision
  - a mandatory governance rule
  - an applicable skill
  - an established project convention

  Deterministic corrections may be applied only when the user explicitly requests
  modifications.

  ## Required Arbitrations

  User arbitration is required when:

  - multiple valid solutions exist
  - project context is incomplete
  - an open arbitration covers the subject
  - the proposed correction changes project scope
  - the proposed correction changes architecture
  - the proposed correction invalidates an accepted decision

  Do not silently resolve these cases.

  Add unresolved decisions to open-arbitrations.md only when explicitly requested.

  ## Modification Rules

  When correcting reviewed work:

  - modify only confirmed defects
  - preserve validated decisions
  - preserve unrelated working code
  - avoid broad rewrites
  - avoid unsolicited improvements
  - list every modified file
  - re-check each modified area
  - leave unresolved arbitrations unchanged

  ## Specifications

  Verify that specifications:

  - follow 00-META/skills/specs/SKILL.md
  - use confirmed requirements
  - contain the required sections
  - use supported status values
  - use stable requirement identifiers
  - do not silently resolve open questions
  - do not duplicate existing specification scope

  ## Kanban

  Verify that the Kanban:

  - follows 00-META/skills/kanban/SKILL.md
  - uses only supported columns
  - uses only supported properties
  - uses unique task identifiers
  - references existing detail files
  - does not create tasks from open arbitrations
  - does not replace project specifications

  ## Risks

  Verify that risks:

  - use unique and stable RISK-XXX identifiers
  - use supported area, impact and likelihood values
  - are grounded in confirmed project context
  - are not duplicated as open arbitrations
  - are not used directly as implementation tasks
  - reference Kanban work when mitigation requires implementation
  - reference an open arbitration when mitigation requires an unresolved choice
  - remain preserved after being moved to Closed

  ## Expected Output

  A review must provide:

  - reviewed scope
  - validated elements
  - factual findings grouped by severity
  - required arbitrations
  - deterministic corrections
  - affected files
  - recommended commit command when changes were made

  Omit empty finding groups.

  Never claim that unreviewed areas are valid.

  ## Commit Format

  git add . && git commit -m "review project consistency"
EOF
}
write_meta_playbook_release() {
  write_document "00-META/playbooks/release.md" <<'EOF'
  # Release Playbook

  ## Purpose

  This playbook defines how to prepare a release.

  It should be used when the project reaches a stable checkpoint, delivery point,
  tagged version or deployable state.

  ## Required Reading

  Before preparing a release, read:

  - 00-META/context/identity.md
  - 00-META/context/stack.yml
  - 00-META/governance/git-rules.md
  - 00-META/governance/security-rules.md
  - relevant 00-META/skills/*/SKILL.md files

  ## Workflow

  1. Verify the project identity and stack.
  2. Verify that generated structure matches selected targets.
  3. Verify that documentation is current.
  4. Check for temporary code, TODO misuse and fake data.
  5. Check security-sensitive files and generated docs.
  6. Prepare release notes if applicable.
  7. Propose a release commit or tag message.

  ## Rules

  - Do not release with known temporary implementation unless explicitly accepted.
  - Do not include secrets or credentials.
  - Do not treat prototypes as production code.
  - Do not include generated noise that has no project value.
  - Keep release notes factual.

  ## Expected Output

  A release preparation should identify:

  - release scope
  - included changes
  - excluded work
  - known risks
  - validation status

  ## Commit Format

  ```bash
  git add . && git commit -m "prepare release"
  ```
EOF
}
write_meta_playbook_migration() {
  write_document "00-META/playbooks/migration.md" <<'EOF'
  # Migration Playbook

  ## Purpose

  This playbook defines how to perform a migration.

  It should be used when changing architecture, folder structure, framework,
  runtime, language, storage strategy, tooling or generated documentation model.

  ## Required Reading

  Before migrating, read:

  - 00-META/context/stack.yml
  - 00-META/governance/architecture-rules.md
  - 00-META/governance/naming-rules.md
  - 00-META/governance/security-rules.md
  - relevant 00-META/skills/*/SKILL.md files
  - 00-META/decisions when available
  
  When legacy migration is enabled, also read:

  - 09-LEGACY/migration/README.md
  - 09-LEGACY/migration/project-overview.md
  - 09-LEGACY/migration/source-tree.md
  - 09-LEGACY/migration/technology-inventory.md
  - 09-LEGACY/migration/architecture-analysis.md
  - 09-LEGACY/migration/business-rules.md
  - 09-LEGACY/migration/external-dependencies.md
  - 09-LEGACY/migration/technical-debt.md
  - 09-LEGACY/migration/migration-risks.md
  - 09-LEGACY/migration/migration-plan.md
  - 09-LEGACY/migration/migration-tasks.md

  ## Workflow

  1. Identify the confirmed migration scope.
  2. Analyze the source state from concrete legacy code and configuration evidence.
  3. Complete the affected legacy migration analysis documents.
  4. Identify unresolved decisions and migration risks.
  5. Confirm the target state from 00-META context and accepted decisions.
  6. Define and validate migration-plan.md.
  7. Derive reviewable migration work in migration-tasks.md.
  8. Create matching project Kanban tasks for confirmed implementation work.
  9. Move the active Kanban task to DOING before implementation.
  10. Implement target code only in 04-ENGINEERING/.
  11. Validate preserved behavior, data, integrations and rollback conditions.
  12. Move completed work to REVIEW and apply the review playbook.

  ## Rules

  - Do not migrate by rewriting blindly.
  - Preserve validated decisions unless explicitly changed.
  - Do not keep obsolete files without reason.
  - Do not duplicate old and new systems unless a transition period is intentional.
  - Keep migration steps reviewable.

  ## Expected Output

  A migration should clearly state:

  - source state
  - target state
  - files changed
  - files removed
  - compatibility impact
  - follow-up cleanup if needed

  ## Commit Format
  
  ```bash
  git add . && git commit -m "migrate source to target"
  ```
EOF
}


write_meta_decisions_readme() {
  write_document "00-META/decisions/README.md" <<'EOF'
  # Decisions

  This directory stores durable project decisions.

  A decision records an important architectural, technical, product or workflow
  choice that should remain understandable over time.

  ## ADR Convention

  Use one file per decision.

  Naming format:

  ```txt
  ADR-001-short-title.md
  ADR-002-short-title.md
  ADR-003-short-title.md
  ```

  ## Recommended Status Values

  - Proposed
  - Accepted
  - Deprecated
  - Superseded

  ## Template

  Use:

  ```txt
  ../templates/decisions/ADR-TEMPLATE.md
  ```

  ## Agent Rules

  - AI agents must create or update an ADR when changing a major architectural, product or workflow decision.
  - AI agents must not silently invalidate an accepted decision.
  - AI agents must reference affected context, governance, skill or engineering files when relevant.
  - AI agents must keep ADRs concise and factual.
  - AI agents must clearly separate context, considered options, final decision and consequences.
EOF
}
write_meta_templates_readme() {
  write_document "00-META/templates/README.md" <<'EOF'
  # Templates

  This directory contains reusable document templates.

  Templates are not project decisions.
  Templates are not current project facts.
  Templates are not governance rules.

  They are used to create consistent project documents.

  ## Directories

  ### decisions

  Templates used to create Architecture Decision Records and other durable
  decision documents.

  ### kanban

  Templates used to create Markdown Kanban Roadmap boards and task detail files.

  ### specs

  Templates used to create consistent project specifications.

  Available template:

  - SPEC-TEMPLATE.md

  ## Rules

  - Do not treat templates as confirmed project facts.
  - Do not store active project documents in this directory.
  - Generated decisions belong in 00-META/decisions.
  - Active Kanban files belong in 03-PRODUCT/kanban.
  - Active specifications belong in 03-PRODUCT/specs.
EOF
}
write_meta_template_decision_adr() {
  write_document "00-META/templates/decisions/ADR-TEMPLATE.md" <<'EOF'
  # ADR-XXX - Decision Title

  ## Status

  Proposed

  ## Date

  YYYY-MM-DD

  ## Context

  Describe the situation that requires a decision.

  Keep this section factual.

  Do not invent missing project facts.

  ## Decision

  Describe the decision that was made.

  If the decision is not confirmed yet, keep the status as Proposed.

  ## Options Considered

  ### Option A

  Description.

  Pros:

  - ...

  Cons:

  - ...

  ### Option B

  Description.

  Pros:

  - ...

  Cons:

  - ...

  ## Consequences

  ### Positive Consequences

  - ...

  ### Negative Consequences

  - ...

  ### Follow-Up Work

  - ...

  ## Related Files

  - 00-META/context/stack.yml
  - 00-META/context/architecture.md
  - 00-META/governance/architecture-rules.md

  ## Notes

  Keep this ADR concise.

  Do not use this file as a full specification.
EOF
}
write_meta_template_kanban_tasks() {
  write_document "00-META/templates/kanban/TASKS-TEMPLATE.md" <<'EOF'
  # Tasks - ProjectName

  ## BACKLOG

  ### Task Title

  - id: T-001
  - tags: [backend, api]
  - priority: medium
  - workload: Medium
  - milestone: sprint-26-07_1
  - start: YYYY-MM-DD
  - due: YYYY-MM-DD
  - updated: YYYY-MM-DD
  - detail: ./tasks/T-001.md
  - defaultExpanded: false

  ## DOING

  ## REVIEW

  ## DONE

  ## PAUSED

EOF
}
write_meta_template_kanban_task() {
  write_document "00-META/templates/kanban/TASK-TEMPLATE.md" <<'EOF'
  # T-XXX

  - steps:
    - [ ] First step
    - [ ] Second step
    - [ ] Third step

  ```md
  Describe the task context, constraints and expected result.

  Acceptance criteria:

  - First acceptance criterion
  - Second acceptance criterion
  ```
EOF
}
write_meta_template_spec() {
  write_document "00-META/templates/specs/SPEC-TEMPLATE.md" <<'EOF'
  # SPEC-XXX - Specification Title

  ## Status

  Draft

  ## Summary

  Describe the functional scope of this specification.

  ## Context

  Describe the confirmed context that requires this specification.

  ## Goals

  - Goal 1
  - Goal 2

  ## Requirements

  ### REQ-001 - Requirement Title

  Describe the expected behavior.

  ### REQ-002 - Requirement Title

  Describe the expected behavior.

  ## Acceptance Criteria

  - [ ] REQ-001 can be validated through an observable result.
  - [ ] REQ-002 can be validated through an observable result.

  ## Out Of Scope

  - Explicitly excluded behavior.

  ## Dependencies

  - None.

  ## Open Questions

  - None.

  ## Related Files

  - 00-META/context/framing.md
  - 00-META/context/open-arbitrations.md
EOF
}
write_meta_templates_specs_readme() {
  write_document "00-META/templates/specs/README.md" <<'EOF'
  # Specification Templates

  This directory contains reusable specification templates.

  ## Available Template

  - SPEC-TEMPLATE.md

  ## Rules

  - Templates are not project specifications.
  - Templates are not confirmed project facts.
  - Active specifications belong in 03-PRODUCT/specs/.
  - Specification files must follow 00-META/skills/specs/SKILL.md.
EOF
}



###############################################################################
# 01-FOUNDATION
###############################################################################

create_foundation_tree() {
  local base_dir="01-FOUNDATION"

  create_tree \
    "$base_dir" \
    "$base_dir/inspirations" \
    "$base_dir/benchmarks" \
    "$base_dir/assets-raw" \
    "$base_dir/research"
}
write_foundation_documents() {
  write_foundation_readme
  write_foundation_assets_raw_readme
  write_foundation_benchmarks_readme
  write_foundation_inspirations_readme
  write_foundation_research_readme
}

write_foundation_readme() {
  write_document "01-FOUNDATION/README.md" <<'EOF'
  # Foundation

  This section contains all research and reference material used
  to support product and engineering decisions.

  ## Directories

  ### inspirations

  References that inspire the project.

  ### benchmarks

  Competitor and market analysis.

  ### assets-raw

  Raw assets imported into the project.

  ### research
  
  Research notes and collected knowledge.
EOF
}
write_foundation_assets_raw_readme() {
  write_document "01-FOUNDATION/assets-raw/README.md" <<'EOF'
  # Raw Assets

  Original assets imported into the project.

  Do not modify source files directly.
EOF
}
write_foundation_benchmarks_readme() {
  write_document "01-FOUNDATION/benchmarks/README.md" <<'EOF'
  # Benchmarks

  Competitive analysis and product comparisons.
EOF
}
write_foundation_inspirations_readme() {
  write_document "01-FOUNDATION/inspirations/README.md" <<'EOF'
  # Inspirations

  Visual, functional or conceptual inspirations for the project.
EOF
}
write_foundation_research_readme() {
  write_document "01-FOUNDATION/research/README.md" <<'EOF'
  # Research

  Research notes, studies and collected information.
EOF
}



###############################################################################
# 02-DESIGN
###############################################################################

create_design_tree() {
  local base_dir="02-DESIGN"
  
  create_tree \
    "$base_dir" \
    "$base_dir/brand" \
    "$base_dir/brand/sources" \
    "$base_dir/brand/previews" \
    "$base_dir/brand/icons" \
    "$base_dir/brand/marketing" \
    "$base_dir/brand/social" \
    "$base_dir/brand/social/discord" \
    "$base_dir/brand/social/facebook" \
    "$base_dir/brand/social/github" \
    "$base_dir/brand/social/instagram" \
    "$base_dir/brand/social/linkedin" \
    "$base_dir/brand/social/pinterest" \
    "$base_dir/brand/social/reddit" \
    "$base_dir/brand/social/spotify" \
    "$base_dir/brand/social/threads" \
    "$base_dir/brand/social/tiktok" \
    "$base_dir/brand/social/twitch" \
    "$base_dir/brand/social/wechat" \
    "$base_dir/brand/social/whatsapp" \
    "$base_dir/brand/social/x" \
    "$base_dir/brand/social/youtube" \
    "$base_dir/system" \
    "$base_dir/tokens" \
    "$base_dir/typography" \
    "$base_dir/ui" \
    "$base_dir/ui/screens" \
    "$base_dir/ui/components" \
    "$base_dir/ui/flows"
}
write_design_documents() {
  write_design_readme
  write_design_brand_readme
  write_design_brand_sources_readme
  write_design_brand_previews_readme
  write_design_brand_icons_readme
  write_design_brand_marketing_readme
  write_design_brand_social_readme
  write_design_brand_social_discord_readme
  write_design_brand_social_facebook_readme
  write_design_brand_social_github_readme
  write_design_brand_social_instagram_readme
  write_design_brand_social_linkedin_readme
  write_design_brand_social_pinterest_readme
  write_design_brand_social_reddit_readme
  write_design_brand_social_spotify_readme
  write_design_brand_social_threads_readme
  write_design_brand_social_tiktok_readme
  write_design_brand_social_twitch_readme
  write_design_brand_social_wechat_readme
  write_design_brand_social_whatsapp_readme
  write_design_brand_social_x_readme
  write_design_brand_social_youtube_readme
  write_design_system_readme
  write_design_tokens_readme
  write_design_typography_readme
  write_design_ui_readme
  write_design_ui_screens_readme
  write_design_ui_components_readme
  write_design_ui_flows_readme
}


write_design_readme() {
  write_document "02-DESIGN/README.md" <<'EOF'
  # Design

  This section contains all design-related material for the project.

  It groups visual identity, design-system references, design tokens, typography rules,
  user-interface references, screens, components and user flows.

  ## Directories

  ### brand

  Brand identity, communication assets and platform-specific visual material.

  ### system

  Design-system references, UX principles and reusable design rules.

  ### tokens

  Shared design variables such as colors, spacing, radius, shadows and elevation.

  ### typography

  Font choices, text hierarchy and typography rules.

  ### ui

  User-interface references, screens, reusable components and user flows.
EOF
}
write_design_brand_readme() {
  write_document "02-DESIGN/brand/README.md" <<'EOF'
  # Brand

  This directory contains the project brand identity material.

  Use it for visual identity sources, previews, icons, marketing assets and
  platform-specific social media assets.

  ## Directories

  ### sources

  Editable source files for brand assets.

  ### previews

  Rendered previews and exported visual references.

  ### icons

  Application icons, favicons and platform icons.

  ### marketing

  Marketing visuals and communication material.

  ### social

  Platform-specific social visual assets.
EOF
}
write_design_brand_sources_readme() {
  write_document "02-DESIGN/brand/sources/README.md" <<'EOF'
  # Brand Sources

  This directory contains editable source files for brand assets.

  Examples:

  - Vector source files
  - Logo source files
  - Icon source files
  - Brand templates
  - Editable design files

  Source files should be preserved as original working material.
EOF
}
write_design_brand_previews_readme() {
  write_document "02-DESIGN/brand/previews/README.md" <<'EOF'
  # Brand Previews

  This directory contains rendered previews of brand assets.

  Examples:

  - Logo previews
  - Brand mockups
  - Exported visual checks
  - Rendered identity samples

  Previews are used for review and communication, not as source files.
EOF
}
write_design_brand_icons_readme() {
  write_document "02-DESIGN/brand/icons/README.md" <<'EOF'
  # Brand Icons

  This directory contains icon assets related to the project identity.

  Examples:

  - App icons
  - Favicons
  - Platform icons
  - Launcher icons
  - Small-format brand marks

  Keep icon exports organized by size, platform or usage when needed.
EOF
}
write_design_brand_marketing_readme() {
  write_document "02-DESIGN/brand/marketing/README.md" <<'EOF'
  # Brand Marketing

  This directory contains brand and marketing communication assets.

  Examples:

  - Campaign visuals
  - Banners
  - Presentation graphics
  - Landing-page visuals
  - Product communication assets

  Marketing assets should remain separated from raw brand sources.
EOF
}
write_design_brand_social_readme() {
  write_document "02-DESIGN/brand/social/README.md" <<'EOF'
  # Brand Social

  This directory contains platform-specific social brand assets.

  Each subdirectory is dedicated to one platform.

  Use this area for platform-ready visuals such as banners, profile images,
  post templates, thumbnails and social previews.
EOF
}
write_design_brand_social_discord_readme() {
  write_document "02-DESIGN/brand/social/discord/README.md" <<'EOF'
  # Discord

  Discord-specific brand assets.

  Examples:

  - Server icons
  - Community banners
  - Announcement visuals
  - Preview images
EOF
}
write_design_brand_social_facebook_readme() {
  write_document "02-DESIGN/brand/social/facebook/README.md" <<'EOF'
  # Facebook

  Facebook-specific brand assets.

  Examples:

  - Page banners
  - Profile visuals
  - Post templates
  - Campaign images
EOF
}
write_design_brand_social_github_readme() {
  write_document "02-DESIGN/brand/social/github/README.md" <<'EOF'
  # GitHub

  GitHub-specific brand assets.

  Examples:

  - Repository social preview images
  - Organization visuals
  - README banners
  - Open-source project graphics
EOF
}
write_design_brand_social_instagram_readme() {
  write_document "02-DESIGN/brand/social/instagram/README.md" <<'EOF'
  # Instagram

  Instagram-specific brand assets.

  Examples:

  - Square posts
  - Stories
  - Reels covers
  - Highlight covers
  - Profile visuals
EOF
}
write_design_brand_social_linkedin_readme() {
  write_document "02-DESIGN/brand/social/linkedin/README.md" <<'EOF'
  # LinkedIn

  LinkedIn-specific brand assets.

  Examples:

  - Company banners
  - Profile banners
  - Article visuals
  - Post templates
  - Product announcement visuals
EOF
}
write_design_brand_social_pinterest_readme() {
  write_document "02-DESIGN/brand/social/pinterest/README.md" <<'EOF'
  # Pinterest

  Pinterest-specific brand assets.

  Examples:

  - Pins
  - Board covers
  - Visual references
  - Vertical promotional graphics
EOF
}
write_design_brand_social_reddit_readme() {
  write_document "02-DESIGN/brand/social/reddit/README.md" <<'EOF'
  # Reddit

  Reddit-specific brand assets.

  Examples:

  - Community banners
  - Subreddit icons
  - Post visuals
  - Preview images
EOF
}
write_design_brand_social_spotify_readme() {
  write_document "02-DESIGN/brand/social/spotify/README.md" <<'EOF'
  # Spotify

  Spotify-specific brand assets.

  Examples:

  - Playlist covers
  - Podcast covers
  - Artist or show visuals
  - Audio-related promotional graphics
EOF
}
write_design_brand_social_threads_readme() {
  write_document "02-DESIGN/brand/social/threads/README.md" <<'EOF'
  # Threads

  Threads-specific brand assets.

  Examples:

  - Profile visuals
  - Post templates
  - Social preview images
EOF
}
write_design_brand_social_tiktok_readme() {
  write_document "02-DESIGN/brand/social/tiktok/README.md" <<'EOF'
  # TikTok

  TikTok-specific brand assets.

  Examples:

  - Profile visuals
  - Video covers
  - Vertical templates
  - Short-form campaign graphics
EOF
}
write_design_brand_social_twitch_readme() {
  write_document "02-DESIGN/brand/social/twitch/README.md" <<'EOF'
  # Twitch

  Twitch-specific brand assets.

  Examples:

  - Channel banners
  - Profile visuals
  - Stream overlays
  - Panels
  - Offline screens
EOF
}
write_design_brand_social_wechat_readme() {
  write_document "02-DESIGN/brand/social/wechat/README.md" <<'EOF'
  # WeChat

  WeChat-specific brand assets.

  Examples:

  - Profile visuals
  - Article covers
  - Campaign images
  - Sharing previews
EOF
}
write_design_brand_social_whatsapp_readme() {
  write_document "02-DESIGN/brand/social/whatsapp/README.md" <<'EOF'
  # WhatsApp

  WhatsApp-specific brand assets.

  Examples:

  - Channel visuals
  - Share previews
  - Communication images
  - Campaign graphics
EOF
}
write_design_brand_social_x_readme() {
  write_document "02-DESIGN/brand/social/x/README.md" <<'EOF'
  # X

  X-specific brand assets.

  Examples:

  - Profile banners
  - Post visuals
  - Campaign graphics
  - Link preview images
EOF
}
write_design_brand_social_youtube_readme() {
  write_document "02-DESIGN/brand/social/youtube/README.md" <<'EOF'
  # YouTube

  YouTube-specific brand assets.

  Examples:

  - Channel banners
  - Video thumbnails
  - Shorts covers
  - Playlist covers
  - End-screen visuals
EOF
}
write_design_system_readme() {
  write_document "02-DESIGN/system/README.md" <<'EOF'
  # Design System

  This directory contains design-system references and reusable design rules.

  Examples:

  - UX principles
  - Interface patterns
  - Component behavior rules
  - Accessibility rules
  - Layout rules
  - Interaction guidelines

  This directory documents design decisions before they become implementation details.
EOF
}
write_design_tokens_readme() {
  write_document "02-DESIGN/tokens/README.md" <<'EOF'
  # Design Tokens

  This directory contains shared design variables.

  Examples:

  - Colors
  - Spacing
  - Radius
  - Shadows
  - Elevation
  - Breakpoints
  - Motion values
  - Z-index scales

  Tokens should help keep design and implementation consistent.
EOF
}
write_design_typography_readme() {
  write_document "02-DESIGN/typography/README.md" <<'EOF'
  # Typography

  This directory contains typography references and text presentation rules.

  Examples:

  - Font families
  - Font weights
  - Font sizes
  - Line heights
  - Heading hierarchy
  - Body text rules
  - UI text rules

  Typography rules should remain consistent across product, marketing and documentation.
EOF
}
write_design_ui_readme() {
  write_document "02-DESIGN/ui/README.md" <<'EOF'
  # User Interface

  This directory contains user-interface references.

  It groups screens, reusable components and user flows.

  ## Directories

  ### screens

  Complete screen or page references.

  ### components

  Reusable interface building blocks.

  ### flows

  User journeys and screen-to-screen flows.
EOF
}
write_design_ui_screens_readme() {
  write_document "02-DESIGN/ui/screens/README.md" <<'EOF'
  # Screens

  This directory contains complete screen or page references.

  Examples:

  - Application screens
  - Page layouts
  - Desktop views
  - Mobile views
  - Modal screens
  - Empty states
  - Error states

  Each screen should make the intended user experience explicit.
EOF
}
write_design_ui_components_readme() {
  write_document "02-DESIGN/ui/components/README.md" <<'EOF'
  # Components

  This directory contains reusable user-interface component references.

  Examples:

  - Buttons
  - Forms
  - Cards
  - Tables
  - Modals
  - Navigation elements
  - Toolbars
  - Panels

  Components documented here should describe intended usage before implementation.
EOF
}
write_design_ui_flows_readme() {
  write_document "02-DESIGN/ui/flows/README.md" <<'EOF'
  # User Flows

  This directory contains user journeys and screen-to-screen flows.

  Examples:

  - Onboarding flows
  - Navigation flows
  - Creation flows
  - Configuration flows
  - Error recovery flows
  - Conversion flows

  Flows should explain how users move through the product to complete tasks.
EOF
}



###############################################################################
# 03-PRODUCT
###############################################################################

create_product_tree() {
  local base_dir="03-PRODUCT"

  create_tree \
    "$base_dir" \
    "$base_dir/features" \
    "$base_dir/kanban" \
    "$base_dir/kanban/tasks" \
    "$base_dir/ux-flows" \
    "$base_dir/roadmap" \
    "$base_dir/specs"
}
write_product_documents() {
  write_product_readme
  write_product_features_readme
  write_product_kanban_readme
  write_product_kanban_tasks_readme
  write_product_kanban_tasks_board
  write_product_ux_flows_readme
  write_product_roadmap_readme
  write_product_specs_readme
}


write_product_readme() {
  write_document "03-PRODUCT/README.md" <<'EOF'
  # Product

  This section contains product definition material for the project.

  It groups specifications, feature descriptions, user experience flows, roadmap
  planning documents and the project kanban.

  ## Directories

  ### specs

  Operational specifications and product requirements.

  ### features

  Feature-level descriptions, scope notes and acceptance signals.

  ### kanban

  Operational task tracking compatible with the Markdown Kanban Roadmap extension.

  ### ux-flows

  User experience flows and task-oriented journeys.

  ### roadmap

  Milestones, priorities, delivery sequencing and planning notes.
EOF
}
write_product_features_readme() {
  write_document "03-PRODUCT/features/README.md" <<'EOF'
  # Features

  This directory contains feature-level product documentation.

  Use it to describe what each feature does, why it exists and how it should behave.

  Examples:

  - Feature briefs
  - Scope notes
  - User value
  - Expected behavior
  - Edge cases
  - Acceptance signals
  - Out-of-scope notes

  Each feature document should make the intended outcome explicit.
EOF
}
write_product_kanban_readme() {
  write_document "03-PRODUCT/kanban/README.md" <<'EOF'
  # Kanban

  This directory contains the project kanban.

  The kanban must remain compatible with the Markdown Kanban Roadmap extension.

  Main board:

  - TASKS.md

  Task details:

  - tasks/T-XXX.md

  Rules:

  - TASKS.md is the source of truth.
  - Task status is determined by the column.
  - Do not add unsupported properties.
  - Detailed task information belongs in tasks/T-XXX.md.
  - Follow ../../00-META/skills/kanban/SKILL.md
EOF
}
write_product_kanban_tasks_readme() {
  write_document "03-PRODUCT/kanban/tasks/README.md" <<'EOF'
  # Task Details

  This directory contains detailed task files.

  Naming format:

  T-001.md
  T-002.md
  T-003.md

  Rules:

  - One file per task.
  - The filename must match the task id.
  - Files are referenced from TASKS.md using `detail: ./tasks/T-XXX.md`.
  - Do not create orphan task files.
  - Do not reference missing files.

  Template:

  See:

  - ../../../00-META/templates/kanban/TASK-TEMPLATE.md
EOF
}
write_product_kanban_tasks_board() {
  write_document "03-PRODUCT/kanban/TASKS.md" <<EOF
  # Tasks - ${PROJECT_NAME}

  ## BACKLOG

  ## DOING

  ## REVIEW

  ## DONE

  ## PAUSED
EOF
}
write_product_ux_flows_readme() {
  write_document "03-PRODUCT/ux-flows/README.md" <<'EOF'
  # UX Flows

  This directory contains user experience flows.

  Use it to document how users move through the product to complete tasks.

  Examples:

  - Onboarding flows
  - Creation flows
  - Configuration flows
  - Search and discovery flows
  - Error recovery flows
  - Upgrade or conversion flows
  - Multi-step workflows

  UX flows should describe the user journey before implementation details.
EOF
}
write_product_roadmap_readme() {
  write_document "03-PRODUCT/roadmap/README.md" <<'EOF'
  # Roadmap

  This directory contains roadmap and planning material.

  Use it to organize milestones, sequencing, priorities and delivery intent.

  Examples:

  - Product roadmap
  - Milestone plans
  - Release candidates
  - Sprint or iteration plans
  - Priority matrices
  - Delivery assumptions
  - Risk references and dependencies

  Roadmap documents should explain what is planned, why it matters and what depends on it.
EOF
}
write_product_specs_readme() {
  write_document "03-PRODUCT/specs/README.md" <<'EOF'
  # Specifications

  This directory contains active project specifications.

  Specifications define precise, reviewable and actionable expected behavior.

  ## File Naming

  Use:

  SPEC-XXX-short-title.md

  Examples:

  - SPEC-001-user-authentication.md
  - SPEC-002-data-import.md
  - SPEC-003-search-workflow.md

  ## Scope

  One specification must describe one coherent functional scope.

  Specifications may cover:

  - features
  - workflows
  - domain capabilities
  - system behavior
  - integrations
  - technical capabilities with product impact

  ## Relationship With Other Product Documents

  Feature documents explain what a capability is and why it exists.

  UX flow documents describe how users move through a workflow.

  Specifications define precise behavior, rules, constraints and acceptance criteria.

  Kanban tasks define the work required to implement confirmed specifications.

  ## Rules

  - Use only confirmed requirements.
  - Do not treat TODO placeholders as requirements.
  - Do not silently resolve open arbitrations.
  - Do not duplicate existing specifications.
  - Keep implementation task tracking in 03-PRODUCT/kanban/.
  - Follow 00-META/skills/specs/SKILL.md.

  ## Template

  Use:

  - ../../00-META/templates/specs/SPEC-TEMPLATE.md
EOF
}



###############################################################################
# 04-ENGINEERING
###############################################################################

create_engineering_tree() {
  local base_dir="04-ENGINEERING"

  create_tree "$base_dir"

  if [[ "$PROJECT_HAS_FRONTEND" == "true" ]]; then
    create_tree "$base_dir/client"
  fi

  if [[ "$PROJECT_HAS_SERVER" == "true" ]]; then
    create_tree "$base_dir/server"
  fi

  if [[ "$BACKEND_STACK" != "none" ]]; then
    create_tree "$base_dir/server/modules"
  fi

  if [[ "$ENABLED_SERVER_LOCAL" == "true" ]]; then
    create_tree "$base_dir/server/local"
  fi

  if [[ "$ENABLED_SERVER_REMOTE" == "true" ]]; then
    create_tree "$base_dir/server/remote"
  fi

  if [[ "$ENABLED_SERVER_ASSETS" == "true" ]]; then
    create_tree "$base_dir/server/assets"
  fi

  if [[ "$PROJECT_HAS_DESKTOP" == "true" || "$PROJECT_HAS_MOBILE" == "true" || "$PROJECT_HAS_WEB" == "true" ]]; then
    create_tree "$base_dir/shell"
  fi

  if [[ "$PROJECT_HAS_DESKTOP" == "true" ]]; then
    create_tree "$base_dir/shell/desktop"
  fi

  if [[ "$PROJECT_HAS_MOBILE" == "true" ]]; then
    create_tree "$base_dir/shell/mobile"
  fi

  if [[ "$PROJECT_HAS_WEB" == "true" ]]; then
    create_tree "$base_dir/shell/web"
  fi
}
write_engineering_documents() {
  local base_dir="04-ENGINEERING"

  write_engineering_readme "$base_dir"

  if [[ -d "$base_dir/client" ]]; then
    write_engineering_client_readme "$base_dir/client"
  fi

  if [[ -d "$base_dir/server" ]]; then
    write_engineering_server_readme "$base_dir/server"
  fi

  if [[ -d "$base_dir/server/modules" ]]; then
    write_engineering_server_modules_readme "$base_dir/server/modules"
  fi

  if [[ -d "$base_dir/server/local" ]]; then
    write_engineering_server_local_readme "$base_dir/server/local"
  fi

  if [[ -d "$base_dir/server/remote" ]]; then
    write_engineering_server_remote_readme "$base_dir/server/remote"
  fi

  if [[ -d "$base_dir/server/assets" ]]; then
    write_engineering_server_assets_readme "$base_dir/server/assets"
  fi

  if [[ -d "$base_dir/shell" ]]; then
    write_engineering_shell_readme "$base_dir/shell"
  fi

  if [[ -d "$base_dir/shell/desktop" ]]; then
    write_engineering_shell_desktop_readme "$base_dir/shell/desktop"
  fi

  if [[ -d "$base_dir/shell/mobile" ]]; then
    write_engineering_shell_mobile_readme "$base_dir/shell/mobile"
  fi

  if [[ -d "$base_dir/shell/web" ]]; then
    write_engineering_shell_web_readme "$base_dir/shell/web"
  fi
}

write_engineering_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # ${PROJECT_NAME}

  Development workspace for the project.

  This directory contains the implementation code for the generated application.

  ## Technical Stack
  
  $( { 
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- Frontend: ${PROJECT_FRONTEND_NAME}"
    [[ "$FRONTEND_VARIANT" != "none" ]] && printf '%s\n' "- Frontend Variant: ${PROJECT_FRONTEND_VARIANT_NAME}"
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- Backend: ${PROJECT_BACKEND_NAME}"
    [[ "$BACKEND_FRAMEWORK" != "none" ]] && printf '%s\n' "- Backend Framework: ${PROJECT_BACKEND_FRAMEWORK_NAME}"
    [[ -n "${DATABASES_SELECTED[0]+x}" ]] && printf '%s\n' "- Databases: ${PROJECT_DATABASE_NAMES}"
    [[ -n "${SEARCH_ENGINES_SELECTED[0]+x}" ]] && printf '%s\n' "- Search Engines: ${PROJECT_SEARCH_ENGINE_NAMES}"
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- Desktop Shell: ${PROJECT_DESKTOP_SHELL_NAME}"
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- Mobile Shell: ${PROJECT_MOBILE_SHELL_NAME}"
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- Web Shell: ${PROJECT_WEB_SHELL_NAME}"
    true
  } | write_embedded_lines)

  $(if [[ "$ENABLED_SERVER_LOCAL" == "true" ||
          "$ENABLED_SERVER_REMOTE" == "true" ||
          "$ENABLED_SERVER_ASSETS" == "true" ]]; then
    {
      printf '%s\n' "## Runtime Targets"
      printf '\n'
      [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- Local Runtime: true"
      [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- Remote Runtime: true"
      [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- Asset Server: true"
      true
    } | write_embedded_lines
  fi)

  ## Getting Started

  This workspace has been generated by project.sh.

  The application code may still need to be initialized depending on the generated project sections.

  ## Prerequisites

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- Install the toolchain required by ${PROJECT_FRONTEND_NAME}."
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- Install the backend/runtime toolchain required by ${PROJECT_BACKEND_NAME}."
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- Install the desktop shell toolchain required by ${PROJECT_DESKTOP_SHELL_NAME}."
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- Install the mobile shell toolchain required by ${PROJECT_MOBILE_SHELL_NAME}."
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- Install the web shell or orchestration tooling required by ${PROJECT_WEB_SHELL_NAME}."
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- Define shared asset publishing requirements for this project."
    true
  } | write_embedded_lines )

  ## Install

  TODO: define install commands after the real project code has been initialized.

  ## Run Development

  TODO: define development startup commands.

  ## Build

  TODO: define build commands.

  ## Test

  TODO: define test commands.

  ## Project Layout

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- client: frontend application"
    [[ "$PROJECT_HAS_SERVER" == "true" ]] && printf '%s\n' "- server: backend/runtime and delivery implementation"
    [[ "$PROJECT_HAS_DESKTOP" == "true" || "$PROJECT_HAS_MOBILE" == "true" || "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell: platform-specific application shells"
    true
  } | write_embedded_lines)

  ## Development Rules

  Before implementing code, read:

  - ../00-META/context/stack.yml
  - ../00-META/governance/architecture-rules.md
  - ../00-META/governance/naming-rules.md
  - ../00-META/skills/README.md

  ## Notes

  This README is for development usage.

  Project truth, AI rules, architectural decisions and technology-specific
  constraints belong in 00-META.
EOF
}

write_engineering_client_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Client

  Frontend development workspace.

  ## Selected Stack

  - ${PROJECT_FRONTEND_NAME}

  $(if [[ "$FRONTEND_VARIANT" != "none" ]]; then
    {
      printf '%s\n' "## Selected Variant"
      printf '\n'
      printf '%s\n' "- ${PROJECT_FRONTEND_VARIANT_NAME}"
    } | write_embedded_lines
  fi)

  ## Role

  The client contains the user interface application.

  It owns:

  - screens
  - routes
  - UI state
  - view components
  - user interactions
  - frontend integration services

  ## Getting Started

  TODO: initialize the frontend project for ${PROJECT_FRONTEND_NAME}.

  ## Install

  TODO: define frontend install command.

  ## Run Development

  TODO: define frontend development command.

  ## Build

  TODO: define frontend build command.

  ## Test

  TODO: define frontend test command.

  ## Expected Structure

  TODO: define the frontend structure after initializing ${PROJECT_FRONTEND_NAME}.

  The structure must follow the selected frontend skill:

  - ../../00-META/skills/${FRONTEND_STACK}/SKILL.md

  ## Rules

  - Do not place backend runtime logic in the client.
  - Do not hardcode production data.
  - Keep UI structure explicit and maintainable.
  - Keep feature code separated from shared utilities.

  ## Related META Files

  - ../../00-META/context/stack.yml
  - ../../00-META/governance/architecture-rules.md
  - ../../00-META/skills/${FRONTEND_STACK}/SKILL.md
  $(if [[ "$FRONTEND_VARIANT" != "none" ]]; then
    printf '%s\n' "- ../../00-META/skills/${FRONTEND_VARIANT}/SKILL.md" |
      write_embedded_lines
  fi)
EOF
}

write_engineering_server_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Server

  This directory contains server-side runtime or delivery material for this project.

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "## Selected Stack"
      printf '\n'
      printf '%s\n' "- ${PROJECT_BACKEND_NAME}"
      printf '\n'
    } | write_embedded_lines
  fi)

  $(if [[ "$BACKEND_FRAMEWORK" != "none" ]]; then
    {
      printf '%s\n' "## Selected Framework"
      printf '\n'
      printf '%s\n' "- ${PROJECT_BACKEND_FRAMEWORK_NAME}"
      printf '\n'
    } | write_embedded_lines
  fi)

  $(if [[ -n "${DATABASES_SELECTED[0]+x}" ||
        -n "${SEARCH_ENGINES_SELECTED[0]+x}" ]]; then
    {
      printf '%s\n' "## Selected Data Services"
      printf '\n'

      if [[ -n "${DATABASES_SELECTED[0]+x}" ]]; then
        printf '%s\n' "- Databases: ${PROJECT_DATABASE_NAMES}"
      fi

      if [[ -n "${SEARCH_ENGINES_SELECTED[0]+x}" ]]; then
        printf '%s\n' "- Search Engines: ${PROJECT_SEARCH_ENGINE_NAMES}"
      fi

      printf '\n'
      printf '%s\n' "Selected data services describe the project-level technical profile."
      printf '\n'
      printf '%s\n' "Their presence does not imply that every local or remote runtime consumes every"
      printf '%s\n' "selected data service."
    } | write_embedded_lines
  fi)

  $(if [[ "$ENABLED_SERVER_LOCAL" == "true" ||
          "$ENABLED_SERVER_REMOTE" == "true" ||
          "$ENABLED_SERVER_ASSETS" == "true" ]]; then
    {
      printf '%s\n' "## Runtime Targets"
      printf '\n'
      [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- Local Runtime: true"
      [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- Remote Runtime: true"
      [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- Asset Server: true"
      true
    } | write_embedded_lines
  fi)

  ## Role

  The server area contains the runtime and delivery sections generated from the
  CLI interview answers.

  ## Generated Structure

  $({
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- modules: reusable backend/runtime modules"
    [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- local: local runtime entry point"
    [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- remote: remote runtime entry point"
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- assets: shared asset delivery"
    true
  } | write_embedded_lines)

  ## Development

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "TODO: initialize backend/runtime code for ${PROJECT_BACKEND_NAME}."
      printf '\n'
      printf '%s\n' "## Install"
      printf '\n'
      printf '%s\n' "TODO: define backend install command."
      printf '\n'
      printf '%s\n' "## Run Development"
      printf '\n'
      printf '%s\n' "TODO: define backend development command."
      printf '\n'
      printf '%s\n' "## Build"
      printf '\n'
      printf '%s\n' "TODO: define backend build command."
      printf '\n'
      printf '%s\n' "## Test"
      printf '\n'
      printf '%s\n' "TODO: define backend test command."
    } | write_embedded_lines
  else
    {
      printf '%s\n' "TODO: define the development workflow for the generated server delivery sections."
    } | write_embedded_lines
  fi)

  ## Rules

  - Runtime composition belongs to local or remote entry points.
  - Business modules must remain reusable.
  - Modules should not depend on whether they run locally or remotely.
  - Transport-specific concerns must stay at runtime boundaries.
  - The asset server may exist independently from local and remote runtimes.
  - The asset server does not require a backend stack.
  - Keep shared asset delivery separate from runtime execution.
  - Keep this server documentation aligned with the generated server structure.

  ## Related META Files

  - ../../00-META/context/stack.yml
  - ../../00-META/governance/architecture-rules.md
  - ../../00-META/governance/naming-rules.md
  - ../../00-META/skills/README.md
EOF
}
write_engineering_server_modules_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Server Modules

  This directory contains reusable backend/runtime modules for this project.

  ## Selected Backend Stack

  - ${PROJECT_BACKEND_NAME}

  ## Role

  Server modules contain reusable business, domain or runtime logic.

  They are designed to be composed by runtime entry points.

  ## Development

  TODO: initialize module structure for ${PROJECT_BACKEND_NAME}.

  ## Build

  TODO: define module build command if modules are built independently.

  ## Test

  TODO: define module test command.

  ## Expected Module Responsibilities

  Modules may contain:

  - domain services
  - business logic
  - connectors
  - import/export logic
  - validation logic
  - infrastructure adapters when scoped to the module

  ## Relationship With Runtime Targets

  - server/local composes modules for local execution when enabled.
  - server/remote exposes or runs modules for remote execution when enabled.
  - modules must not depend on whether they are executed locally or remotely.

  ## Rules

  - Keep modules isolated.
  - Avoid circular dependencies.
  - Do not bind modules directly to a transport layer.
  - Do not place runtime composition inside modules.
  - Do not duplicate logic between local and remote runtimes.
  - Do not document modules that are not part of this project.

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/naming-rules.md
  - ../../../00-META/skills/${BACKEND_STACK}/SKILL.md
EOF
}
write_engineering_server_local_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Local Runtime

  This directory contains the local runtime entry point for this project.

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "## Selected Backend Stack"
      printf '\n'
      printf '%s\n' "- ${PROJECT_BACKEND_NAME}"
      printf '\n'
    } | write_embedded_lines
  fi)
  $(if [[ "$PROJECT_HAS_DESKTOP" == "true" ]]; then
    {
      printf '%s\n' "## Selected Desktop Shell"
      printf '\n'
      printf '%s\n' "- ${PROJECT_DESKTOP_SHELL_NAME}"
      printf '\n'
    } | write_embedded_lines
  fi)

  ## Role

  The local runtime is used when the application needs a local runtime process.

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    printf '%s\n' "It composes reusable server modules for local execution."
  else
    printf '%s\n' "Its implementation responsibilities must be defined explicitly."
  fi)

  ## Development

  TODO: initialize the local runtime code.

  ## Run Development

  TODO: define the local runtime development command.

  ## Build

  TODO: define the local runtime build command.

  ## Test

  TODO: define the local runtime test command.

  ## Relationship With Other Sections

  $( {
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- server/modules contains reusable runtime modules."
    if [[ "$BACKEND_STACK" != "none" ]]; then
      printf '%s\n' "- server/local composes modules for local execution."
    else
      printf '%s\n' "- server/local contains the local runtime entry point."
    fi
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- shell/desktop may connect to this runtime when a desktop shell is enabled."
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- shell/mobile may connect to this runtime when a mobile shell is enabled."
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell/web may reference this runtime when local development requires it."
    true
  } | write_embedded_lines )

  ## Rules

  - Keep local runtime code at the boundary.
  - Keep local-specific responsibilities isolated.
  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "- Do not duplicate business logic from modules."
      printf '%s\n' "- Keep local-specific adapters separated from reusable modules."
    } | write_embedded_lines
  fi)

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
  $({
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- ../../../00-META/skills/${BACKEND_STACK}/SKILL.md"
    true
  } | write_embedded_lines)
EOF
}
write_engineering_server_remote_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Remote Runtime

  This directory contains the remote runtime entry point for this project.

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "## Selected Backend Stack"
      printf '\n'
      printf '%s\n' "- ${PROJECT_BACKEND_NAME}"
      printf '\n'
    } | write_embedded_lines
  fi)

  ## Runtime Target

  - Remote Runtime: ${ENABLED_SERVER_REMOTE}

  ## Role

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "The remote runtime exposes or runs backend/runtime modules outside"
      printf '%s\n' "the local application process."
    } | write_embedded_lines
  else
    {
      printf '%s\n' "The remote runtime provides a remotely executed server capability."
      printf '%s\n' "Its implementation responsibilities must be defined explicitly."
    } | write_embedded_lines
  fi)

  ## Development

  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    printf '%s\n' "TODO: initialize the remote runtime code for ${PROJECT_BACKEND_NAME}."
  else
    printf '%s\n' "TODO: define the remote runtime implementation."
  fi)

  ## Run Development

  TODO: define the remote runtime development command.

  ## Build

  TODO: define the remote runtime build command.

  ## Test

  TODO: define the remote runtime test command.

  ## Deployment

  TODO: define deployment assumptions when the remote runtime target is implemented.

  ## Relationship With Other Sections

  $( {
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- server/modules contains reusable backend/runtime modules."
    if [[ "$BACKEND_STACK" != "none" ]]; then
      printf '%s\n' "- server/remote composes or exposes modules for remote execution."
    else
      printf '%s\n' "- server/remote contains the remote runtime entry point."
    fi
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell/web may orchestrate or expose this runtime."
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- server/assets handles shared asset concerns separately."

    true
  } | write_embedded_lines )

  ## Rules

  - Keep remote runtime code at the execution boundary.
  - Keep transport-specific concerns at the runtime boundary.
  - Do not duplicate logic from server/local.
  - Do not assume cloud infrastructure unless defined by the project context.
  $(if [[ "$BACKEND_STACK" != "none" ]]; then
    {
      printf '%s\n' "- Remote entry points expose or run reusable modules."
      printf '%s\n' "- Business logic should remain inside modules."
    } | write_embedded_lines
  fi)

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
  $( {
    [[ "$BACKEND_STACK" != "none" ]] && printf '%s\n' "- ../../../00-META/skills/${BACKEND_STACK}/SKILL.md"
    true
  } | write_embedded_lines )

EOF
}
write_engineering_server_assets_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Asset Server

  This directory contains shared asset delivery material for this project.

  ## Asset Server Support

  - Enabled: ${ENABLED_SERVER_ASSETS}

  ## Role

  The asset server is an autonomous server capability.

  It can exist without:

  - a local runtime
  - a remote runtime
  - a backend application stack
  - reusable backend modules

  Its implementation technology must remain undefined until explicitly selected.

  ## Responsibilities

  The asset server may own:

  - shared static asset distribution
  - public asset delivery
  - shared media delivery
  - asset storage strategy
  - asset synchronization strategy
  - asset publication workflow
  - asset validation
  - cache and delivery configuration when required

  ## Development

  TODO: define the shared asset delivery implementation.

  ## Build / Publish

  TODO: define shared asset build, publishing or synchronization commands.

  ## Architecture Boundaries

  Frontend build assets belong in:

  \`\`\`txt
  client/
  \`\`\`

  Shared asset delivery belongs in:

  \`\`\`txt
  server/assets/
  \`\`\`

  Web exposure of the frontend client belongs in:

  \`\`\`txt
  shell/web/
  \`\`\`

  Backend runtime execution belongs in:

  \`\`\`txt
  server/local/
  server/remote/
  \`\`\`

  The asset server must not duplicate frontend, runtime or shell
  responsibilities.

  ## Relationship With Other Sections

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- client may consume shared assets but does not own their shared delivery."
    [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- server/local remains independent from shared asset delivery."
    [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- server/remote remains independent from shared asset delivery."
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- shell/web may consume shared assets but does not own their delivery."
    printf '%s\n' "- server/assets owns shared asset delivery concerns."
  } | write_embedded_lines )

  ## Rules

  - Do not place application business logic in server/assets.
  - Do not place frontend application source code in server/assets.
  - Do not duplicate local or remote runtime logic.
  - Do not move web shell responsibilities into server/assets.
  - Do not hardcode production asset endpoints.
  - Do not assume an implementation technology without an explicit decision.
  - Keep publishing, synchronization and delivery assumptions documented.
  - Keep sensitive configuration externalized.

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/context/architecture.md
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
EOF
}


write_engineering_shell_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Shell

  This directory contains platform shell code for this project.

  A shell exposes or integrates the client with a target desktop, mobile or web environment.

  ## Selected Shells

  $( {
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- Desktop: ${PROJECT_DESKTOP_SHELL_NAME}"
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- Mobile: ${PROJECT_MOBILE_SHELL_NAME}"
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- Web: ${PROJECT_WEB_SHELL_NAME}"
    true
  } | write_embedded_lines )

  ## Generated Structure

  $( {
    [[ "$PROJECT_HAS_DESKTOP" == "true" ]] && printf '%s\n' "- desktop: desktop shell implementation"
    [[ "$PROJECT_HAS_MOBILE" == "true" ]] && printf '%s\n' "- mobile: mobile shell implementation"
    [[ "$PROJECT_HAS_WEB" == "true" ]] && printf '%s\n' "- web: web exposure and runtime integration of the frontend client"
    true
  } | write_embedded_lines )

  ## Development

  TODO: define shell-level development commands after initializing the selected
  shell technologies.

  ## Build / Package

  TODO: define shell-level build or packaging commands.

  ## Rules

  - Shells should not contain business modules directly.
  - Shells should integrate, package and bridge.
  - Runtime logic belongs to server/local or server/remote.
  - Keep shell documentation aligned with the generated shell structure.

  ## Related META Files

  - ../../00-META/context/stack.yml
  - ../../00-META/governance/architecture-rules.md
  - ../../00-META/skills/README.md
EOF
}
write_engineering_shell_desktop_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Desktop Shell

  This directory contains the desktop shell implementation for this project.

  ## Selected Shell

  - ${PROJECT_DESKTOP_SHELL_NAME}

  ## Role

  The desktop shell wraps the client application and connects it to the selected
  runtime environment.

  ## Development

  TODO: initialize the desktop shell project.

  ## Run Development

  TODO: define the desktop shell development command.

  ## Build / Package

  TODO: define the desktop packaging command.

  ## Responsibilities

  The selected desktop shell owns:

  - window lifecycle
  - native integration
  - permissions
  - filesystem access when required
  - runtime bridge
  - packaging
  - desktop-specific capabilities

  ## Relationship With Other Sections

  - client contains the frontend application.
  - server/local contains the local runtime when enabled.
  - shell/desktop contains only desktop shell integration.

  ## Rules

  - Do not place business modules directly in the desktop shell.
  - Keep native integration separated from reusable frontend and backend code.
  
  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
  - ../../../00-META/skills/${SHELL_DESKTOP}/SKILL.md
EOF
}
write_engineering_shell_mobile_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Mobile Shell

  This directory contains the mobile shell implementation for this project.

  ## Selected Shell

  - ${PROJECT_MOBILE_SHELL_NAME}

  ## Role

  The mobile shell wraps or integrates the client application for mobile
  environments according to the selected CLI interview answers.

  ## Development

  TODO: initialize the mobile shell project.

  ## Run Development

  TODO: define the mobile shell development command.

  ## Build / Package

  TODO: define the mobile build or packaging command.

  ## Responsibilities

  The selected mobile shell owns:

  - mobile platform integration
  - application lifecycle
  - platform permissions
  - device APIs when required
  - native bridge integration
  - mobile packaging

  ## Relationship With Other Sections

  - client contains the frontend application.
  - shell/mobile contains only selected mobile shell integration.
  - server/local or server/remote may provide runtime services when enabled.
  - reusable business logic must not live directly in the mobile shell.

  ## Rules

  - Keep mobile-specific integration isolated.
  - Do not duplicate frontend business behavior.
  - Do not place backend runtime logic in the mobile shell.

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
  - ../../../00-META/skills/${SHELL_MOBILE}/SKILL.md
EOF
}
write_engineering_shell_web_readme() {
  local dir="$1"

  write_document "$dir/README.md" <<EOF
  # Web Shell

  This directory contains the web shell for this project.

  The web shell exposes the frontend client in a web environment using the
  selected web shell technology.

  ## Selected Web Shell

  - ${PROJECT_WEB_SHELL_NAME}

  ## Role

  The web shell connects the frontend client to its web runtime environment.

  It owns the configuration required to serve, expose and connect the client
  without containing frontend or backend business logic.

  ## Development

  TODO: initialize the web shell files.

  ## Run Development

  TODO: define the web shell development command.

  ## Build / Package

  TODO: define the web shell build or packaging command.

  ## Responsibilities

  The selected web shell owns:

  - frontend web serving
  - web runtime wiring
  - environment wiring
  - service connectivity
  - reverse proxy configuration when required
  - container configuration when required
  - runtime packaging when required
  - web publication configuration when required

  ## Relationship With Other Sections

  $( {
    [[ "$PROJECT_HAS_FRONTEND" == "true" ]] && printf '%s\n' "- client contains the frontend application."
    [[ "$ENABLED_SERVER_LOCAL" == "true" ]] && printf '%s\n' "- server/local contains the local runtime entry point."
    [[ "$ENABLED_SERVER_REMOTE" == "true" ]] && printf '%s\n' "- server/remote contains the remote runtime entry point."
    [[ "$ENABLED_SERVER_ASSETS" == "true" ]] && printf '%s\n' "- server/assets contains shared asset delivery material."
    printf '%s\n' "- shell/web contains only web exposure, integration and runtime wiring concerns."
  } | write_embedded_lines )

  ## Architecture Boundaries

  - client owns the frontend application.
  - shell/web owns the web exposure of the client.
  - server/local and server/remote own backend runtime execution.
  - server/assets owns shared asset delivery when enabled.
  - shell/web must not duplicate responsibilities from these sections.

  ## Rules

  - Do not place application business logic in shell/web.
  - Do not place frontend application source code directly in shell/web.
  - Do not duplicate backend runtime logic in shell/web.
  - Do not mix web shell configuration with reusable backend modules.
  - Do not move shared asset delivery responsibilities into shell/web.
  - Keep web shell documentation aligned with the selected web shell.

  $(if [[ "$ENABLED_SERVER_ASSETS" == "true" ]]; then
    {
      printf '%s\n' "- Keep shared asset concerns in server/assets."
    } | write_embedded_lines
  fi)

  ## Related META Files

  - ../../../00-META/context/stack.yml
  - ../../../00-META/context/architecture.md
  - ../../../00-META/governance/architecture-rules.md
  - ../../../00-META/governance/security-rules.md
  - ../../../00-META/skills/${SHELL_WEB}/SKILL.md
EOF
}



###############################################################################
# 05-LAB
###############################################################################

create_lab_tree() {
  local base_dir="05-LAB"

  create_tree \
    "$base_dir" \
    "$base_dir/prototypes" \
    "$base_dir/playground"
}
write_lab_documents() {
  write_lab_readme
  write_lab_prototypes_readme
  write_lab_playground_readme
}


write_lab_readme() {
  write_document "05-LAB/README.md" <<'EOF'
  # Lab

  This section contains experimental work that should not yet be treated as
  production truth.

  It is used for prototypes, technical experiments, quick validation attempts and
  isolated playground work.

  ## Directories

  ### prototypes

  Exploratory implementations used to validate an idea.

  ### playground

  Temporary sandbox work and isolated trials.
EOF
}
write_lab_prototypes_readme() {
  write_document "05-LAB/prototypes/README.md" <<'EOF'
  # Prototypes

  This directory contains prototypes.

  A prototype is an exploratory implementation used to test an idea, workflow,
  interaction, integration or technical direction.

  ## Examples

  - Feature prototypes
  - UI prototypes
  - Runtime prototypes
  - Connector prototypes
  - Workflow prototypes
  - Proofs of concept

  ## Rules

  - Prototype code can be incomplete, temporary or disposable.
  - Do not treat prototype code as production-ready without review.
  - Useful prototype code must be cleaned before migration into engineering.
EOF
}
write_lab_playground_readme() {
  write_document "05-LAB/playground/README.md" <<'EOF'
  # Playground

  This directory contains sandbox work.

  Use it for temporary trials, isolated tests and quick exploration that does not
  yet belong to a formal experiment or prototype.

  ## Examples

  - Temporary scripts
  - Small test projects
  - Throwaway validation code
  - API trials
  - Runtime checks
  - Local experiments

  ## Rules

  - Anything useful from this directory should be extracted and cleaned.
  - Playground work should not become production truth without review.
  - Keep temporary experiments clearly separated from durable implementation code.
EOF
}



###############################################################################
# 09-LEGACY
###############################################################################

create_legacy_tree() {
  local base_dir="09-LEGACY"

  create_tree \
    "$base_dir" \
    "$base_dir/codebase" \
    "$base_dir/migration"
}
write_legacy_documents() {
  write_legacy_readme
  write_legacy_codebase_readme
  write_legacy_migration_readme
  write_legacy_migration_project_overview
  write_legacy_migration_source_tree
  write_legacy_migration_technology_inventory
  write_legacy_migration_architecture_analysis
  write_legacy_migration_business_rules
  write_legacy_migration_external_dependencies
  write_legacy_migration_technical_debt
  write_legacy_migration_migration_risks
  write_legacy_migration_migration_plan
  write_legacy_migration_migration_tasks
}

write_legacy_readme() {
  write_document "09-LEGACY/README.md" <<'EOF'
  # Legacy

  This section contains the existing codebase and its migration workspace.

  ## Directories

  ### codebase

  Preserved source code used as migration input.

  ### migration

  Analysis, inventory, risks, planning and migration tracking documents.

  ## Rules

  - Legacy source code belongs in codebase.
  - Migration analysis and planning belong in migration.
  - Target implementation code belongs in 04-ENGINEERING.
  - Do not silently modify or reorganize imported legacy code.
EOF
}

write_legacy_codebase_readme() {
  write_document "09-LEGACY/codebase/README.md" <<'EOF'
  # Legacy Codebase

  This directory contains the existing source code to analyze and migrate.

  ## Rules

  - Preserve the imported source structure.
  - Do not treat legacy conventions as target architecture rules.
  - Document the source structure in ../migration/source-tree.md.
  - Document detected technologies in ../migration/technology-inventory.md.
  - Document migration work before moving target implementation into 04-ENGINEERING.
EOF
}

write_legacy_migration_readme() {
  write_document "09-LEGACY/migration/README.md" <<'EOF'
  # Legacy Migration Workspace

  This directory contains the analysis and planning documents required to migrate
  the codebase stored in ../codebase.

  ## Purpose

  The migration workspace describes the current legacy system, the intended target
  state, migration constraints, identified risks and confirmed migration work.

  It must be completed from evidence found in the legacy codebase and confirmed
  project documentation.

  ## Documents

  ### project-overview.md

  High-level description of the legacy application, its purpose, scope and known
  operational context.

  ### source-tree.md

  Inventory of the legacy source tree and the responsibilities of its main
  directories.

  ### technology-inventory.md

  Inventory of detected languages, frameworks, libraries, tools, storage systems
  and runtime dependencies.

  ### architecture-analysis.md

  Analysis of the current architecture, module boundaries, runtime flows, coupling
  and structural constraints.

  ### business-rules.md

  Confirmed business rules discovered in the legacy implementation or existing
  documentation.

  ### external-dependencies.md

  Inventory of external services, APIs, infrastructure, packages and integrations.

  ### technical-debt.md

  Confirmed technical debt supported by concrete evidence from the legacy system.

  ### migration-risks.md

  Risks specifically associated with analyzing, replacing or migrating the legacy
  implementation.

  ### migration-plan.md

  Confirmed migration strategy, phases, boundaries and validation approach.

  ### migration-tasks.md

  Migration-specific work identified from the validated migration plan.

  ## Required Reading

  Before analyzing or migrating legacy code, read:

  - ../../00-META/context/stack.yml
  - ../../00-META/context/architecture.md
  - ../../00-META/context/open-arbitrations.md
  - ../../00-META/context/risks.md
  - ../../00-META/governance/architecture-rules.md
  - ../../00-META/governance/naming-rules.md
  - ../../00-META/governance/security-rules.md
  - ../../00-META/playbooks/migration.md
  - README.md
  - project-overview.md
  - source-tree.md
  - technology-inventory.md
  - architecture-analysis.md
  - business-rules.md
  - external-dependencies.md
  - technical-debt.md
  - migration-risks.md
  - migration-plan.md
  - migration-tasks.md

  ## Rules

  - Do not invent facts about the legacy codebase.
  - Support findings with concrete files, symbols, configuration or documented behavior.
  - Clearly separate confirmed findings, assumptions and unresolved questions.
  - Do not treat legacy architecture as the target architecture.
  - Do not modify the imported legacy code without explicit migration work.
  - Do not begin migration implementation before the affected scope is analyzed.
  - Do not silently resolve migration arbitrations.
  - Record durable migration decisions in 00-META/decisions.
  - Record project-level risks in 00-META/context/risks.md.
  - Keep target implementation code in 04-ENGINEERING.
  - Keep this workspace aligned with the migration playbook.
EOF
}
write_legacy_migration_project_overview() {
  write_document "09-LEGACY/migration/project-overview.md" <<'EOF'
  # Project Overview

  ## Status

  Not analyzed.

  ## Purpose

  Describe the known purpose and operational role of the legacy application.

  TODO

  ## Legacy Scope

  Identify the code, applications, services, packages or components included in
  the migration analysis.

  TODO

  ## Excluded Scope

  Identify elements explicitly excluded from the current migration scope.

  TODO

  ## Known Users And Consumers

  Identify confirmed users, systems, services or processes that consume the legacy
  application.

  TODO

  ## Current Capabilities

  List only capabilities confirmed by code, configuration, tests or existing
  documentation.

  TODO

  ## Entry Points

  Identify confirmed application, runtime, command-line, scheduled, worker or
  integration entry points.

  TODO

  ## Data Responsibilities

  Describe confirmed data owned, read, written, transformed or exposed by the
  legacy implementation.

  TODO

  ## Operational Context

  Document confirmed deployment, execution, scheduling or hosting information.

  TODO

  ## Known Constraints

  Record confirmed technical, organizational, compatibility, security or
  operational constraints.

  TODO

  ## Unknowns

  List information that remains unresolved after the initial analysis.

  TODO

  ## Evidence

  Reference the files, directories, configuration, documentation or runtime
  observations supporting this overview.

  TODO

  ## Rules

  - Do not infer product purpose from naming alone.
  - Do not present assumptions as confirmed behavior.
  - Keep detailed architecture findings in architecture-analysis.md.
  - Keep technology details in technology-inventory.md.
  - Keep migration decisions in migration-plan.md.
EOF
}
write_legacy_migration_source_tree() {
  write_document "09-LEGACY/migration/source-tree.md" <<'EOF'
  # Source Tree

  ## Status

  Not analyzed.

  ## Source Location

  The legacy source code is stored in:

  - 09-LEGACY/codebase/

  ## Tree Overview

  Record the relevant source tree without including generated dependencies, build
  outputs, caches or unrelated binary material.

  TODO

  ## Directory Responsibilities

  For each significant directory, document its confirmed responsibility.

  ### Directory

  - Path:
  - Responsibility:
  - Main entry points:
  - Dependencies:
  - Consumers:
  - Migration relevance:
  - Evidence:

  ## Important Files

  Document files that define application startup, dependency management,
  configuration, build, deployment, data schema or runtime behavior.

  ### File

  - Path:
  - Purpose:
  - Used by:
  - Migration relevance:
  - Evidence:

  ## Generated And Vendor Content

  Identify directories that contain generated code, vendored dependencies, build
  outputs or external artifacts.

  TODO

  ## Unclear Areas

  Identify directories or files whose responsibility remains unresolved.

  TODO

  ## Migration Boundaries

  Record confirmed boundaries that can be migrated, isolated, replaced or removed
  independently.

  TODO

  ## Rules

  - Preserve original paths in every reference.
  - Do not document generated dependencies as application modules.
  - Do not assign responsibilities based only on directory names.
  - Reference concrete files when describing a directory responsibility.
  - Keep target structure proposals in migration-plan.md.
EOF
}
write_legacy_migration_technology_inventory() {
  write_document "09-LEGACY/migration/technology-inventory.md" <<'EOF'
  # Technology Inventory

  ## Status

  Not analyzed.

  ## Languages

  ### Technology

  - Name:
  - Version:
  - Scope:
  - Detection source:
  - Support status:
  - Migration relevance:

  ## Frameworks

  ### Technology

  - Name:
  - Version:
  - Scope:
  - Detection source:
  - Support status:
  - Migration relevance:

  ## Runtime Environments

  ### Runtime

  - Name:
  - Version:
  - Entry points:
  - Configuration:
  - Detection source:
  - Migration relevance:

  ## Package And Dependency Management

  ### Tool

  - Name:
  - Manifest files:
  - Lock files:
  - Registries:
  - Detection source:
  - Migration relevance:

  ## Databases And Data Stores

  ### Data Service

  - Name:
  - Version:
  - Role:
  - Schema or configuration:
  - Access locations:
  - Source of truth:
  - Migration relevance:

  ## Search And Indexing

  ### Search Service

  - Name:
  - Version:
  - Role:
  - Index definitions:
  - Synchronization mechanism:
  - Migration relevance:

  ## Build And Packaging Tools

  ### Tool

  - Name:
  - Version:
  - Configuration:
  - Outputs:
  - Detection source:
  - Migration relevance:

  ## Testing Tools

  ### Tool

  - Name:
  - Version:
  - Test locations:
  - Execution command:
  - Detection source:
  - Migration relevance:

  ## Deployment And Infrastructure

  ### Technology

  - Name:
  - Configuration:
  - Responsibility:
  - Detection source:
  - Migration relevance:

  ## Observability

  ### Technology

  - Name:
  - Logging responsibility:
  - Metrics responsibility:
  - Tracing responsibility:
  - Detection source:
  - Migration relevance:

  ## Unsupported Or Obsolete Technologies

  Record only technologies whose unsupported or obsolete status is confirmed.

  TODO

  ## Unknown Versions

  List detected technologies whose version cannot yet be confirmed.

  TODO

  ## Rules

  - Record only technologies supported by source or configuration evidence.
  - Do not infer versions from general release dates.
  - Distinguish direct dependencies from transitive dependencies.
  - Distinguish active technologies from obsolete or unused configuration.
  - Reference the exact manifest, lock file or configuration source.
EOF
}
write_legacy_migration_architecture_analysis() {
  write_document "09-LEGACY/migration/architecture-analysis.md" <<'EOF'
  # Architecture Analysis

  ## Status

  Not analyzed.

  ## Architecture Summary

  Describe the confirmed architectural shape of the legacy system.

  TODO

  ## Runtime Topology

  Identify confirmed processes, applications, workers, services, scheduled jobs
  and communication paths.

  TODO

  ## Main Components

  ### Component

  - Name:
  - Paths:
  - Responsibility:
  - Inputs:
  - Outputs:
  - Dependencies:
  - Consumers:
  - State owned:
  - Evidence:

  ## Entry Points

  ### Entry Point

  - Path:
  - Trigger:
  - Runtime:
  - Responsibilities:
  - Dependencies:
  - Evidence:

  ## Module Boundaries

  Identify boundaries that are explicit in the codebase and boundaries that are
  currently implicit or violated.

  TODO

  ## Dependency Direction

  Describe confirmed dependency flows between major components.

  TODO

  ## Coupling And Cohesion

  Record concrete coupling, circular dependencies, shared state or duplicated
  responsibilities.

  TODO

  ## Data Flow

  Describe how data enters, moves through and leaves the legacy system.

  TODO

  ## State Management

  Identify persistent, transient, cached, session and externally managed state.

  TODO

  ## Integration Boundaries

  Identify APIs, message transports, files, databases, subprocesses and external
  service boundaries.

  TODO

  ## Security Boundaries

  Identify confirmed authentication, authorization, trust, secret-management and
  privileged-execution boundaries.

  TODO

  ## Failure Boundaries

  Identify confirmed error propagation, retry, recovery and partial-failure
  behavior.

  TODO

  ## Architecture Constraints

  Record constraints that must be preserved, explicitly changed or removed during
  migration.

  TODO

  ## Target Architecture Impact

  Reference confirmed differences between the legacy architecture and the target
  architecture documented in 00-META/context/architecture.md.

  TODO

  ## Evidence

  TODO

  ## Rules

  - Describe current architecture separately from target architecture.
  - Do not classify a pattern without concrete code or configuration evidence.
  - Do not turn migration proposals into confirmed architecture decisions.
  - Record unresolved architectural choices in ../../00-META/context/open-arbitrations.md when required.
  - Record accepted durable architecture decisions in ../../00-META/decisions.
EOF
}
write_legacy_migration_business_rules() {
  write_document "09-LEGACY/migration/business-rules.md" <<'EOF'
  # Business Rules

  ## Status

  Not analyzed.

  ## Purpose

  Document business behavior that must be understood before migration.

  Business rules must be supported by implementation code, tests, configuration,
  existing documentation or explicit user confirmation.

  ## Rule Format

  ### BR-XXX - Rule Title

  - Status: confirmed | unclear | obsolete
  - Scope:
  - Trigger:
  - Preconditions:
  - Rule:
  - Result:
  - Exceptions:
  - Side effects:
  - Evidence:
  - Related components:
  - Migration requirement:

  ## Confirmed Rules

  None.

  ## Unclear Rules

  None.

  ## Potentially Obsolete Rules

  None.

  ## Validation Gaps

  Identify rules that are implemented but not covered by tests or reliable
  documentation.

  None.

  ## Cross-Rule Dependencies

  Document dependencies or ordering constraints between confirmed rules.

  None.

  ## Rules

  - Use stable BR-XXX identifiers.
  - Do not create a business rule from a technical implementation detail alone.
  - Do not infer intent from behavior when intent is not documented.
  - Keep unclear behavior in the Unclear Rules section.
  - Do not remove potentially obsolete behavior without explicit validation.
  - Reference tests when tests provide the strongest evidence.
  - Link implementation tasks only after the migration requirement is confirmed.
EOF
}
write_legacy_migration_external_dependencies() {
  write_document "09-LEGACY/migration/external-dependencies.md" <<'EOF'
  # External Dependencies

  ## Status

  Not analyzed.

  ## Purpose

  Inventory dependencies outside the legacy source tree that affect execution,
  integration, data, deployment or migration.

  ## External Services

  ### Dependency

  - Name:
  - Type:
  - Purpose:
  - Protocol:
  - Endpoint source:
  - Authentication:
  - Data exchanged:
  - Failure behavior:
  - Configuration:
  - Consumers:
  - Migration relevance:
  - Evidence:

  ## External APIs

  ### API

  - Name:
  - Provider:
  - Purpose:
  - Protocol:
  - Version:
  - Authentication:
  - Request locations:
  - Response handling:
  - Migration relevance:
  - Evidence:

  ## Infrastructure Dependencies

  ### Dependency

  - Name:
  - Type:
  - Purpose:
  - Configuration:
  - Runtime dependency:
  - Migration relevance:
  - Evidence:

  ## File And Storage Dependencies

  ### Dependency

  - Path or service:
  - Purpose:
  - Data format:
  - Read or write:
  - Ownership:
  - Retention assumptions:
  - Migration relevance:
  - Evidence:

  ## Package Registries And Artifact Sources

  ### Source

  - Name:
  - Purpose:
  - Configuration:
  - Credentials required:
  - Migration relevance:
  - Evidence:

  ## Runtime Commands And Subprocesses

  ### Command

  - Command or executable:
  - Trigger:
  - Purpose:
  - Inputs:
  - Outputs:
  - Failure behavior:
  - Migration relevance:
  - Evidence:

  ## Scheduled And Event-Driven Dependencies

  ### Trigger

  - Name:
  - Type:
  - Schedule or event:
  - Target:
  - Failure behavior:
  - Migration relevance:
  - Evidence:

  ## Unknown Dependencies

  None.

  ## Rules

  - Do not store credentials, tokens or secret values in this document.
  - Reference the configuration source instead of copying sensitive values.
  - Distinguish mandatory runtime dependencies from optional integrations.
  - Distinguish active dependencies from obsolete configuration.
  - Record unknown ownership or behavior explicitly.
EOF
}
write_legacy_migration_technical_debt() {
  write_document "09-LEGACY/migration/technical-debt.md" <<'EOF'
  # Technical Debt

  ## Status

  Not analyzed.

  ## Purpose

  Record confirmed technical debt that affects maintenance, reliability,
  security, testing, migration or operation.

  Technical debt must be supported by concrete evidence.

  ## Debt Format

  ### DEBT-XXX - Debt Title

  - Area:
  - Status: active | accepted | resolved
  - Evidence:
  - Affected paths:
  - Current impact:
  - Migration impact:
  - Dependencies:
  - Recommended treatment:
  - Related risk:
  - Related task:

  ## Active Debt

  None.

  ## Accepted Debt

  None.

  ## Resolved Debt

  None.

  ## Candidate Findings Requiring Validation

  None.

  ## Allowed Areas

  - architecture
  - code
  - dependencies
  - data
  - testing
  - security
  - build
  - deployment
  - operations
  - documentation

  ## Rules

  - Use stable DEBT-XXX identifiers.
  - Do not classify personal style preferences as technical debt.
  - Do not record unverified assumptions as active debt.
  - Keep uncertain findings in Candidate Findings Requiring Validation.
  - Do not duplicate migration risks in this document.
  - Link a migration risk when debt creates a possible adverse migration outcome.
  - Link a migration task only when remediation work is confirmed.
  - Preserve resolved debt for migration traceability.
EOF
}
write_legacy_migration_migration_risks() {
  write_document "09-LEGACY/migration/migration-risks.md" <<'EOF'
  # Migration Risks

  ## Status

  Not analyzed.

  ## Purpose

  Record risks specifically created or exposed by the legacy migration.

  Project-wide confirmed risks must also be reflected in:

  - ../../00-META/context/risks.md

  ## Active Risks

  None.

  ## Closed Risks

  None.

  ## Risk Format

  ### MIG-RISK-XXX - Risk Title

  - Area:
  - Impact:
  - Likelihood:
  - Trigger:
  - Affected scope:
  - Evidence:
  - Mitigation:
  - Contingency:
  - Owner:
  - Related debt:
  - Related arbitration:
  - Related task:

  ## Allowed Areas

  - behavior
  - compatibility
  - architecture
  - data
  - dependencies
  - security
  - performance
  - deployment
  - operations
  - schedule

  ## Allowed Impact Values

  - low
  - medium
  - high
  - critical

  ## Allowed Likelihood Values

  - low
  - medium
  - high

  ## Rules

  - Use stable MIG-RISK-XXX identifiers.
  - Record only risks supported by confirmed migration context.
  - Do not use this document for existing defects or technical debt.
  - Do not use this document for unresolved architecture decisions.
  - Reference ../../00-META/context/open-arbitrations.md when mitigation requires an unresolved choice.
  - Reference migration-tasks.md when mitigation requires confirmed migration work.
  - Track confirmed implementation work in ../../03-PRODUCT/kanban/TASKS.md.
  - Move resolved or no-longer-applicable risks to Closed Risks.
  - Do not delete closed risks.
  - Synchronize project-level risks with 00-META/context/risks.md when applicable.
EOF
}
write_legacy_migration_migration_plan() {
  write_document "09-LEGACY/migration/migration-plan.md" <<'EOF'
  # Migration Plan

  ## Status

  Draft.

  ## Objective

  Define the confirmed path from the analyzed legacy state to the target
  architecture.

  TODO

  ## Source State

  Summarize the confirmed legacy state using the analysis documents in this
  directory.

  TODO

  ## Target State

  Reference the confirmed target architecture documented in:

  - ../../00-META/context/stack.yml
  - ../../00-META/context/architecture.md
  - ../../00-META/decisions/

  TODO

  ## Migration Scope

  Identify the components, behavior, data, integrations and operational concerns
  included in this migration.

  TODO

  ## Out Of Scope

  Identify elements explicitly excluded from this migration.

  TODO

  ## Preserved Behavior

  List behavior and compatibility obligations that must remain stable.

  TODO

  ## Intended Changes

  List confirmed behavior, architecture, technology or operational changes.

  TODO

  ## Migration Strategy

  Describe the confirmed migration strategy.

  TODO

  ## Phases

  ### Phase 1 - Analysis Completion

  - Scope:
  - Preconditions:
  - Deliverables:
  - Validation:
  - Exit criteria:

  ### Phase 2 - Target Foundation

  - Scope:
  - Preconditions:
  - Deliverables:
  - Validation:
  - Exit criteria:

  ### Phase 3 - Incremental Migration

  - Scope:
  - Preconditions:
  - Deliverables:
  - Validation:
  - Exit criteria:

  ### Phase 4 - Cutover

  - Scope:
  - Preconditions:
  - Deliverables:
  - Validation:
  - Exit criteria:

  ### Phase 5 - Legacy Retirement

  - Scope:
  - Preconditions:
  - Deliverables:
  - Validation:
  - Exit criteria:

  ## Data Migration

  Define data ownership, transformation, synchronization, validation, cutover and
  rollback when applicable.

  TODO

  ## Integration Migration

  Define how external integrations will be preserved, adapted, replaced or removed.

  TODO

  ## Compatibility Strategy

  Define confirmed compatibility requirements and transition boundaries.

  TODO

  ## Validation Strategy

  Define how preserved behavior, migrated data, integrations, security,
  performance and operations will be validated.

  TODO

  ## Rollback Strategy

  Define rollback conditions, preserved artifacts and recovery steps when a
  rollback is required.

  TODO

  ## Cutover Criteria

  TODO

  ## Completion Criteria

  TODO

  ## Dependencies

  TODO

  ## Blocking Decisions

  None.

  ## Related Risks

  None.

  ## Related Tasks

  See migration-tasks.md.

  ## Rules

  - Do not define target architecture independently from 00-META.
  - Do not create migration phases from unconfirmed assumptions.
  - Do not combine unrelated feature development with migration work.
  - Preserve confirmed business behavior unless an explicit decision changes it.
  - Resolve blocking decisions before creating executable migration tasks.
  - Keep each phase reviewable and reversible when required.
EOF
}
write_legacy_migration_migration_tasks() {
  write_document "09-LEGACY/migration/migration-tasks.md" <<'EOF'
  # Migration Tasks

  ## Purpose

  Track migration-specific work derived from the confirmed migration plan.

  This document identifies migration work and its relationship with source code,
  target code, migration risks and project Kanban tasks.

  It does not replace the project Kanban.

  Confirmed implementation work must be tracked in:

  - ../../03-PRODUCT/kanban/TASKS.md

  ## Migration Work

  None.

  ## Task Format

  ### MIG-XXX - Task Title

  - phase:
  - scope:
  - sourcePaths:
  - targetPaths:
  - dependencies:
  - blockers:
  - preservedBehavior:
  - expectedResult:
  - validation:
  - rollback:
  - relatedRisks:
  - relatedDebts:
  - relatedDecision:
  - kanbanTask:

  ## Rules

  - Use stable MIG-XXX identifiers.
  - Create migration work only from confirmed migration scope.
  - One entry must represent one reviewable migration deliverable.
  - Do not create implementation work from unresolved arbitrations.
  - Do not use this document as a substitute for specifications.
  - Every implementation entry must reference its project Kanban task.
  - Track execution status only in ../../03-PRODUCT/kanban/TASKS.md.
  - Keep dependencies, blockers and validation criteria explicit.
  - Preserve completed migration entries for traceability.
EOF
}



###############################################################################
# MAIN
###############################################################################

main() {
  command -v clear >/dev/null 2>&1 && clear

  printf "${CYAN}${BOLD}"
  echo ""
  echo "========================================="
  echo "         PROJECT BOOTSTRAP"
  echo "========================================="
  printf "${RESET}\n"

  # Get arguments and prepare the project directory
  # --
  
  parse_args "$@"

  # CLI Interview
  # --

  if project_already_initialized; then
    confirm_existing_project_completion
    load_existing_project_profile
  else
  
    # Project Name
    interview__project_name

    # Frontend
    interview__frontend_stack
    interview__frontend_variant

    # Backend
    interview__backend_stack
    interview__backend_framework

    # Servers
    interview__server_targets
    interview__server_assets

    # Databases and Search Engines
    interview__databases
    interview__search_engines

    # Shell
    if [[ "$FRONTEND_STACK" != "none" ]]; then
      interview__shell_targets
    fi

    # Legacy
    interview__legacy_project

    # Summary
    interview__summary
    interview__confirm_generation
  fi

  # Project Profile 
  # --
  resolve_project_profile


  # Root
  # --
  write_root_documents

  # .github
  # --
  create_github_tree
  write_github_documents

  # 00-META
  # --
  create_meta_tree
  write_meta_documents

  # 01-FOUNDATION
  # --
  create_foundation_tree
  write_foundation_documents

  # 02-DESIGN
  # --
  create_design_tree
  write_design_documents

  # 03-PRODUCT
  # --
  create_product_tree
  write_product_documents

  # 04-ENGINEERING
  # --
  if [[ "$GENERATION_MODE" == "create" ]]; then
    create_engineering_tree
    write_engineering_documents
  fi

  # 05-LAB
  # --
  create_lab_tree
  write_lab_documents

  if [[ "$PROJECT_HAS_LEGACY" == "true" ]]; then
    create_legacy_tree
    write_legacy_documents
  fi
  

  # Output
  # --
  if [[ "$GENERATION_MODE" == "create" ]]; then
    cleanup_gitkeep_files
  fi

  print_success_message

  if [[ "$GENERATION_MODE" == "create" ]]; then
    confirm_launch_ai_prompt
  fi
}

main "$@"