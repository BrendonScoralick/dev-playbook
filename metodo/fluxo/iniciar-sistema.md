# Iniciar um sistema novo

Passo a passo para criar um sistema usando o dev-playbook.
Cada passo diz **o que fazer**, **por quê** e **como saber que deu certo**.

> Este roteiro ainda não foi executado de ponta a ponta. O primeiro sistema (de preferência um sistema de treino) vai ajustá-lo.

## Dois jeitos de começar

| Jeito | Quando | O que você faz |
|---|---|---|
| **Automático (recomendado)** | Com o plugin instalado | Passos 1 e 2, depois `/dev-playbook:novo-sistema` (faz os passos 3 a 7), depois segue da Etapa 3 em diante |
| **Manual** | Sem o plugin, ou para entender o que ele faz | Todos os passos, na ordem |

**O que o `/dev-playbook:novo-sistema` faz por você:** entrevista (nome, brief, perfil, rota, responsável, restrições) → cópia da estrutura do perfil → preenchimento dos modelos → `.env` → `docs/estado.md` → ADR 0001 → `git init` → conferência do `.gitignore` → próximo passo (na rota B, o Prompt 1 do Claude Design já preenchido).
**O que ele não faz:** criar o repositório no GitHub, commit, push e instalar pacotes (só se você pedir).

---

## Visão geral

```
PREPARAR A MÁQUINA     (uma vez só: ferramentas + plugin dev-playbook)
        ↓
1. DECIDIR             o que é o sistema, o brief, o perfil e a rota
        ↓
2. CRIAR O PROJETO     pasta + estrutura do perfil (o método vem do plugin)
        ↓
3. FUNDAÇÃO TÉCNICA    frontend e backend vazios, mas funcionando
        ↓
4. TRABALHAR NO CICLO  protótipo → PRD → Spec → tarefas → código
```

O **protótipo** acontece no Claude Design, fora do repositório: ele pode começar logo depois da Etapa 1, em paralelo às Etapas 2 e 3.

**Ideia central:** o método é **instalado uma vez** como plugin (`dev-playbook`) e serve a todos os sistemas. Cada sistema recebe só a **estrutura** do seu perfil (vai para o Git). Quando o método melhora, um `claude plugin update` atualiza todos.

---

## Preparar a máquina (uma vez só)

**Passo 1. Instalar as ferramentas**
- Git, Node (versão LTS), Docker (Perfil A e Supabase local), Claude Code e Gitleaks. Opcional: o `gh` (linha de comando do GitHub).
- ✅ **Pronto quando:** `git --version`, `node --version` e `docker --version` respondem sem erro.

**Passo 2. Instalar o plugin dev-playbook**
- No Claude Code, digite (um comando só):
  ```
  /plugin install dev-playbook --marketplace BrendonScoralick/dev-playbook
  ```
  Ou, no terminal: `claude plugin marketplace add BrendonScoralick/dev-playbook` e depois `claude plugin install dev-playbook@dev-playbook`.
- O repositório é **privado**: o Claude Code usa o login do GitHub que já existe na máquina (o mesmo do `git push`).
- Para atualizar depois: `claude plugin update dev-playbook@dev-playbook` (e reiniciar o Claude Code).
- ✅ **Pronto quando:** ao digitar `/` aparecem `dev-playbook:novo-sistema` e `dev-playbook:metodo`.

---

## Etapa 1: decidir

> **Jeito automático:** crie uma pasta vazia (ou clone um repositório vazio do GitHub, Passo 4), abra o Claude Code nela e digite `/dev-playbook:novo-sistema`. A entrevista cobre os passos 3 e 3b, e a skill faz os passos 5 a 7. Depois, vá direto para a **Etapa 3**.

**Passo 3. Conversar com quem pediu o sistema**
- Use as perguntas de `metodo/checklists/inicio-de-sistema.md`: qual é o problema, o prazo, quem aprova, se pode usar IA, se há dados pessoais.
- Escolha o perfil:
  - **Perfil A** (empresa, regras complexas): NestJS + PostgreSQL.
  - **Perfil B** (pessoal, freelance, pequeno): Supabase + Vercel.
