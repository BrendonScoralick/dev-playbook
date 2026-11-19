# O ciclo

É uma combinação de práticas consolidadas (Spec-Driven Development, TDD, segurança desde o início, práticas de SRE), **não um padrão oficial**. A Spec versionada no repositório é a fonte da verdade.

```
Rota B (habitual):  Brief → Protótipo + handoff → PRD (gerado e revisado) ─┐
Rota A:             PRD → Discovery → Protótipo + handoff ─────────────────┤
                                                                           ↓
     Spec + threat model → Plano (Issues) → Red (testes) → Green + Refactor
       → PR + CI → Release → Operação → Feedback
                                           ↓
                                    nova Spec (o ciclo fecha)
```

| Fase | Pergunta | Gate (o que precisa estar aprovado para seguir) |
|---|---|---|
| Brief (rota B) | Qual problema, para quem, como medir, o que fica fora? | Cinco linhas preenchidas |
| Protótipo + handoff | Como parece e se usa? Todos os estados? | Telas e inventário aprovados; handoff salvo no repositório (somente leitura) |
| PRD | Por que, para quem, como medir? | Problema, escopo, métricas e **desvios em relação ao brief** aprovados |
| Discovery (rota A) | O problema é real? | Hipótese confirmada (na rota B, o protótipo faz esse papel) |
| Spec + threat model | O que exatamente, e o que pode dar errado? | **PR só da Spec** aprovado pelo responsável |
| Plano | Em que ordem? | `tarefas.md` aprovado (ao lado da Spec); uma Issue por tarefa, ligada a critérios; a primeira tarefa é o Red |
| Red | Os testes falham pelo motivo certo? | Testes revisados, em PR rascunho |
| Green + Refactor | Código mínimo, depois limpo | Nenhum teste alterado para passar |
| PR + CI | Atende à Spec? CI verde? | CI verde + aprovação (o autor não aprova o próprio PR) |
| Release | Como chega à produção? | Squash and merge; saber voltar a versão |
| Operação | Está funcionando? | Em incidente: **conter primeiro**, investigar depois |
| Feedback | O que aprendemos? | Retro (`metodo/modelos/retro.md`) a cada Spec; postmortem em incidente; a lição vira regra na Spec e, se for geral, no dev-playbook |

## Ferramentas por fase

- **Antes dos gates do PRD e da Spec: interrogatório.** Rode `/grill-me` (ou `/grill-with-docs`, que confronta com a documentação) sobre o documento e responda até não sobrarem pontos indefinidos. As respostas viram critérios, decisões ou itens "fora do escopo".
- **Antes de qualquer código: modo plan** do Claude Code. Leia o plano e só então aprove a implementação.
- **No commit: hook obrigatório.** O `estruturas/perfil-a/.claude/settings.json` bloqueia `git commit` feito pela IA se `npm run verificar` (lint, tipos e testes) falhar. Regra escrita é pedido; hook é garantia.
- **No CI: segredos e SAST.** Gitleaks e Semgrep rodam em todo PR (`estruturas/perfil-a/.github/workflows/ci.yml`).
- **Antes do primeiro release: auditoria de segurança** (S-31) em código próprio, com revisão humana dos achados. Pentest automatizado (ex.: Strix) só depois, em ambiente próprio e com autorização.
- **Skills de apoio (em avaliação):** `tdd` no Red/Green, `diagnosing-bugs` em bugs, `domain-modeling` para glossário e ADRs, `web-design-guidelines` na revisão de UI. Lista e situação em `metodo/stack/perfil-a-corporativo.md`.
- **Ao fim de cada Spec: retro** (`metodo/modelos/retro.md`). Lições gerais voltam ao dev-playbook.

## Duas rotas para o começo

| Rota | Ordem | Quando usar |
|---|---|---|
| **A. PRD primeiro** | PRD → Discovery → Protótipo → Spec | O problema e as regras já chegam definidos (ex.: documento de um responsável) |
| **B. Protótipo primeiro** (a rota habitual) | **Brief** → Protótipo no Claude Design (refinado aos poucos) → **PRD gerado do protótipo** → revisão humana → Spec | A solução é descoberta enquanto se desenha |

Na **rota B**, o protótipo faz o papel de Discovery. Salvaguardas obrigatórias:
1. **Brief antes de desenhar** (5 linhas: problema, público, objetivo, como medir, fora do escopo). Ele é a âncora: sem ele, o PRD gerado ao final descreve só telas.
2. **Decisões anotadas durante** o protótipo (o que mudou e por quê), para não se perderem.
3. **Ao final:** pedir ao Claude Design o **PRD + inventário** (prompts em `metodo/modelos/prompt-design.md`).
4. **Revisão humana do PRD gerado:** problema, hipótese e métricas são reescritos à mão se preciso (o protótipo não sabe o "porquê"); comparar com o brief e listar os desvios; rodar `/grill-me`.
5. Só então o **gate do PRD**.

## Regras de passagem entre fases

- O **Design nasce do PRD**; o handoff alimenta a Spec, não substitui.
- O **PRD só muda** se o porquê, o escopo ou a métrica mudarem. Detalhes ficam no Design e na Spec. Toda versão do PRD tem histórico.
- Se o protótipo ampliou o escopo, **liste os desvios** em relação ao pedido original e leve para aprovação.
- **Stack** não entra no PRD (exceto como restrição de uma linha); vai para ADR ou Spec.

## Modo rápido

Para mudanças pequenas e de baixo risco: spec curta + teste. **Nunca** para autenticação, permissões, dados pessoais ou migrações.

## Perfil leve (padrão para MVP)

PR com 1 aprovação; CI com lint, tipos, testes e varredura de segredos; testes de abuso em autenticação e permissões; spec curta; ADR para decisões grandes; backup testado.
Adiados até o sistema estar em uso: mutation testing, DAST, feature flags, SLOs formais, métricas avançadas.

## Git e GitHub

branch → commit → push → PR → aprovação → squash and merge.
- Commit é local; push envia ao GitHub.
- Branch `tipo/12-descricao`, commit `feat(#12): ...`, `Closes #12` no PR.
- A proteção da `main` e o CODEOWNERS obrigatório dependem do plano do GitHub (repositório privado no plano gratuito não os aplica; verificado em 2026-11-19 na documentação oficial).
