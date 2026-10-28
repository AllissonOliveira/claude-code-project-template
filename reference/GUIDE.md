# Template de projeto de software para Claude Code

Estrutura padrão para qualquer projeto de desenvolvimento (sistema, app, API, ferramenta). Os nomes de pastas e arquivos estão em inglês, por convenção. O conteúdo dos documentos pode ser em qualquer idioma.

---

## 1. Princípio

O contexto é o recurso caro. A janela enche rápido, o desempenho cai conforme ela enche, e o custo cresce com o tamanho do contexto. A estrutura existe para duas coisas:

1. Manter o contexto pequeno: cada informação tem um lugar, e o Claude só lê o que precisa.
2. Dar ao Claude formas de verificar o próprio trabalho.

A estrutura tem duas camadas:

- **Camada do Claude Code:** caminhos que o Claude Code reconhece e carrega sozinho.
- **Camada do projeto:** pastas e documentos que são convenção sua. O Claude só entende essa camada porque o `AGENTS.md` descreve o que tem em cada lugar.

---

## 2. Camada do Claude Code

| Caminho | Para que serve | Vai pro git |
| --- | --- | --- |
| `CLAUDE.md` (qualquer nível) | Instruções carregadas na sessão | Sim |
| `CLAUDE.local.md` | Notas pessoais, lidas depois do CLAUDE.md | Não |
| `.claude/settings.json` | Permissões, hooks, configuração | Sim |
| `.claude/settings.local.json` | Permissões pessoais | Não |
| `.claude/rules/*.md` | Instruções divididas em arquivos | Sim |
| `.claude/agents/*.md` | Subagentes | Sim |
| `.claude/skills/<nome>/SKILL.md` | Skills, carregadas sob demanda | Sim |
| `.claude/hooks/` | Scripts dos hooks (convenção; registrados no settings.json) | Sim |
| `.mcp.json` | Servidores MCP do projeto | Sim |

Como carrega:

- O Claude Code lê `CLAUDE.md`, não `AGENTS.md`. O CLAUDE.md contém a linha `@AGENTS.md`, que importa o arquivo.
- CLAUDE.md das pastas acima de onde a sessão é aberta: carregados inteiros no início.
- CLAUDE.md em subpastas: só quando o Claude lê arquivos daquela subpasta.
- A sessão é sempre aberta na raiz do projeto.

---

## 3. Estrutura completa

```
project-name/
├── AGENTS.md                 # regras, mapa das pastas, fluxo da sessão
├── CLAUDE.md                 # @AGENTS.md
├── README.md                 # para humanos: o que é e como rodar
├── CHANGELOG.md              # o que mudou, por versão
├── .gitignore
├── .env.example              # variáveis necessárias, sem valores reais
├── .mcp.json
│
├── docs/                     # o que o projeto é e onde ele está
│   ├── STATE.md              # ponto de controle: onde estamos agora
│   ├── VISION.md             # o porquê e o para quem
│   ├── REQUIREMENTS.md       # o quê: tudo que o sistema deve fazer
│   ├── ARCHITECTURE.md       # o como: componentes, stack, fluxos
│   ├── decisions/            # uma decisão importante por arquivo
│   ├── tasks/
│   │   ├── active/           # a tarefa em andamento
│   │   └── done/             # tarefas concluídas
│   └── research/             # relatórios de pesquisa
│
├── src/                      # o código do produto
├── tests/                    # testes automatizados
├── prototypes/               # experimentos descartáveis
├── scripts/                  # automações de desenvolvimento
├── references/               # material externo de consulta
├── deliverables/             # saídas geradas para pessoas (fora do git)
│
└── .claude/
    ├── settings.json
    ├── hooks/
    ├── rules/
    ├── agents/
    └── skills/
```

---

## 4. As pastas e o que cada uma guarda

| Pasta | O que guarda | Quem escreve | Regra |
| --- | --- | --- | --- |
| `docs/` | Documentos do projeto (seção 5) | Todos, só `.md` | Cada documento tem um objetivo e não repete os outros |
| `src/` | O código do produto, o que vai para produção | Construtor | Nada experimental aqui |
| `tests/` | Testes automatizados, espelhando a estrutura de `src/` | Construtor | Todo código novo em `src/` tem teste |
| `prototypes/` | Experimentos para responder uma pergunta (uma tela, uma técnica, uma integração) | Construtor | Uma subpasta por protótipo, com README; o `src/` nunca importa daqui; depois de concluído, fica congelado |
| `scripts/` | Setup, seed de banco, deploy, migrações, utilitários | Construtor | Cada script com uma linha explicando o que faz |
| `references/` | Material de fora: especificações, designs, exemplos, dados de amostra | Pessoa | Somente leitura; material grande fica fora do repo (seção 9) |
| `deliverables/` | Relatórios, imagens, exports, páginas geradas para pessoas | Todos | Fora do git; organizado por data (`YYYY-MM-DD/`) |

