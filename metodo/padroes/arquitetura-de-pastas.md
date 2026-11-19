# Arquitetura de pastas (padrão)

Estrutura de partida para sistemas web com a stack do Perfil A (`metodo/stack/perfil-a-corporativo.md`). O Perfil B usa os mesmos nomes, com as diferenças descritas em `metodo/stack/perfil-b-supabase-vercel.md`. Um sistema pode mudá-la, registrando o motivo num ADR.
Nem tudo precisa existir no primeiro dia: crie `docs/`, `specs/`, `handoff/` e `.github/` primeiro, e os módulos do backend conforme as tarefas.

```
<sistema>/
├── backend/                         NestJS + Prisma
│   ├── prisma/                      schema.prisma, migrations/ e seed (dados fictícios)
│   ├── src/
│   │   ├── auth/                    login, sessão (cookie HttpOnly), troca de senha
│   │   ├── common/                  pipes (ZodValidationPipe), filtros de erro, decorators, utilitários
│   │   ├── guards/                  JwtAuthGuard e PermissionsGuard (perfil × módulo × nível)
│   │   ├── prisma/                  módulo de conexão com o banco (PrismaService)
│   │   ├── saude/                   health check (aplicação e banco)
│   │   ├── auditoria/               trilha de auditoria, só inserção
│   │   ├── usuarios/ · perfis/      contas e permissões
│   │   └── <dominio>/               um módulo por domínio do negócio (ver anatomia abaixo)
│   └── test/                        integração (Supertest): regras críticas, atomicidade,
│                                    concorrência, permissão
├── frontend/                        Next.js (App Router)
│   ├── src/
│   │   ├── app/                     rotas (uma por tela do protótipo)
│   │   ├── components/              componentes reutilizáveis do inventário
│   │   ├── hooks/ · services/ · schemas/ (Zod) · types/ · utils/
│   │   └── proxy.ts                 só redireciona; autorização real fica no backend
│   └── tests/                       unitários (Vitest + Testing Library)
├── e2e/                             Playwright (fluxos principais e abusos)
├── specs/                           uma pasta por funcionalidade
│   └── 001-<funcionalidade>/
│       ├── spec.md                  critérios EARS (o quê)
│       └── tarefas.md               plano: tarefas ordenadas, cada uma ligada a critérios e a uma Issue
├── handoff/                         SOMENTE LEITURA: protótipo exportado, inventário, prompt de design
├── docs/
│   ├── origem/                      pedido ou documento original
│   ├── estado.md                    fase atual, gates, pendências e próximo passo
│   ├── prd.md                       com histórico de mudanças
│   ├── threat-model.md              STRIDE + matriz perfil × recurso × ação
│   ├── adr/                         0001-..., 0002-...
│   └── api/                         exemplos de requisição e resposta
├── .github/
│   ├── workflows/ci.yml             lint, tipos, testes, segredos, auditoria de dependências
│   ├── ISSUE_TEMPLATE/              tarefa (ligada a um critério da Spec) e bug
│   ├── dependabot.yml               PRs mensais de atualização (npm, actions, docker)
│   ├── CODEOWNERS                   só áreas sensíveis
│   └── pull_request_template.md     Closes #N, critérios da Spec, como testar
├── package.json                     workspaces (frontend, backend) e script `verificar`
├── .nvmrc                           versão do Node
├── CHANGELOG.md                     histórico do sistema (versão semântica)
├── .dev-playbook/metodo/            cópia do método para a IA consultar (IGNORADA pelo Git)
├── .gitignore                       inclui .env e .dev-playbook/
├── .env.example                     sem segredos
├── docker-compose.yml               PostgreSQL (porta só local)
├── README.md                        "nasceu do dev-playbook vX.Y", como rodar, desvios do modelo
├── CLAUDE.md                        regras permanentes para a IA neste sistema (pedidos)
└── .claude/settings.json            regras obrigatórias: nega leitura de .env; hook bloqueia commit
                                     se `npm run verificar` (lint + tipos + testes) falhar
```

O `package.json` da raiz precisa do script `verificar`, que roda lint, checagem de tipos, testes do backend e do frontend e o **Gitleaks em modo staged** (confirme as opções atuais na documentação oficial). O CI (`.github/workflows/ci.yml`) roda o `verificar`, `npm audit`, o Gitleaks no histórico e o Semgrep. A raiz também precisa de um `.nvmrc` com a versão do Node.

## Anatomia de um módulo do backend

```
<dominio>/                           ex.: produtos/
├── <dominio>.module.ts              registra o módulo e o que ele usa
├── <dominio>.controller.ts          recebe a requisição HTTP: rota, validação, resposta
├── <dominio>.service.ts             regra de negócio e acesso ao banco (via Prisma)
├── schemas/                         schemas Zod de entrada (ex.: criar-<dominio>.schema.ts)
├── dto/                             objetos de saída explícitos (sem campos internos)
└── <dominio>.service.spec.ts        teste unitário do service (opcional, ao lado do código)
```

Fluxo de uma requisição: **controller → pipe Zod (formato) → guard (permissão) → service (regra, transação) → Prisma → banco**.

**Regras de ouro**
- Regra de negócio no **service**; HTTP no **controller**. Se um aparece no lugar do outro, a peça está errada (pergunta útil ao revisar diff da IA).
- Operações com regra compartilhada (ex.: atualizar saldos ou contadores) ficam num **service comum**, para a regra existir num lugar só.
- `backend/prisma/` é a **planta** do banco (schema, migrações); `backend/src/prisma/` é a **tomada** (conexão usada pelo código).

## Onde mora cada decisão

| Decisão | Onde |
|---|---|
| Spec separada do PRD, aprovada por PR | `specs/<NNN>-<funcionalidade>/spec.md` |
| Plano de tarefas (versionado) | `specs/<NNN>-<funcionalidade>/tarefas.md` |
| Status de cada tarefa | GitHub Issues (fonte do status; `Closes #N` no PR) |
| Handoff somente leitura | `handoff/` |
| Decisões grandes | `docs/adr/` |
| Autorização no servidor | `backend/src/guards/` + `docs/threat-model.md` |
| Testes de regra crítica, atomicidade, concorrência e permissão | `backend/test/` |
| Gates reais (CI, aprovação) | `.github/` |
| Auditoria só de inserção | `backend/src/auditoria/` + permissões do usuário do banco (migração) |
| Segredos fora do código | `.env` (ignorado) + `.env.example` |

## CODEOWNERS sugerido
`specs/`, `docs/adr/`, `docs/threat-model.md`, `backend/src/auth/`, `backend/src/guards/`, `backend/src/perfis/`, `backend/prisma/migrations/`, `.github/`.
