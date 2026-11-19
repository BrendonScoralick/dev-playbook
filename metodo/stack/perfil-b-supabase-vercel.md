# Perfil B: Next.js + Supabase + Vercel (enxuto)

Para projetos pessoais, MVPs e clientes pequenos (freelance). O **método é o mesmo** do playbook (PRD, Spec, testes primeiro, PR, revisão por tarefa); mudam a stack e algumas regras de segurança. Os **nomes de pastas e arquivos são os do Perfil A**.
O Perfil A (corporativo: NestJS + PostgreSQL + Prisma) está em `perfil-a-corporativo.md`. A escolha do perfil é registrada num ADR do sistema.

## Quando usar cada perfil

| | Perfil A: corporativo | Perfil B: enxuto |
|---|---|---|
| Para | Sistemas de organização, regras complexas, time | MVP, pessoal, cliente pequeno |
| Backend | NestJS, programa separado | Pacote `backend/` do monorepo, executado pelo servidor do Next.js |
| Autenticação | Própria (JWT em cookie HttpOnly) | Supabase Auth |
| Autorização | Guards no backend | **RLS no banco** + checagem de sessão no backend |
| Banco | PostgreSQL + Prisma | PostgreSQL do Supabase (Prisma opcional) |
| Hospedagem | Definida pela organização | Vercel (frontend e backend publicados juntos) |

## Onde rodam as regras

Um projeto Next.js tem duas partes: a do **navegador** (telas) e a do **servidor** (rotas de API e server actions, executadas na Vercel). A parte do servidor **é o backend**. Neste perfil, o código de backend fica num pacote próprio (`backend/`) e é chamado só pela parte do servidor.

| Camada | Onde roda | O que guarda |
|---|---|---|
| Banco (Supabase) | PostgreSQL | Regras que nunca podem falhar: RLS, `CHECK`, unicidade, operações atômicas |
| `backend/` | Servidor (via rotas de API / server actions) | Regras de negócio (`<dominio>.service.ts`) |
| `frontend/` (telas) | Navegador | Só experiência: validação antecipada, esconder botões |

O navegador **nunca** é a garantia: ele tem a chave publicável e pode falar direto com o Supabase. Por isso as regras críticas ficam **também no banco**.

## Estrutura de pastas: monorepo com os nomes do Perfil A

```
<sistema>/
├── package.json                     raiz com "workspaces": ["frontend", "backend"]
├── backend/                         pacote interno (ex.: "@<sistema>/backend") — mesmos nomes do Perfil A
│   ├── src/
│   │   ├── <dominio>/
│   │   │   ├── <dominio>.service.ts     regra de negócio; começa com import "server-only"
│   │   │   ├── schemas/                 Zod de entrada
│   │   │   └── dto/                     objetos de saída
│   │   ├── auth/                        leitura e checagem da sessão do Supabase
│   │   ├── supabase/                    clientes do servidor
│   │   │   └── admin.ts                 chave SECRETA: só onde for indispensável
│   │   └── index.ts                     o que o frontend pode importar
│   └── test/                            testes dos services
├── frontend/                        Next.js (App Router) — igual ao Perfil A
│   ├── src/
│   │   ├── app/                     telas; app/api/<rota>/route.ts chama o backend
│   │   ├── components/ · hooks/ · services/ · schemas/ · types/ · utils/
│   │   ├── lib/supabase/            cliente do NAVEGADOR (chave publicável)
│   │   └── proxy.ts                 só redireciona
│   └── tests/
├── supabase/                        migrações (inclui RLS), testes de RLS, seed fictício
├── e2e/ · specs/ · handoff/ · docs/ — iguais ao Perfil A
├── .github/ · .claude/ · .gitignore · .env.example · README.md · CLAUDE.md — iguais ao Perfil A
```