### Protótipos

Cada protótipo é uma subpasta com um `README.md` curto:

```markdown
# <nome do protótipo>

Pergunta: <o que este protótipo queria responder>
Resultado: <o que descobrimos>
Status: em andamento | concluído (congelado) | descartado
Virou: <link para a decisão ou requisito que saiu daqui, se houver>
```

---

## 5. Os documentos e o objetivo de cada um

Cada documento responde a uma pergunta diferente. Se uma informação cabe em dois, ela vai para o que muda menos e o outro aponta para ele.

| Documento | Pergunta que responde | Muda quando | Tamanho |
| --- | --- | --- | --- |
| `STATE.md` | Onde estamos agora e o que vem a seguir? | Toda sessão | Curto (até ~50 linhas) |
| `VISION.md` | Por que este projeto existe e para quem? | Raramente | 1 página |
| `REQUIREMENTS.md` | O que o sistema precisa fazer? | Quando o escopo muda | O necessário |
| `ARCHITECTURE.md` | Como o sistema está construído? | Quando a arquitetura muda | O necessário |
| `decisions/NNNN-*.md` | Por que escolhemos isso e não aquilo? | Nunca (nova decisão = novo arquivo) | Meia página cada |
| `tasks/active/*.md` | O que estou fazendo agora e como sei que terminei? | Durante a tarefa | Meia página |
| `research/*.md` | O que descobrimos investigando X? | Uma vez | Livre |
| `CHANGELOG.md` | O que mudou em cada versão? | A cada entrega | Uma linha por mudança |

Ordem de leitura numa sessão nova: `AGENTS.md` (automático) → `STATE.md` → a tarefa em `tasks/active/` → o resto só quando a tarefa pedir.

### STATE.md

O ponto de controle. É o que permite dar `/clear` sem perder nada.

```markdown
# Estado

Atualizado em: YYYY-MM-DD

## Fase atual
<em que etapa o projeto está>

## Última sessão
- <o que foi feito>

## Próximos passos
1. <...>

## Bloqueios e dúvidas abertas
- <...>
```

### VISION.md

O norte. Serve para decidir o que entra e o que não entra.

```markdown
# Visão

## Problema
<que dor isto resolve>

## Para quem
<usuários e contexto de uso>

## O que é
<o produto em um parágrafo>

## Como medimos sucesso
- <métrica ou resultado observável>

## Fora do escopo
- <o que este projeto não vai fazer>
```

### REQUIREMENTS.md

A lista do que o sistema precisa fazer, numerada para poder ser citada nas tarefas e nos testes.

```markdown
# Requisitos

## Funcionais
| ID | Requisito | Prioridade | Status |
| --- | --- | --- | --- |
| RF-001 | <o sistema deve...> | Alta | Pendente |

## Não funcionais
| ID | Requisito | Status |
| --- | --- | --- |
| RNF-001 | <desempenho, segurança, acessibilidade...> | Pendente |
```

Status possíveis: Pendente, Em andamento, Feito, Descartado.

### ARCHITECTURE.md

Como as peças se encaixam. Não descreve arquivo por arquivo; o Claude descobre isso lendo o código.

```markdown
# Arquitetura

## Stack
- <linguagem, framework, banco, hospedagem>

## Componentes
| Componente | Responsabilidade | Onde está |
| --- | --- | --- |
| <api> | <...> | src/api/ |

## Fluxos principais
<como uma requisição ou dado percorre o sistema>

## Integrações externas
- <serviço>: <para quê>
```

### decisions/NNNN-titulo.md

Registro de decisão (ADR). Numerado em sequência, nunca editado depois; se a decisão mudar, cria-se uma nova que substitui a anterior.

```markdown
# NNNN. <Título da decisão>

Data: YYYY-MM-DD
Status: aceita | substituída por NNNN

## Contexto
<o problema e as opções consideradas>

## Decisão
<o que foi escolhido>

## Consequências
<o que isso facilita, o que dificulta>
```

### tasks/active/NNN-titulo.md

Uma tarefa por arquivo, só uma ativa por vez. Ao concluir, vai para `tasks/done/`.