- Escolha a rota:
  - **Rota B, protótipo primeiro (a habitual):** você descobre o sistema desenhando.
  - **Rota A, PRD primeiro:** o problema e as regras já chegaram definidos (ex.: um documento de quem pediu).
- ✅ **Pronto quando:** você sabe responder "o que é, para quem, até quando, qual perfil e qual rota".

**Passo 3b. Escrever o brief (rota B)**
- Cinco linhas, que serão a âncora do protótipo e do PRD:
  ```
  Problema: <o que dói hoje e para quem>
  Público: <quem usa>
  Objetivo: <o que deve mudar>
  Como medir: <um número que mostre que deu certo>
  Fora do escopo: <o que este sistema não faz>
  ```
- ✅ **Pronto quando:** as cinco linhas estão preenchidas sem `< >`.

---

## Etapa 2: criar o projeto

**Passo 4. Criar o repositório no GitHub**
- Crie um repositório **vazio e privado** (pelo site do GitHub ou com `gh repo create`) e clone-o para a máquina.
- Também dá para fazer depois: criar o repositório vazio e ligá-lo com `git remote add origin <url>` antes do primeiro push (Passo 12).
- ✅ **Pronto quando:** existe uma pasta `sistema-x` vazia na sua máquina.

**Passo 5. Copiar a estrutura do perfil** (manual; a skill faz isso sozinha)

Clone o dev-playbook numa pasta qualquer e, dentro de `sistema-x`, rode:
```
robocopy C:\caminho\dev-playbook\estruturas\perfil-a . /E
```
(Perfil B: troque `perfil-a` por `perfil-b`.)

- A estrutura é a **base do sistema**: `CLAUDE.md`, `.claude/settings.json` (hook, bloqueio do `.env` e declaração do plugin), CI, `package.json`. Vai para o Git.
- O `/E` copia também as pastas escondidas (as que começam com ponto, como `.github`).
- **Não copie** o `CLAUDE.md` nem o `README.md` da raiz do playbook: são regras para manter o playbook.
- *Sem o plugin instalado:* copie também o método para consulta local, fora do Git: `robocopy C:\caminho\dev-playbook\metodo .dev-playbook\metodo /E`.
- ✅ **Pronto quando:** a pasta `sistema-x` tem `CLAUDE.md`, `package.json` e `.claude/settings.json`.

**Passo 6. Preencher os campos dos modelos**

Os arquivos copiados têm espaços para preencher, marcados com `<...>`:

| Arquivo | O que preencher |
|---|---|
| `README.md` | Nome do sistema, versão do playbook ("nasceu do dev-playbook vX.Y.Z") e data; apagar a nota de modelo |
| `CLAUDE.md` | Nome e versão; **apagar o comentário do topo** (aquele que diz MODELO) |
| `package.json` | Nome do pacote, em minúsculas e sem espaços (ex.: `agenda-de-salas`) |
| `.claude/settings.json` | Trocar `<repositorio-do-playbook>` por `dono/dev-playbook` |
| `.github/CODEOWNERS` | Trocar `<responsavel>` pelo `@usuario` do GitHub de quem aprova |
| `CHANGELOG.md` | Nome, data de hoje e versão do playbook |
| `docs/estado.md` | Criar a partir de `metodo/modelos/estado-do-sistema.md`; preencher rota, fase (**Protótipo** na rota B, **PRD** na rota A) e o **brief** |
| `docs/adr/0001-perfil-e-rota.md` | Criar com `metodo/modelos/adr.md`: perfil e rota escolhidos e por quê |
| `.env` | Criar copiando o `.env.example` e trocando os valores de exemplo (Perfil A: senhas do banco e do JWT; Perfil B: URL e chaves do Supabase) |

- ✅ **Pronto quando:** não restam `<Nome do sistema>`, `<nome>`, `<X.Y>`, `<aaaa-mm-dd>`, `<responsavel>` nem `<repositorio-do-playbook>` nesses arquivos. (Os `<...>` dos modelos de PR e Issue ficam: são preenchidos a cada uso.)

**Passo 7. Conferir o que vai para o Git**
```
git status
```
- ✅ **Pronto quando:** `.env` (e `.dev-playbook`, se você o copiou) **não aparecem** na lista. Eles já estão no `.gitignore`.

