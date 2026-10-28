#!/usr/bin/env bash
# Carrega o estado do projeto no início de toda sessão (startup, resume, clear, compact).
# O que este script imprime entra no contexto do Claude.

ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

echo "=== Contexto do projeto (carregado automaticamente) ==="

if [ -f "$ROOT/docs/STATE.md" ]; then
  echo
  echo "--- docs/STATE.md ---"
  cat "$ROOT/docs/STATE.md"
fi

found=0
for f in "$ROOT"/docs/tasks/active/*.md; do
  [ -e "$f" ] || continue
  found=1
  echo
  echo "--- tarefa ativa: ${f#$ROOT/} ---"
  cat "$f"
done

if [ "$found" -eq 0 ]; then
  echo
  echo "--- Nenhuma tarefa ativa em docs/tasks/active/. Sugira criar uma com /new-task. ---"
fi

exit 0