```markdown
# NNN. <Título da tarefa>

Requisitos: RF-001, RF-002

## Objetivo
<o que deve existir ao final>

## Escopo
- <o que entra>

## Fora do escopo
- <o que não mexer>

## Critérios de pronto
- [ ] <condição verificável>

## Verificação
<comando que prova que está pronto, ex.: npm test -- auth>

## Diário

### YYYY-MM-DD
- Tentado: <...> | Resultado: <...>
- Descoberta: <...>
- Decidido: <...> (motivo: <...>)
```

O Diário guarda a inteligência da sessão: tentativas descartadas, armadilhas e descobertas. É preenchido durante o trabalho, na hora em que acontece, e completado pelo `/handoff`.

### research/AAAA-MM-DD-tema.md

Relatórios do agente pesquisador. Ficam fora do AGENTS.md e só são lidos quando a tarefa precisa.

---

## 6. AGENTS.md e CLAUDE.md

**Tamanho:** abaixo de 200 linhas, porque carrega inteiro em toda sessão. Teste para cada linha: *"tirar isto faria o Claude errar?"* Se não, corte.

| Incluir | Excluir |
| --- | --- |
| Comandos que o Claude não adivinha | O que dá para descobrir lendo o código |
| Estilo que difere do padrão | Convenções que ele já conhece |
| Como rodar os testes | Documentação detalhada de API |
| Convenções do repo (branch, PR) | Informação que muda com frequência (vai no STATE.md) |
| Mapa das pastas e documentos | Explicações longas e tutoriais |
| Armadilhas não óbvias | "Escreva código limpo" e afins |

### Modelo de AGENTS.md

```markdown
# <Nome do projeto>

<uma frase sobre o que é; detalhes em docs/VISION.md>

## Mapa
| Caminho | O que tem | Pode editar |
| --- | --- | --- |
| docs/STATE.md | onde estamos | sim, ao fim da sessão |
| docs/VISION.md | porquê e para quem | só com pedido explícito |
| docs/REQUIREMENTS.md | o que fazer, com IDs | sim, ao mudar escopo |
| docs/ARCHITECTURE.md | como está construído | sim, ao mudar arquitetura |
| docs/decisions/ | decisões registradas | só criar novas |
| docs/tasks/active/ | tarefa em andamento | sim |
| src/ | código do produto | sim |
| tests/ | testes | sim |
| prototypes/ | experimentos | só o protótipo em andamento |
| references/ | material externo | não |
| deliverables/ | saídas para pessoas | sim |

## Comandos
- instalar: <...>
- rodar: <...>
- testar: <...>
- lint / typecheck: <...>

## Convenções
- <...>

## Fluxo da sessão
1. Ler docs/STATE.md e a tarefa em docs/tasks/active/ (o hook de início já carrega os dois).
2. Trabalhar só no escopo da tarefa.
3. Ao descobrir algo não óbvio, descartar uma abordagem ou tomar uma decisão, registrar na hora na seção "Diário" da tarefa ativa. Não deixar para o fim.
4. Rodar a verificação da tarefa e mostrar a saída antes de dizer que terminou.
5. Antes de /clear ou de trocar de conta, o usuário roda /handoff.

## Nunca
- Editar references/, tarefas concluídas ou protótipos congelados.
- Colocar segredos em código; usar .env (modelo em .env.example).
- Fazer commit sem pedido.

## Ao compactar
Preserve a tarefa em andamento, os arquivos alterados, as tentativas descartadas e os comandos de teste.
```

### CLAUDE.md

```markdown
@AGENTS.md
```

### Rules (`.claude/rules/`)

Para instruções que valem só em certas pastas, com `paths` no frontmatter. Sem `paths`, a rule carrega sempre.

```markdown
---
paths:
  - "src/api/**"
---
# Regras da API
- <...>
```

Use `paths` só no `.claude/rules/` do projeto (há bugs relatados na pasta do usuário) e confirme com `/memory`.

Quando `src/` crescer, um `CLAUDE.md` dentro de cada módulo grande (ex.: `src/api/CLAUDE.md`) também funciona: só carrega quando o Claude trabalha ali.

---

## 7. settings.json: permissões e hooks

### Permissões

- `allow` para comandos seguros e frequentes: menos interrupções, tarefas longas rodam sozinhas.
- `deny` de Read para o que é pesado ou sensível.
- `deny` de Read/Edit vale para as ferramentas de arquivo do Claude, não para comandos Bash. Economiza contexto, mas não é trava. Para bloquear de verdade, use um hook ou o sandbox.

