---
name: new-task
description: Cria a próxima tarefa em docs/tasks/active/ no formato do projeto, ligada aos requisitos. Use quando o usuário chamar /new-task.
disable-model-invocation: true
---

# Nova tarefa

Pedido do usuário: $ARGUMENTS

1. Se já existe um arquivo em docs/tasks/active/ (fora o .gitkeep), avise o usuário e
   pergunte se a tarefa atual deve ser concluída (via /handoff) antes. Não crie duas ativas.
2. Leia docs/REQUIREMENTS.md e identifique os IDs ligados ao pedido.
   Se o pedido traz um requisito novo, proponha a linha para o REQUIREMENTS.md.
3. Descubra o próximo número olhando docs/tasks/active/ e docs/tasks/done/ (001, 002...).
4. Crie docs/tasks/active/NNN-titulo-curto.md exatamente no formato de docs/tasks/README.md,
   com o Diário vazio (só o título da seção).
5. Os critérios de pronto precisam ser verificáveis, e a seção "Verificação" precisa ter
   um comando que rode de verdade. Se não souber o comando, pergunte.
6. Mostre a tarefa ao usuário e peça confirmação do escopo antes de começar a implementar.
