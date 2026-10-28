# Tarefas

Uma tarefa por arquivo, só uma em `active/` por vez. Ao concluir, vai para `done/`.
Numeração em sequência: `001-titulo-curto.md`. Use /new-task para criar no formato certo.

A seção "Diário" é onde fica a inteligência da sessão: tentativas descartadas, armadilhas,
descobertas. Ela é preenchida durante o trabalho e completada pelo /handoff.

## Formato

```markdown
# NNN. <Título da tarefa>

Requisitos: RF-001, RF-002
Criada em: YYYY-MM-DD

## Objetivo
<O que deve existir ao final.>

## Escopo
- <O que entra.>

## Fora do escopo
- <O que não mexer.>

## Critérios de pronto
- [ ] <Condição verificável.>

## Verificação
<Comando que prova que está pronto.>

## Diário

### YYYY-MM-DD
- Tentado: <...> | Resultado: <...>
- Descoberta: <...>
- Decidido: <...> (motivo: <...>)
```
