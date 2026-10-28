---
name: new-decision
description: Registra uma decisão de arquitetura ou abordagem como ADR em docs/decisions/. Use quando o usuário chamar /new-decision.
disable-model-invocation: true
---

# Nova decisão

Decisão a registrar: $ARGUMENTS

1. Descubra o próximo número em docs/decisions/ (0001, 0002...).
2. Crie docs/decisions/NNNN-titulo-curto.md no formato de docs/decisions/README.md, com a data de hoje.
3. No Contexto, liste as opções que foram consideradas e por que as outras foram descartadas.
4. Se esta decisão substitui outra, edite só a linha "Status" da antiga para
   "substituída por NNNN". Não mude mais nada nela.
5. Se a decisão muda a estrutura do sistema, atualize docs/ARCHITECTURE.md.
6. Mostre o caminho do arquivo criado.
