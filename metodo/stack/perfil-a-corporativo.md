# Stack padrão (Perfil A: corporativo)

> Para projetos pessoais, MVPs e freelance, veja o **Perfil B** (Next.js + Supabase + Vercel) em [`perfil-b-supabase-vercel.md`](perfil-b-supabase-vercel.md).

Padrão de partida para sistemas web. Cada sistema pode trocar um item, registrando o motivo num ADR.
**Versões não são fixadas aqui**: confira os avisos de segurança oficiais no início de cada sistema e fixe a versão corrigida mais recente.

## Escolhas

| Camada | Padrão | Observações |
|---|---|---|
| Frontend | Next.js (App Router), React, TypeScript, Tailwind | `proxy.ts` só redireciona; autorização real no backend |
| Formulários | React Hook Form + Zod | Validação no front é experiência, não segurança |
| Dados no front | TanStack Query | Sem cache compartilhado de dados sensíveis |
| Backend | NestJS (API REST), TypeScript | Módulo por domínio: `controller` → pipe Zod → `service` → Prisma |
| Validação no backend | Zod (schemas em `<módulo>/schemas/`, `ZodValidationPipe` em `common/`) | Pesquisar a integração com a documentação Swagger antes de implementar |
| Banco | PostgreSQL + Prisma | Usuários separados para migração e aplicação |
| Gráficos | Recharts | Exigir tabela alternativa (acessibilidade) |
| Excel | ExcelJS (versão corrigida mais recente) | **Não** usar a cópia `xlsx` do npm (abandonada) |
| CSV | Sem biblioteca | Tratar vírgula, aspas, quebra de linha e fórmulas |
| Testes | Jest + Supertest (back), Vitest + Testing Library (front), Playwright (E2E) | |
| CI | GitHub Actions (`estruturas/perfil-a/.github/workflows/ci.yml`) | Lint, tipos, testes, `npm audit`, Gitleaks, Semgrep |
| Segredos | **Gitleaks** (código aberto) | No pre-commit (dentro do `verificar`, modo staged) e no CI (histórico completo) |
| Análise estática (SAST) | **Semgrep CE** (código aberto) | No CI com `semgrep scan` e um conjunto de regras explícito |
| Revisão de segurança com IA | **Em avaliação:** skills da Trail of Bits (`differential-review`, `sharp-edges`, `insecure-defaults`) | Pilotar num PR de treino antes de adotar |
| Auditoria antes do 1º release | **Em avaliação:** skill `security-audit` da Cloudflare | Só em código próprio ou autorizado |
| Qualidade corporativa | SonarQube | **Só se a organização já usar** |
| Pentest com IA | **Adiado:** Strix | Só em ambiente próprio e com autorização, depois que o sistema estiver no ar |
| Ambiente local | Docker Compose | Porta do banco só local |
| Senhas | Argon2id | bcrypt só se exigido (limite de 72 bytes) |
| Tarefas | GitHub Issues | `Closes #N` no PR |
| Regras para a IA | `CLAUDE.md` no repositório | Ver `estruturas/perfil-a/CLAUDE.md` |

> Ferramentas consolidadas que **não usamos agora** ficam guardadas em [`radar.md`](radar.md), cada uma com o gatilho para trazê-la.

## Skills do Claude Code

Skills rodam com **todas as permissões** do agente. Regras: instalar só da origem oficial (cuidado com nomes parecidos de outros donos), ler o `SKILL.md` antes, anotar a versão e pilotar num repositório de treino antes de adotar. Preferir os comandos **nativos** do Claude Code quando fizerem o mesmo.

