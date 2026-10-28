---
name: new-project
description: Cria um projeto de software novo com a estrutura padrão (AGENTS.md, docs de estado, visão, requisitos e arquitetura, agentes, skills de handoff e tarefas, hook de início). Use quando o usuário chamar /new-project ou pedir para começar um projeto novo do zero.
disable-model-invocation: true
---

# Novo projeto

Pedido: $ARGUMENTS

O guia completo da estrutura (o que é cada pasta e cada documento) está em
`reference/GUIDE.md`, na pasta desta skill. Leia só se precisar explicar algo ao usuário.

## Passos

1. **Defina o caminho.** O argumento é o nome ou o caminho do projeto.
   - Só um nome (ex.: `meu-app`): crie dentro do diretório atual.
   - Sem argumento: pergunte o nome e onde criar.
   - Se a pasta já existe e não está vazia, pare e avise. Não sobrescreva nada.

2. **Gere a estrutura** rodando o script desta skill:
   ```
   bash "<pasta desta skill>/scripts/scaffold.sh" "<caminho do projeto>"
   ```
   A pasta desta skill é a que contém este SKILL.md.

3. **Pergunte ao usuário, numa mensagem só:**
   - O que é o projeto e para quem (uma ou duas frases).
   - A stack: linguagem, framework, banco, gerenciador de pacotes.
   - Se já tem os primeiros requisitos em mente.

4. **Preencha com as respostas**, sem inventar o que não foi dito:
   - `AGENTS.md`: a frase de abertura e a seção "Comandos" (instalar, rodar, testar, lint)
     de acordo com a stack. Mantenha abaixo de 200 linhas.
   - `docs/VISION.md`: problema, para quem, o que é. Deixe o resto com os marcadores.
   - `docs/ARCHITECTURE.md`: a seção Stack.
   - `docs/REQUIREMENTS.md`: os requisitos que o usuário deu, com IDs RF-001...
   - `.claude/settings.json`: acrescente em `permissions.allow` os comandos seguros da stack
     (testes, lint, typecheck; ex.: `"Bash(npm test *)"`) e em `permissions.deny` as pastas
     de dependências e build (ex.: `"Read(./node_modules/**)"`, `"Read(./dist/**)"`).
   - `.gitignore`: as pastas de dependências e build da stack.
   - `README.md`: a frase de abertura e os comandos de execução.

5. **Não** crie código em src/ nem a primeira tarefa. Isso é o próximo passo do usuário.

6. **Mostre ao usuário:**
   - o caminho do projeto criado;
   - como abrir: `cd <caminho>` e rodar `claude` dentro da pasta;
   - os comandos disponíveis: `/new-task`, `/new-decision`, `/new-prototype`, `/handoff`;
   - o fluxo: trabalhar na tarefa → `/handoff` → `/clear`.
