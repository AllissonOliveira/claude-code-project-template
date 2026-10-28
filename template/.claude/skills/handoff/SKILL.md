---
name: handoff
description: Registra o estado da sessão nos documentos do projeto antes de um /clear, do fim de uma tarefa ou da troca de conta. Use só quando o usuário chamar /handoff.
disable-model-invocation: true
---

# Passagem de bastão

Objetivo: tudo que foi aprendido nesta sessão precisa estar nos arquivos do projeto,
para que uma sessão nova (nesta ou em outra conta) continue sem perder nada.
A conversa vai ser apagada depois disto. O que não estiver escrito se perde.

Contexto adicional do usuário (opcional): $ARGUMENTS

## Passos

1. **Revise a sessão.** Liste para você mesmo:
   - o que foi feito;
   - o que foi decidido e por quê;
   - o que foi tentado e descartado, e por quê;
   - descobertas não óbvias sobre o código, as ferramentas ou o ambiente;
   - o que ficou pela metade;
   - os arquivos alterados (confira com `git status` e `git diff --stat`).

2. **Atualize o Diário da tarefa ativa** (`docs/tasks/active/*.md`, seção `## Diário`).
   Acrescente, sem apagar o que já existe, uma entrada com a data de hoje:
   tentativas descartadas, armadilhas e descobertas. Seja concreto: nomes de arquivos,
   comandos, mensagens de erro.

3. **Registre decisões.** Para cada decisão de arquitetura ou de abordagem que vale
   além desta tarefa, crie o próximo arquivo em `docs/decisions/` no formato do projeto.
   Decisões pequenas ficam só no Diário.

4. **Atualize os critérios da tarefa.** Marque os critérios de pronto já atendidos.
   Se a tarefa terminou, rode a verificação dela e:
   - mova o arquivo para `docs/tasks/done/`;
   - acrescente a mudança no `CHANGELOG.md`;
   - atualize o status dos requisitos correspondentes em `docs/REQUIREMENTS.md`.

5. **Reescreva o `docs/STATE.md`** (este é substituído, não acumulado):
   - data de hoje;
   - fase atual;
   - última sessão: o que foi feito, em poucos itens;
   - próximos passos, numerados, começando pelo que retomar primeiro;
   - bloqueios e dúvidas abertas.
   Mantenha abaixo de ~50 linhas. Detalhe vai no Diário, não aqui.

6. **Atualize outros documentos só se mudaram de fato:**
   `docs/ARCHITECTURE.md` se a estrutura do sistema mudou;
   `AGENTS.md` só se surgiu uma regra que vale para toda sessão (e mantenha-o curto).

## Ao terminar

Mostre ao usuário, em poucas linhas:
- quais arquivos foram atualizados;
- o primeiro próximo passo registrado no STATE.md;
- qualquer coisa que você não soube onde registrar.

Não faça commit, a menos que o usuário peça.
Termine dizendo que está pronto para o `/clear`.
