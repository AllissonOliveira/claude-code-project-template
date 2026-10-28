# {{PROJECT_NAME}}

<Uma frase sobre o que é. Detalhes em docs/VISION.md.>

## Mapa

| Caminho | O que tem | Pode editar |
| --- | --- | --- |
| docs/STATE.md | onde estamos agora | sim, ao fim da sessão (via /handoff) |
| docs/VISION.md | porquê e para quem | só com pedido explícito |
| docs/REQUIREMENTS.md | o que o sistema faz, com IDs | sim, ao mudar escopo |
| docs/ARCHITECTURE.md | como está construído | sim, ao mudar arquitetura |
| docs/decisions/ | decisões registradas (ADR) | só criar novas |
| docs/tasks/active/ | a tarefa em andamento | sim |
| docs/tasks/done/ | tarefas concluídas | não |
| docs/research/ | relatórios de pesquisa | só criar novos |
| src/ | código do produto | sim |
| tests/ | testes automatizados | sim |
| prototypes/ | experimentos | só o protótipo em andamento |
| scripts/ | automações de desenvolvimento | sim |
| references/ | material externo | não |
| deliverables/ | saídas para pessoas (fora do git) | sim |

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
