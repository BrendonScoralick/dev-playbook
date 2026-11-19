# Tarefas: <NNN>-<funcionalidade>

Plano da Spec `specs/<NNN>-<funcionalidade>/spec.md`. Revisado e aprovado em PR junto com a Spec (ou em PR próprio).

**Regras**
- Cada tarefa vira uma **GitHub Issue**; a Issue é a **fonte do status**. Este arquivo só muda quando o **plano** muda.
- Toda tarefa cita os critérios (CA-xx) que atende. Critério sem tarefa = critério sem implementação.
- A primeira tarefa de cada fatia são os **testes Red**; código só depois.
- Tarefas pequenas: cada uma cabe num PR que você consegue explicar inteiro.

| # | Tarefa | Critérios | Depende de | Issue |
|---|---|---|---|---|
| T1 | Testes Red: <sucesso, negativos, permissão, abuso> | CA-01, CA-02, CA-03 | — | #<n> |
| T2 | <implementação mínima> | CA-01, CA-02 | T1 | #<n> |
| T3 | <tela / integração> | CA-01 | T2 | #<n> |

## Fora deste plano
- <o que fica para outra Spec>

## Mudanças no plano
| Data | Mudança | Por quê |
|---|---|---|
