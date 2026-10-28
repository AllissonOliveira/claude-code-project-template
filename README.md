# Claude Code Project Template

Skill `/new-project` para o Claude Code: cria um projeto de software novo (sistema, app, API, ferramenta) com uma estrutura padrão de pastas, documentos, agentes, skills e hooks, pronta para trabalhar com o Claude desde a primeira sessão.

## Por que esta estrutura

O contexto é o recurso caro. A janela enche rápido, o desempenho cai conforme ela enche, e o custo cresce com o tamanho do contexto. A estrutura existe para duas coisas:

1. **Manter o contexto pequeno:** cada informação tem um lugar, e o Claude só lê o que precisa.
2. **Dar ao Claude formas de verificar o próprio trabalho:** toda tarefa tem critérios de pronto e um comando de verificação.

E parte de uma regra: **a conversa é descartável; a memória do projeto mora nos arquivos.** Por isso o fluxo usa `/handoff` + `/clear` em vez de depender do `/compact`.

## O que o projeto gerado traz

```
nome-do-projeto/
├── AGENTS.md                 # regras, mapa das pastas, fluxo da sessão
├── CLAUDE.md                 # só importa o AGENTS.md (@AGENTS.md)
├── README.md                 # para humanos: o que é e como rodar
├── CHANGELOG.md
├── .env.example              # variáveis necessárias, sem valores reais
├── .mcp.json
│
├── docs/
│   ├── STATE.md              # onde estamos agora e o que vem a seguir
│   ├── VISION.md             # o porquê e o para quem
│   ├── REQUIREMENTS.md       # o quê, com IDs (RF-001...)
│   ├── ARCHITECTURE.md       # o como: stack, componentes, fluxos
│   ├── decisions/            # uma decisão por arquivo (ADR)
│   ├── tasks/active/ e done/ # uma tarefa por arquivo, com Diário
│   └── research/             # relatórios de pesquisa
│
├── src/  tests/  prototypes/  scripts/  references/  deliverables/
│
└── .claude/
    ├── settings.json         # permissões básicas + hook de início
    ├── hooks/session-start.sh
    ├── agents/               # researcher, builder, reviewer
    └── skills/               # handoff, new-task, new-decision, new-prototype
```

Cada documento responde a uma pergunta diferente e não repete os outros:

| Documento | Pergunta que responde |
| --- | --- |
| `STATE.md` | Onde estamos agora e o que vem a seguir? |
| `VISION.md` | Por que este projeto existe e para quem? |
| `REQUIREMENTS.md` | O que o sistema precisa fazer? |
| `ARCHITECTURE.md` | Como o sistema está construído? |
| `decisions/` | Por que escolhemos isso e não aquilo? |
| `tasks/active/` | O que estou fazendo agora e como sei que terminei? |

### Skills do projeto

| Comando | O que faz |
| --- | --- |
| `/new-task` | Cria a tarefa em `docs/tasks/active/` com objetivo, escopo, critérios de pronto e verificação |
| `/handoff` | Completa o Diário da tarefa, registra decisões, fecha a tarefa se terminou e reescreve o `STATE.md` |
| `/new-decision` | Cria o próximo registro de decisão em `docs/decisions/` |
| `/new-prototype` | Cria uma subpasta em `prototypes/` com a pergunta que o protótipo quer responder |

### Agentes

| Agente | Papel |
| --- | --- |
| `researcher` | Investiga e traz só a conclusão, em `docs/research/` |
| `builder` | Implementa a tarefa ativa em `src/`, `tests/` e `prototypes/` |
| `reviewer` | Revisa o diff contra a tarefa e roda a verificação; não edita nada |

## Como funciona a continuidade

| O que se perde numa sessão | Onde fica registrado |
| --- | --- |
| Onde paramos e o que vem a seguir | `docs/STATE.md` |
| Por que escolhemos X e não Y | `docs/decisions/` |
| O que foi tentado e falhou, armadilhas, descobertas | Seção "Diário" da tarefa ativa |

1. **Início:** o hook `SessionStart` injeta o `STATE.md` e a tarefa ativa no contexto (em `startup`, `resume`, `clear` e `compact`).
2. **Durante:** descobertas e decisões vão para o Diário na hora em que acontecem.
3. **Fim da tarefa, sessão travada ou troca de conta:** você roda `/handoff`.
4. **Recomeço:** `/clear`, e o hook recarrega o estado.

## Instalação

1. Clone numa pasta fixa:
   ```
   mkdir -p ~/claude-skills
   git clone https://github.com/AllissonOliveira/claude-code-project-template.git ~/claude-skills/new-project
   ```

2. Crie o link na pasta de skills do Claude Code:
   ```
   mkdir -p ~/.claude/skills
   ln -s ~/claude-skills/new-project ~/.claude/skills/new-project
   ```

3. Abra uma sessão nova e confira se `/new-project` aparece.

**Usa duas contas do Claude Code?** Se a segunda conta tem a própria pasta de configuração (`CLAUDE_CONFIG_DIR`), crie um link nela também, sem duplicar a skill:

```
mkdir -p <pasta-da-conta-2>/skills
ln -s ~/claude-skills/new-project <pasta-da-conta-2>/skills/new-project
```

**Atualizar:** `git -C ~/claude-skills/new-project pull`.

## Uso

Na pasta onde ficam seus projetos, abra o Claude e rode:

```
/new-project nome-do-projeto
```

A skill cria a estrutura, pergunta o que é o projeto e qual a stack, e preenche `AGENTS.md`, `VISION.md`, `ARCHITECTURE.md`, `REQUIREMENTS.md` e as permissões. Depois:

```
cd nome-do-projeto
claude
/new-task <primeira tarefa>
```

As skills do projeto (`/handoff` e as outras) ficam em `.claude/skills/` do próprio projeto, então funcionam em qualquer conta sem instalar nada.

O script também roda sem o Claude:

```
bash ~/claude-skills/new-project/scripts/scaffold.sh ~/Projetos/nome-do-projeto
```

## Fluxo de trabalho

1. A sessão começa e o hook carrega o `STATE.md` e a tarefa ativa.
2. Você trabalha na tarefa; descobertas vão na hora para o Diário.
3. `/handoff` ao terminar a tarefa, quando a sessão travar ou antes de trocar de conta.
4. `/clear` (ou abre a outra conta) e continua.

## Conteúdo deste repositório

```
├── SKILL.md              # instruções da skill /new-project
├── README.md             # este arquivo
├── scripts/scaffold.sh   # copia o template e troca nome e data
├── reference/GUIDE.md    # guia completo da estrutura
└── template/             # o projeto modelo
```

O guia completo (modelos de cada documento, permissões, hooks, hábitos de sessão) está em [`reference/GUIDE.md`](reference/GUIDE.md).
