# <Nome do sistema>

Nasceu do modelo **dev-playbook v<X.Y>** em <aaaa-mm-dd>. Perfil **B** (Next.js + Supabase + Vercel).

> Este arquivo e os demais desta pasta são copiados para o repositório de cada sistema. Depois da cópia, apague esta nota e preencha os campos.
> **Rascunho não testado:** o primeiro projeto do Perfil B valida e corrige esta estrutura.

## Estrutura esperada

> Caminhos `metodo/...` citados aqui são arquivos do **plugin dev-playbook** (consulte pela skill `/dev-playbook:metodo`).

Resumo abaixo; versão completa (onde rodam as regras, equivalência com o Perfil A) em `metodo/stack/perfil-b-supabase-vercel.md`.

```
<sistema>/
├── package.json        workspaces: frontend, backend
├── backend/            pacote interno: regras de negócio (roda só no servidor)
│   ├── src/            <dominio>/<dominio>.service.ts · schemas/ · dto/ · auth/ · supabase/admin.ts
│   └── test/           testes dos services
├── frontend/           Next.js (App Router): telas + app/api/<rota>/route.ts que chamam o backend
│   ├── src/            app · components · hooks · services · schemas · types · utils · lib/supabase · proxy.ts
│   └── tests/
├── supabase/           migrations/ (com RLS) · tests/ (testes de RLS) · seed.sql (fictício)
├── e2e/                Playwright
├── specs/              uma pasta por funcionalidade: <NNN>-<nome>/spec.md + tarefas.md
│                       (modelos: metodo/modelos/spec.md e tarefas.md)
├── handoff/            protótipo e inventário (somente leitura)
├── docs/
│   ├── origem/         pedido ou documento original
│   ├── prd.md
│   ├── threat-model.md
│   ├── adr/
│   └── api/
├── .github/            workflows · ISSUE_TEMPLATE · CODEOWNERS · pull_request_template.md
├── .gitignore · .env.example
├── README.md
└── CLAUDE.md
```

## Antes do primeiro commit (apague esta seção depois)
0. Ter o **plugin dev-playbook** instalado (o `.claude/settings.json` já o declara): `claude plugin install dev-playbook@dev-playbook` após adicionar o marketplace.
1. Criar os workspaces `frontend/` (Next.js) e `backend/` (pacote TypeScript), cada um com os scripts `lint`, `tipos` e `test` (o `package.json` da raiz os chama).
2. Iniciar o Supabase local com o **Supabase CLI** (cria a pasta `supabase/`; conferir os comandos atuais na documentação oficial). Criar projetos Supabase **separados** para desenvolvimento/preview e produção.
3. Instalar o **Gitleaks** localmente (usado por `npm run segredos`).
4. Conferir a versão LTS do Node (`.nvmrc`) e fixar as versões das actions (`.github/workflows/ci.yml`).
5. Rodar `npm run verificar`: ele precisa passar, senão o hook bloqueia os commits da IA.
6. Conferir que `docs/estado.md` existe (criado pelo `/novo-sistema` ou a partir do modelo do dev-playbook).

## Como rodar
<instalar, configurar, rodar; usuário de demonstração fictício>

## Decisões que diferem do modelo
| Padrão do modelo | Neste sistema | ADR |
|---|---|---|