| Perfil A | Perfil B |
|---|---|
| `backend/src/<dominio>/<dominio>.service.ts` | `backend/src/<dominio>/<dominio>.service.ts` (igual) |
| `backend/src/<dominio>/<dominio>.controller.ts` | `frontend/src/app/api/<rota>/route.ts` (ou server action), que chama o service |
| `backend/src/guards/` | Políticas de RLS em `supabase/migrations/` + checagem de sessão em `backend/src/auth/` |
| `backend/prisma/migrations/` | `supabase/migrations/` |
| `backend/test/` | `backend/test/` + `supabase/tests/` (RLS) |

**Configuração do monorepo (verificado em 2026-11-19, documentação do Next.js 16.x):** com o App Router, pacotes de *workspaces* (npm, pnpm ou Yarn) são transpilados automaticamente; `transpilePackages` só é necessário em casos específicos (ex.: Pages Router com webpack). Detalhes de `tsconfig` e exportação do pacote: conferir no primeiro projeto.

**Proteção:** todo arquivo de `backend/` que acessa banco, segredos ou regras começa com `import "server-only"`, para o build falhar se uma tela o importar (confirmar o uso atual na documentação). Telas nunca importam `backend/` diretamente; só as rotas de API e server actions.

A estrutura própria deste perfil está em `estruturas/perfil-b/` (rascunho derivado do Perfil A, ainda não testado): sem `docker-compose.yml`, `.env.example` com chaves publicável e secreta, CODEOWNERS com `supabase/migrations/`, regras de RLS e `server-only` no `CLAUDE.md`, e verificação de `sb_secret_` no CI (a ativar).

## Stack

| Camada | Padrão | Observações |
|---|---|---|
| Frontend e servidor | Next.js (App Router), React, TypeScript, Tailwind | Operações sensíveis só no servidor |
| Regras de negócio | Pacote `backend/` (TypeScript) | Mesmos sufixos e organização por domínio do Perfil A |
| Formulários e validação | React Hook Form + Zod | Validar de novo no backend |
| Banco, Auth, Storage | Supabase | RLS obrigatória (S-33) |
| Migrações e tipos | Supabase CLI | Tipos TypeScript gerados do banco |
| Hospedagem | Vercel | Preview por PR; produção só pela `main` |
| Testes | Vitest + Testing Library, Playwright; testes de RLS no banco | Ferramenta de teste de RLS: verificar (ex.: pgTAP) |
| CI | GitHub Actions (modelo do Perfil A) | Gitleaks e Semgrep continuam |

## Skills para o Perfil B (verificado em 2026-11-19)

Somam-se às skills do Perfil A (`perfil-a-corporativo.md`). Regras de sempre: origem oficial (há muitas cópias com o mesmo nome), ler o `SKILL.md`, pilotar antes de adotar, não instalar no modelo.

| Situação | Skill | Origem oficial | Para quê |
|---|---|---|---|
| Em avaliação (prioridade) | `supabase` e `supabase-postgres-best-practices` | `supabase/agent-skills` | Uso correto do Supabase e regras de desempenho do PostgreSQL (índices, consultas); apoio ao desenho de RLS. ~15 mil instalações por semana |
| Em avaliação (prioridade) | `next-best-practices` | `vercel-labs/next-skills` (um índice indica migração para o repositório `vercel/next.js`, para acompanhar a versão do framework; confirmar antes) | Convenções do App Router: fronteiras entre servidor e cliente, rotas de API, tratamento de erros, dados |
| Em avaliação | `vercel-react-best-practices`, `web-design-guidelines` | `vercel-labs/agent-skills` | Desempenho React/Next.js; revisão de UI e acessibilidade (já listadas no Perfil A) |
| Guardada | `next-cache-components` | `vercel-labs/next-skills` | Cache do Next.js (`use cache`, revalidação), quando o desempenho exigir |
| Guardada | `deploy-to-vercel`, `vercel-optimize` | `vercel-labs/agent-skills` | Deploy e auditoria de custo/desempenho na Vercel |
| Guardado | MCP do Supabase | oficial do Supabase (verificar) | Só leitura e nunca produção (S-32) |