```json
{
  "permissions": {
    "allow": [
      "Bash(npm test *)",
      "Bash(npm run lint *)",
      "Bash(git status)",
      "Bash(git diff *)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./node_modules/**)",
      "Read(./dist/**)",
      "Edit(./references/**)"
    ]
  }
}
```

(Ajuste os comandos para a stack do projeto.)

### Hooks

Hooks são determinísticos: garantem que a ação aconteça. Instruções no AGENTS.md são orientação. O que precisa acontecer sempre, sem exceção, vira hook.

| Hook | Evento | Para quê |
| --- | --- | --- |
| Guarda | PreToolUse | Bloquear segredos, pastas protegidas, comandos perigosos |
| Lint/format | PostToolUse (Edit/Write) | Formatar e checar a cada edição |
| Filtro de testes | PreToolUse (Bash) | Devolver só as falhas, não a saída inteira |
| Verificação final | Stop | Impedir o turno de terminar sem os testes passarem |
| Início de sessão | SessionStart (`startup\|resume\|clear\|compact`) | Injetar o STATE.md e a tarefa ativa no contexto de toda sessão nova |

---

## 8. Agentes e skills

### Subagentes (`.claude/agents/`)

Rodam em contexto próprio e devolvem só o resumo. Fixe o `model` em cada um: se a sessão for trocada para Opus, os agentes que herdam o modelo também passam a usar Opus.

| Agente | Modelo | Ferramentas | Papel | Escreve em |
| --- | --- | --- | --- | --- |
| researcher | haiku ou sonnet | Read, Grep, Glob, WebFetch, WebSearch | Investigar e trazer só a conclusão | docs/research/ |
| builder | sonnet | todas | Implementar a tarefa ativa | src/, tests/, prototypes/ |
| reviewer | sonnet ou opus | Read, Grep, Glob, Bash | Revisar o diff contra a tarefa | nada (só relata) |

```markdown
---
name: reviewer
description: Revisa o diff da tarefa ativa contra docs/tasks/active/ e roda a verificação.
tools: Read, Grep, Glob, Bash
model: sonnet
---
Revise apenas o diff. Verifique se cada critério de pronto da tarefa foi atendido,
se os casos listados têm teste e se nada fora do escopo mudou.
Aponte só lacunas que afetem correção ou requisitos. Estilo é opcional.
```

### Skills (`.claude/skills/`)

Uma pasta por skill, com `SKILL.md`. Só carregam quando usadas: é para onde vão os fluxos que incham o AGENTS.md. Para fluxos com efeitos colaterais, use `disable-model-invocation: true`.

| Skill | O que faz |
| --- | --- |
| `new-task` | Cria o arquivo em docs/tasks/active/ com objetivo, escopo, critérios e verificação, ligado aos IDs de requisito |
| `handoff` | Antes de `/clear` ou de trocar de conta: completa o Diário, registra decisões, fecha a tarefa se terminou e reescreve o STATE.md |
| `new-decision` | Cria o próximo arquivo em docs/decisions/ no formato ADR |
| `new-prototype` | Cria a subpasta em prototypes/ com o README de pergunta e resultado |

---

## 9. Material fora do repositório

Material grande ou privado (acervos, dados brutos, históricos de conversa) fica fora da pasta do projeto. Para o Claude alcançar numa sessão: `--add-dir <caminho>`; para sempre: `additionalDirectories` no `settings.json`. Não coloque CLAUDE.md numa pasta-mãe que agrupa vários projetos: ele seria carregado em todos.

### .gitignore mínimo

```
deliverables/
.env
.claude/worktrees/
.claude/settings.local.json
CLAUDE.local.md
```

---

## 10. Hábitos de sessão

1. **`/handoff` + `/clear` em vez de `/compact`.** O handoff grava a sessão nos arquivos, o `/clear` não custa nada, e o hook de início recarrega o estado. O `/compact` fica só para quando é preciso continuidade na mesma conversa.
2. **Duas correções sem sucesso → `/clear`** e recomece com um prompt melhor.
3. **Plan mode** para mudanças grandes ou incertas. Pule quando der para descrever a mudança em uma frase.
4. **Funcionalidade grande:** peça para o Claude te entrevistar e escrever a tarefa; execute numa sessão nova.
5. **Exploração ampla vai para o researcher.**
6. **Prompts específicos:** arquivo, cenário, critério de pronto.
7. **Exija evidência:** a saída do teste ou o comando rodado, não "está funcionando".
8. **Modelo:** Sonnet no dia a dia; Opus para arquitetura e raciocínio complexo; `/effort` mais baixo em tarefas simples.
9. **Prefira CLI a MCP** quando existir (`gh`, `aws`). Desative servidores MCP que não usa com `/mcp`.
10. **Linguagem tipada:** instale um plugin de inteligência de código.