---

## Etapa 3: fundação técnica

> Daqui em diante, os dois jeitos seguem igual. O `/dev-playbook:novo-sistema` oferece conduzir esta etapa com a sua aprovação a cada passo.

**Por que antes dos documentos?** O projeto tem uma trava de segurança (o *hook*): a IA **não consegue fazer commit** se `npm run verificar` falhar. Sem frontend e backend criados, ele sempre falha. Então primeiro criamos o "esqueleto" técnico; depois começam os documentos.
**Passo 8. Criar o frontend e o backend vazios**
- Confira antes as versões seguras atuais em `metodo/stack/`.
- Crie as duas pastas:
  - `frontend/`: projeto Next.js
  - `backend/`: projeto NestJS (Perfil A) ou pacote TypeScript interno (Perfil B)
- Cada uma precisa ter três comandos no seu `package.json`: `lint`, `tipos` e `test`.
- **Perfil B:** iniciar também o Supabase local com o Supabase CLI (cria a pasta `supabase/`) e criar projetos Supabase separados para desenvolvimento/preview e produção. Conferir os comandos atuais na documentação oficial.
- ✅ **Pronto quando:** as duas pastas existem e cada uma responde a `npm run lint`, `npm run tipos` e `npm run test`.

**Passo 9. Conferir versões fixas**
- `.nvmrc`: versão do Node.
- `docker-compose.yml` (só Perfil A): versão do PostgreSQL.
- `.github/workflows/ci.yml`: versões das *actions* (trocar `@v4` e `latest` por versões exatas). Perfil B: quando o frontend tiver build, ativar as linhas comentadas que procuram `sb_secret_` no build.
- ✅ **Pronto quando:** não há `latest` nesses arquivos.

**Passo 10. Rodar a verificação completa**
```
npm install
npm run verificar
```
- ✅ **Pronto quando:** termina sem erro.

**Passo 11. Testar a trava (hook)**
- Quebre um teste de propósito e peça à IA: "faça commit".
- ✅ **Pronto quando:** a IA é **bloqueada**. Depois conserte o teste.

**Passo 12. Primeiro commit e envio**
```
git add .
git commit -m "chore: estrutura inicial a partir do dev-playbook vX.Y.Z"
git push -u origin main
```
- ✅ **Pronto quando:** o código aparece no GitHub.

**Passo 13. Proteger a `main` (se o plano do GitHub permitir)**
- No GitHub: exigir PR, CI verde e aprovação antes do merge.
- Se o plano não permitir, anote em `docs/estado.md`: "gates por disciplina".

**Passo 14. Ver o CI funcionar**
- Abra um PR com qualquer mudança pequena e veja as verificações rodarem.
- ✅ **Pronto quando:** o CI fica verde. Se algo falhar por causa do modelo, corrija e leve a correção para o playbook.

---

## Etapa 4: trabalhar no ciclo

A partir daqui, abra sempre o Claude Code **dentro da pasta `sistema-x`**.

**Passo 15. Perguntar o próximo passo**

Comece toda sessão com:
> Leia o `docs/estado.md` e as Issues abertas e diga a fase atual e o próximo passo.

A IA consulta o próximo passo pelo método (skill `/dev-playbook:metodo`) e responde.

**Passo 16. Protótipo e PRD (rota B, a habitual)**

Os prompts estão prontos em `metodo/modelos/prompt-design.md`:

| # | Onde | O que fazer |
|---|---|---|
| 1 | Claude Design | Colar o **Prompt 1 (abertura)** com o brief e os perfis; aprovar a lista de telas e responder às perguntas |
| 2 | Claude Design | Ajustar o protótipo à vontade; ao fim de **cada rodada**, colar o **Prompt 2** (anotar decisões) |
| 3 | Claude Design | Protótipo pronto: colar o **Prompt 3 (fechamento)**, que gera **PRD + inventário + desvios** |
| 4 | Você | Revisar à mão **problema, hipótese e métricas** do PRD (o protótipo não sabe o "porquê") |
| 5 | Claude Code | Rodar `/grill-me` sobre o PRD e responder até não sobrar ponto indefinido |
| 6 | Repositório | Salvar o PRD em `docs/prd.md` e o inventário em `handoff/`; abrir um PR |
| 7 | Quem pediu o sistema | Aprovar o PRD e os **desvios** em relação ao brief. **Gate cumprido** |

