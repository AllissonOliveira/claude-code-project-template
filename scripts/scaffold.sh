#!/usr/bin/env bash
# Cria um projeto novo a partir do template desta skill.
# Uso: scaffold.sh <caminho-do-projeto>
# Exemplo: scaffold.sh ~/Projetos/meu-app

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Uso: scaffold.sh <caminho-do-projeto>" >&2
  exit 1
fi

TARGET="$1"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$SKILL_DIR/template"

if [ -e "$TARGET" ] && [ -n "$(ls -A "$TARGET" 2>/dev/null)" ]; then
  echo "Erro: $TARGET já existe e não está vazio. Nada foi alterado." >&2
  exit 1
fi

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"
export PNAME="$(basename "$TARGET")"
export PDATE="$(date +%Y-%m-%d)"

cp -R "$TEMPLATE/." "$TARGET/"

# Troca {{PROJECT_NAME}} e {{DATE}} nos arquivos do template.
# perl -pi funciona igual em macOS e Linux; os valores vêm por variável de ambiente.
find "$TARGET" -type f -not -path '*/.git/*' -exec \
  perl -pi -e 's/\{\{PROJECT_NAME\}\}/$ENV{PNAME}/g; s/\{\{DATE\}\}/$ENV{PDATE}/g' {} +

chmod +x "$TARGET/.claude/hooks/"*.sh 2>/dev/null || true

if command -v git >/dev/null 2>&1 && [ ! -d "$TARGET/.git" ]; then
  git -C "$TARGET" init -q
  echo "Repositório git iniciado."
fi

echo "Projeto criado em: $TARGET"
echo "Nome: $PNAME | Data: $PDATE"
