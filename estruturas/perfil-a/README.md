# <Nome do sistema>

Nasceu do modelo **dev-playbook v<X.Y>** em <aaaa-mm-dd>.

> Este arquivo e os demais desta pasta são copiados para o repositório de cada sistema. Depois da cópia, apague esta nota e preencha os campos.

## Estrutura esperada

Resumo abaixo; versão completa (anatomia de módulo, onde mora cada decisão) em `.dev-playbook/metodo/padroes/arquitetura-de-pastas.md`.

```
<sistema>/
├── backend/            NestJS + Prisma (módulo por domínio)
│   ├── prisma/         schema, migrations, seed (fictício)
│   ├── src/            auth · common · guards · prisma · saude · auditoria · <domínios>
│   └── test/           integração (saldo, atomicidade, concorrência, permissão)
├── frontend/           Next.js (App Router)
│   ├── src/            app · components · hooks · services · schemas · types · utils · proxy.ts
│   └── tests/
├── e2e/                Playwright
├── specs/              uma pasta por funcionalidade: <NNN>-<nome>/spec.md + tarefas.md
│                       (modelos: .dev-playbook/metodo/modelos/spec.md e tarefas.md)
├── handoff/            protótipo e inventário (somente leitura)
├── docs/
│   ├── origem/         pedido ou documento original
│   ├── prd.md
│   ├── threat-model.md
│   ├── adr/
│   └── api/
├── .github/            workflows · ISSUE_TEMPLATE · CODEOWNERS · pull_request_template.md
├── .dev-playbook/metodo/  cópia do método para consulta da IA (fora do Git)
├── .gitignore · .env.example · docker-compose.yml
├── README.md
└── CLAUDE.md
```

## Antes do primeiro commit (apague esta seção depois)
1. Criar os workspaces `frontend/` e `backend/`, cada um com os scripts `lint`, `tipos` e `test` (o `package.json` da raiz os chama).
2. Instalar o **Gitleaks** localmente (usado por `npm run segredos`) e conferir as opções atuais na documentação oficial.
3. Conferir a versão LTS do Node (`.nvmrc`), da imagem do PostgreSQL (`docker-compose.yml`) e fixar as versões das actions (`.github/workflows/ci.yml`).
4. Rodar `npm run verificar`: ele precisa passar, senão o hook bloqueia os commits da IA.
5. Criar `docs/estado.md` a partir do modelo do dev-playbook.

## Como rodar
<instalar, configurar, rodar; usuário de demonstração fictício>

## Decisões que diferem do modelo
| Padrão do modelo | Neste sistema | ADR |
|---|---|---|