*Rota A (PRD primeiro):* escreva o PRD com `metodo/modelos/prd.md`, rode `/grill-me`, aprove; depois use os mesmos 3 prompts, anexando o PRD no lugar do brief.

- ✅ **Pronto quando:** PRD aprovado, inventário em `handoff/` e `docs/estado.md` atualizado.

**Passo 17. Da aprovação do PRD à primeira tarefa** (cada item termina com a sua aprovação)

| # | O que | Modelo (em `metodo/`) |
|---|---|---|
| 1 | **Modelagem de dados** (tabelas e relações) | — |
| 2 | **Threat model**: o que pode dar errado | `modelos/threat-model.md` |
| 3 | **ADRs**: decisões grandes (perfil, stack) | `modelos/adr.md` |
| 4 | **Spec 001**: regras em EARS e contrato da API; depois `/grill-with-docs`; PR só da Spec | `modelos/spec.md` |
| 5 | **Tarefas** + uma Issue para cada | `modelos/tarefas.md` |

**Passo 18. Fazer cada tarefa**
```
plano → você aprova → testes (Red) → você revisa → código (Green)
→ relatório da IA → você explica com suas palavras → PR → merge → /clear
```

**Passo 19. Ao terminar uma Spec**
- Conferir `metodo/fluxo/definicao-de-pronto.md`, fazer a **retro** (`metodo/modelos/retro.md`) e atualizar `docs/estado.md`.

**Passo 20. Antes de lançar a primeira versão**
- Seguir `metodo/fluxo/versoes-e-releases.md` e fazer a auditoria de segurança.

---

## Sempre

- **Aprendeu algo útil para todos os sistemas?** Leve ao repositório do dev-playbook (nunca edite os arquivos do plugin instalado), com uma entrada no `CHANGELOG.md`, e publique uma nova versão.
- **A cada trimestre:** `metodo/checklists/manutencao-do-playbook.md`.
- **Playbook mudou?** `claude plugin update dev-playbook@dev-playbook` e reinicie o Claude Code: todos os sistemas passam a usar a versão nova.

---

## Palavras que aparecem neste roteiro

| Palavra | O que é |
|---|---|
| **Repositório** | A pasta do projeto com o histórico do Git |
| **Workspace** | Uma subparte do projeto com o seu próprio `package.json` (aqui: `frontend` e `backend`) |
| **Hook** | Uma trava automática do Claude Code: roda uma verificação antes de uma ação e pode bloqueá-la |
| **CI** | O robô do GitHub que roda as verificações em cada PR |
| **Gate** | Um ponto de aprovação: só se avança com um "ok" |
| **Brief** | Cinco linhas que ancoram o sistema antes do protótipo: problema, público, objetivo, como medir, fora do escopo |
| **Handoff** | O pacote que sai do protótipo para o código: inventário de telas, estados e regras |
| **`.gitignore`** | Lista do que o Git deve ignorar |
| **`robocopy`** | Comando do Windows para copiar pastas inteiras |
| **Skill** | Um conjunto de instruções (e scripts) que o Claude Code executa quando você digita `/nome-da-skill` |
| **Plugin** | Um pacote instalável do Claude Code que reúne skills e arquivos. O `dev-playbook` é um plugin: traz o método e as skills `novo-sistema` e `metodo` |
| **ADR** | Registro curto de uma decisão grande e do porquê (ex.: por que Perfil B) |

---

## Sem o plugin (alternativas)

- **Cópia local:** copiar `metodo/` para `.dev-playbook/metodo/` dentro do sistema (fora do Git; Passo 5). Com a skill, use o script com `-CopiarMetodo`. Atualizar = apagar e copiar de novo.
- **Pasta ao lado:** deixar o playbook numa pasta ao lado e liberá-lo só para leitura no `.claude/settings.local.json` do sistema (`permissions.additionalDirectories` + bloqueio de edição). Exige caminho absoluto em cada máquina e um teste do bloqueio.