| Comando | Para quê |
| --- | --- |
| `/context` | Ver o que ocupa a janela e confirmar que o AGENTS.md carregou |
| `/memory` | Ver arquivos de memória e rules ativos |
| `/usage` | Ver consumo por skill, agente e MCP, com recomendações |
| `/doctor` | Sugerir cortes no CLAUDE.md |
| `/compact <foco>` | Compactar mantendo o que importa |
| `/rename` + `/resume` | Nomear sessões e voltar a elas |

---

## 11. Continuidade entre sessões e contas

A conversa é descartável; a memória do projeto mora nos arquivos. Compactar é um resumo que o próprio modelo faz, e resumo sempre perde nuance. Por isso o fluxo não depende de `/compact`.

### Onde fica cada tipo de "inteligência"

| O que se perde numa sessão | Onde registrar |
| --- | --- |
| Onde paramos e o que vem a seguir | `docs/STATE.md` |
| Por que escolhemos X e não Y | `docs/decisions/` |
| O que foi tentado e falhou, armadilhas, descobertas | Seção "Diário" da tarefa ativa |

### O ciclo

1. **Início:** o hook SessionStart injeta o `STATE.md` e a tarefa ativa no contexto. Ele dispara em `startup`, `resume`, `clear` e `compact`.
2. **Durante:** descobertas e decisões vão para o Diário na hora em que acontecem. Se a sessão travar, perde-se no máximo os últimos minutos.
3. **Fim da tarefa, sessão travada ou troca de conta:** rodar `/handoff`. Ele completa o Diário, registra decisões, fecha a tarefa se terminou e reescreve o `STATE.md`.
4. **Recomeço:** `/clear` (ou abrir a outra conta). O hook recarrega o estado.

### Hook de início

`.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume|clear|compact",
        "hooks": [
          { "type": "command", "command": "bash \"$CLAUDE_PROJECT_DIR/.claude/hooks/session-start.sh\"" }
        ]
      }
    ]
  }
}
```

O script `.claude/hooks/session-start.sh` imprime o conteúdo do `STATE.md` e da tarefa ativa. O hook injeta o conteúdo, e não uma frase pedindo para ler, porque pedidos do tipo "leia o arquivo X" nem sempre são seguidos.

O hook PreCompact só roda comandos de terminal: ele não consegue fazer o Claude escrever o resumo antes de compactar. Por isso a passagem de bastão é o `/handoff`, chamado por você.

### Skill handoff

`.claude/skills/handoff/SKILL.md`, com `disable-model-invocation: true` (só roda quando chamada). Passos:

1. Revisar a sessão: feito, decidido, descartado, descobertas, pendências, arquivos alterados (`git status`, `git diff --stat`).
2. Acrescentar uma entrada datada no Diário da tarefa ativa.
3. Criar ADRs para decisões que valem além da tarefa.
4. Marcar critérios atendidos; se a tarefa terminou, rodar a verificação, mover para `done/`, registrar no `CHANGELOG.md` e atualizar os requisitos.
5. Reescrever o `STATE.md` (até ~50 linhas).
6. Atualizar `ARCHITECTURE.md` ou `AGENTS.md` só se mudaram de fato.
7. Mostrar o que foi atualizado e o próximo passo, sem fazer commit.

### Duas contas no mesmo projeto

Cada conta com sua própria pasta de configuração (`CLAUDE_CONFIG_DIR`) é um ambiente separado: memória automática, histórico de sessões, skills e configurações do usuário não são compartilhados. O que está no repositório, as duas contas leem igual.

Regra: tudo que importa fica no projeto, nada no nível do usuário.

- Skills, agentes e hooks do projeto ficam em `.claude/` do projeto, não em `~/.claude/`.
- A memória automática (`~/.claude/projects/<projeto>/memory/`) não serve como ponte entre contas.
- Skills pessoais usadas nas duas contas (como uma que cria projetos novos) ficam numa pasta única, com um link simbólico na pasta `skills/` de cada conta.

Troca de conta: `/handoff` na conta A → abrir a conta B na mesma pasta → o hook carrega o estado → continuar.
