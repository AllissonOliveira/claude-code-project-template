---
name: new-prototype
description: Cria um protótipo em prototypes/ com o README de pergunta e resultado. Use quando o usuário chamar /new-prototype.
disable-model-invocation: true
---

# Novo protótipo

Pergunta que o protótipo deve responder: $ARGUMENTS

1. Escolha um nome curto em kebab-case e crie prototypes/<nome>/.
2. Crie prototypes/<nome>/README.md no formato de prototypes/README.md, com
   Status "em andamento" e Resultado vazio.
3. Se a pergunta não estiver clara, pergunte ao usuário antes de criar.
4. Lembre: o código do protótipo nunca é importado por src/.
5. Quando o protótipo terminar, preencha "Resultado" e "Virou", mude o Status para
   "concluído (congelado)" e, se saiu uma decisão, sugira /new-decision.