| Situação | Skill | Origem | Uso no ciclo |
|---|---|---|---|
| **Adotada** | `grill-me`, `grill-with-docs` | mattpocock/skills | Interrogar PRD e Spec antes dos gates |
| **Adotada** | `find-skills` | vercel-labs/skills | Procurar skills (avaliar antes de instalar) |
| **Adotada** | `skill-creator` | anthropics/skills | Criar skills próprias (ex.: futura "novo-sistema") |
| **Nativa** | `/code-review`, `/security-review`, `/simplify` | Claude Code | Revisão de diff, segurança e limpeza |
| Em avaliação | `tdd` | mattpocock/skills | Red → Green → Refactor por fatia vertical |
| Em avaliação | `diagnosing-bugs` | mattpocock/skills | Bug → reproduzir → teste de regressão → correção |
| Em avaliação | `domain-modeling` | mattpocock/skills | Glossário do domínio e ADRs |
| Em avaliação | `handoff` | mattpocock/skills | Passar contexto entre sessões longas |
| Em avaliação | `codebase-design` | mattpocock/skills | Módulos profundos, interfaces pequenas |
| Em avaliação | `web-design-guidelines` | vercel-labs/agent-skills | Revisão de UI e acessibilidade |
| Em avaliação | `vercel-react-best-practices` | vercel-labs/agent-skills | Desempenho em React/Next.js |
| Em avaliação | `differential-review`, `sharp-edges`, `insecure-defaults` | trailofbits/skills | Revisão de segurança do diff |
| Em avaliação | `security-audit` | cloudflare/security-audit-skill | Auditoria antes do 1º release |
| Mais tarde | `to-spec`, `to-tickets`, `implement`, `implement-spec`, `wayfinder`, `retro`, `pr` | mattpocock/skills | Fluxo completo concorrente ao nosso; exige decidir qual convenção vence |
| Mais tarde | `agent-browser` | vercel-labs/agent-browser | Automação de navegador (sobrepõe-se ao Playwright) |
| Não usar | vídeo/imagem/música, Lark/Feishu, automação de redes sociais, cópias de "superpowers" de donos diversos | vários | Fora do escopo ou risco de origem |

**Adaptar (fork):** só depois do piloto, seguindo `skills/README.md` (cabeçalho de origem, commit, licença e mudanças). Licenças verificadas em 2026-11-19: mattpocock, vercel-labs e cloudflare são MIT; trailofbits é CC BY-SA 4.0 (prefira usar a original). **Atualização:** trimestral, via `metodo/checklists/manutencao-do-playbook.md`, sempre por PR.

**Piloto sugerido:** num repositório de treino, uma Spec pequena percorrida com `tdd` → `/code-review` → `web-design-guidelines`, e um bug fictício com `diagnosing-bugs`. Registrar o resultado numa retro antes de promover a "adotada".

## Fatos perecíveis (reconferir no início de cada sistema)

| Fato | Verificado em | Confiança | Fonte |
|---|---|---|---|
| Next.js publica avisos de segurança mensais; correções citadas em 16.4.5 e 15.5.29 (nov/2026) | 2026-11-19 | Baixa (terceiros) | Blogs e changelog da Netlify |
| A correção inicial da CVE-2025-55182 (React 19.0.1/19.1.2/19.2.1; Next.js 15.5.7/16.0.7) foi relatada como incompleta | 2026-11-19 | Média | react.dev, Zscaler |
| NestJS 12 (ESM) é a linha atual; pede Node 20.19+ ou 22.12+ | 2026-11-19 | Média | endoflife.date, InfoQ |
| Prisma 7: URL do banco em `prisma.config.ts`; `.env` não é carregado sozinho | 2026-11-19 | Boa | docs.prisma.io |
| Next.js 16 renomeou `middleware.ts` para `proxy.ts` | (não reverificado) | Média | Material de estudo |
| ExcelJS teve CVEs em 2026; citada correção em 5.0.0+ | 2026-11-19 | Baixa (agregadores) | OSV, Snyk |
| Proteção da `main` e CODEOWNERS em repositório privado exigem plano pago | 2026-11-19 | Boa | docs.github.com |
| Gitleaks v8.19+ usa os comandos `git`, `dir` e `stdin`; `detect` e `protect` ficaram obsoletos; `--staged` varre só o que vai ser commitado. A action oficial exige licença (`GITLEAKS_LICENSE`) para organizações | 2026-11-19 | Média (README espelhado) | github.com/gitleaks/gitleaks |
| Semgrep: imagem `semgrep/semgrep`; `semgrep scan` roda sem login (`semgrep ci` exige token) | 2026-11-19 | Média | semgrep.dev/docs (sample CI configs) |
| Trail of Bits publica as skills como marketplace de plugins: `/plugin marketplace add trailofbits/skills` | 2026-11-19 | Boa | trailofbits.com/skills |
| Cloudflare `security-audit` (licença MIT): `npx skills add https://github.com/cloudflare/security-audit-skill --skill security-audit` | 2026-11-19 | Boa | github.com/cloudflare/security-audit-skill |
| Ranking do skills.sh (todos os tempos): `find-skills` 1º (4,4 mi), `grill-me` 5º (1,6 mi), `grill-with-docs` 10º (1,3 mi); vários `ai-image-generation` de donos diferentes | 2026-11-19 | Boa (página do ranking) | skills.sh |
| Claude Design standalone fecha em 14/12/2026; design passa a viver no Claude (Artifacts), com `/design` e `/design-sync` no Claude Code | 2026-11-19 | Boa (data) / Baixa (comandos) | support.claude.com |