Atenção: o `supabase-postgres-best-practices` aparece também sob donos como `aidangio`, `oldwinter`, `secondsky` e outros; são cópias. Instale só de `supabase/agent-skills`.

## Repositórios de referência

Os repositórios de **fluxo** (Superpowers, Spec Kit, BMAD, GSD, Ponytail) valem para os dois perfis e estão no `radar.md`. Aqui ficam os **repositórios-modelo** específicos deste perfil.

**Regra:** não iniciar um sistema a partir de um boilerplate grande. Ele traz centenas de arquivos não escritos nem revisados por você e convenções que brigam com as `estruturas/` do playbook. Use os repositórios abaixo **para ler e aprender**; copie só trechos pequenos, entendidos e revisados.

| Repositório | Uso | Observações |
|---|---|---|
| **`with-supabase`** (exemplo oficial do Next.js, mantido com o Supabase): `npx create-next-app --example with-supabase` | **Referência principal** para autenticação por cookies (servidor e navegador) e configuração das chaves | Já usa a chave publicável nova (`NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`). Conferir o README atual antes de seguir os passos |

Ao fazer o primeiro projeto neste perfil: partir de `estruturas/perfil-b/` e trazer do `with-supabase` só o trecho de autenticação, corrigindo a estrutura com o que o projeto ensinar. Os starters comunitários estão no `radar.md`.

## Regras de segurança específicas
- **RLS em toda tabela**, com políticas para ler, criar, alterar e apagar. Tabela sem RLS = tabela aberta para qualquer um com a chave publicável.
- **Chave publicável** (`sb_publishable_...`) pode ir para o navegador; **chave secreta** (`sb_secret_...`) **ignora a RLS** e fica só no backend, **nunca** em variável `NEXT_PUBLIC_*`. Verificação: procurar `sb_secret_` no build (`.next/`).
- Políticas de RLS testadas: um usuário tenta ler/alterar o dado de outro e falha.
- **Previews da Vercel nunca apontam para o banco de produção.** Projetos Supabase separados (desenvolvimento/preview × produção).
- Storage com políticas próprias.
- MCP do Supabase, se usado: só leitura e nunca produção (S-32).

## Negócio e LGPD (freelance)
- **Vercel Hobby é só para uso pessoal e não comercial.** Projeto de cliente é comercial: plano **Pro** (incluir no orçamento).
- Definir no contrato: o cliente como controlador dos dados, em nome de quem ficam as contas (Vercel, Supabase, domínio) e como é a entrega ao final.
- Escolher a **região** do Supabase considerando a LGPD (regiões disponíveis: verificar).
- Backups e plano de saída: como o cliente recebe os dados se o contrato acabar.

## Fatos perecíveis

| Fato | Verificado em | Confiança | Fonte |
|---|---|---|---|
| Supabase troca `anon`/`service_role` por chaves publicável (`sb_publishable_`) e secreta (`sb_secret_`); antigas descontinuadas até o fim de 2026; secreta ignora RLS | 2026-11-19 | Boa | supabase.com/docs (api-keys, migrating-to-new-api-keys) |
| Vercel Hobby: só uso pessoal e não comercial; uso comercial exige Pro ou Enterprise | 2026-11-19 | Boa | vercel.com/docs (plans/hobby, fair-use-policy) |
| Next.js 16.x (App Router) transpila automaticamente pacotes de workspaces; `transpilePackages` só em casos específicos | 2026-11-19 | Boa | nextjs.org/docs (transpilePackages) |
| Skills oficiais: `supabase/agent-skills` (`supabase`, `supabase-postgres-best-practices`); `vercel-labs/next-skills` (`next-best-practices`, `next-cache-components`), possivelmente migrando para `vercel/next.js` | 2026-11-19 | Média (skills.sh, blog do Supabase, índice de terceiros sobre a migração) | skills.sh; supabase.com/blog |
| Regiões do Supabase disponíveis para dados no Brasil | não verificado | — | — |
