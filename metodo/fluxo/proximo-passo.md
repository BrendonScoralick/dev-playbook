# Próximo passo

Tabela de decisão para saber o que fazer agora. A IA a usa no início de cada sessão, junto com `docs/estado.md` e as Issues abertas do sistema. Avalie de cima para baixo: o primeiro "se" verdadeiro decide.

| Se… | Próximo passo |
|---|---|
| Não há `docs/estado.md` | Criar a partir de `metodo/modelos/estado-do-sistema.md` e seguir `metodo/checklists/inicio-de-sistema.md` |
| Há um **incidente em produção** | **Conter** primeiro; depois Issue de bug, Spec, teste Red e correção |
| Há um PR aberto aguardando revisão ou com comentários | Revisar ou responder o PR antes de começar outra coisa |
| Não há PRD nem protótipo | Escolher a rota (`metodo/fluxo/ciclo.md`): **B** (habitual) = escrever o brief e prototipar no Claude Design; **A** = escrever o PRD |
| Rota B: protótipo pronto, sem PRD | Pedir ao Claude Design o PRD + inventário + desvios (`metodo/modelos/prompt-design.md`); revisar problema, hipótese e métricas; `/grill-me` |
| Rota A: sem PRD aprovado | Escrever o PRD (`metodo/modelos/prd.md`) e rodar `/grill-me` |
| Rota A: PRD aprovado, sem protótipo | Rodar o prompt de design (`metodo/modelos/prompt-design.md`) |
| Protótipo pronto, desvios não aprovados | Salvar o handoff e levar os desvios ao responsável |
| Sem modelagem de dados revisada | Fazer a modelagem (diagrama ou schema) |
| Sem threat model | Escrever o threat model (`metodo/modelos/threat-model.md`) |
| Spec da próxima fatia não existe ou não foi aprovada | Escrever a Spec, rodar `/grill-with-docs`, abrir PR só da Spec |
| Spec aprovada sem `tarefas.md` | Planejar as tarefas e abrir uma Issue por tarefa |
| Há tarefa em andamento | Seguir o ritmo: plano → Red → Green → relatório → revisão |
| Há tarefa aberta e nenhuma em andamento | Pegar a próxima tarefa do `tarefas.md` (respeitando dependências) |
| Todas as tarefas da Spec concluídas | Fazer a retro (`metodo/modelos/retro.md`) e escolher a próxima Spec |
| Primeiro release se aproximando | Auditoria de segurança (S-31) e plano de volta de versão |
| Sistema no ar, sem nada pendente | Operação: monitorar, ler feedback, transformar em Issues |
| Manutenção trimestral vencida | `metodo/checklists/manutencao-do-playbook.md` no dev-playbook |
