# Checklist: início de sistema

## Perguntas ao responsável (antes de qualquer código)
- [ ] Qual problema o sistema resolve e para quem? O que é "pronto"?
- [ ] Prazo e tamanho: o que entra na primeira fatia?
- [ ] **Perfil A (corporativo: NestJS) ou B (enxuto: Supabase + Vercel)?** Ver `metodo/stack/perfil-b-supabase-vercel.md`; registrar num ADR.
- [ ] **Rota B (protótipo primeiro, habitual) ou A (PRD primeiro)?** Na rota B, escrever o **brief** de 5 linhas (`metodo/fluxo/ciclo.md`).
- [ ] Stack obrigatória ou livre? Há padrão da equipe (pastas, lint, testes)?
- [ ] Freelance: plano comercial da hospedagem no orçamento, contas em nome de quem, quem é o controlador dos dados (LGPD)?
- [ ] Quem aprova PRs? Quantas aprovações? A `main` estará protegida (plano do GitHub)?
- [ ] Onde ficam as tarefas (padrão: GitHub Issues)? Há exigência de outra ferramenta?
- [ ] O uso de IA (Claude Code, ferramentas de design, artifacts, **MCPs**) é permitido? Com que restrições e com quais dados?
- [ ] Haverá dados pessoais? Que regras de LGPD e retenção valem?
- [ ] O que será avaliado: só o sistema ou também o processo?

## Preparação
Passo a passo detalhado em `metodo/fluxo/iniciar-sistema.md`.
- [ ] Método copiado para `.dev-playbook/metodo/` e **fora do Git** (conferido com `git status`).
- [ ] Repositório criado a partir de `estruturas/perfil-a/`; README diz "nasceu do dev-playbook vX.Y.Z".
- [ ] `docs/estado.md` criado a partir de `metodo/modelos/estado-do-sistema.md`, com rota, fase e (rota B) o brief.
- [ ] Documento original guardado em `docs/origem/` (no repositório do sistema, nunca no dev-playbook).
- [ ] Versões da stack conferidas nos avisos oficiais e fixadas (ver `metodo/stack/perfil-a-corporativo.md`).
- [ ] `.env` fora do Git; `.env.example` sem segredos.
- [ ] CI mínimo (lint, tipos, testes, varredura de segredos, auditoria de dependências).
- [ ] `.claude/settings.json` copiado: leitura de `.env` negada e hook que bloqueia commit sem verificação.
- [ ] Script `verificar` no `package.json` (lint + tipos + testes), exigido pelo hook. Testar: um commit com teste quebrando deve ser bloqueado.

## Documentos, nesta ordem
Rota B (habitual):
- [ ] Brief escrito.
- [ ] Protótipo no Claude Design com os 3 prompts (`metodo/modelos/prompt-design.md`); decisões anotadas a cada rodada.
- [ ] PRD + inventário + desvios gerados no fechamento; problema, hipótese e métricas revisados à mão; `/grill-me`; PRD em `docs/prd.md` e inventário em `handoff/`; desvios aprovados.

Rota A:
- [ ] PRD (`metodo/modelos/prd.md`) interrogado com `/grill-me` e aprovado.
- [ ] Protótipo + inventário em `handoff/`; desvios listados e aprovados.

Depois, nas duas rotas:
- [ ] Modelagem de dados (diagrama ou schema) revisada.
- [ ] Threat model (`metodo/modelos/threat-model.md`).
- [ ] ADRs das decisões grandes.
- [ ] Spec da primeira fatia (`metodo/modelos/spec.md`) interrogada com `/grill-with-docs` e em PR próprio.
- [ ] Plano `tarefas.md` (`metodo/modelos/tarefas.md`) aprovado e uma Issue por tarefa.

## Ao terminar
- [ ] Entregáveis pedidos (README, documentação da API, usuário de demonstração, apresentação das decisões).
- [ ] Retro de cada Spec feita (`metodo/modelos/retro.md`).
- [ ] Lições levadas de volta ao dev-playbook e registradas no `CHANGELOG.md`.
