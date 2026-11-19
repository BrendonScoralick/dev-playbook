# Iniciar um sistema novo

Passo a passo para criar um sistema usando o dev-playbook.
Cada passo diz **o que fazer**, **por quê** e **como saber que deu certo**.

> Este roteiro ainda não foi executado de ponta a ponta. O primeiro sistema (de preferência um sistema de treino) vai ajustá-lo.

---

## Visão geral

```
PREPARAR A MÁQUINA     (uma vez só)
        ↓
1. DECIDIR             o que é o sistema, o brief e qual perfil usar
        ↓
2. CRIAR O PROJETO     repositório + cópia do playbook dentro dele
        ↓
3. FUNDAÇÃO TÉCNICA    frontend e backend vazios, mas funcionando
        ↓
4. TRABALHAR NO CICLO  protótipo → PRD → Spec → tarefas → código
```

O **protótipo** acontece no Claude Design, fora do repositório: ele pode começar logo depois da Etapa 1, em paralelo às Etapas 2 e 3.

**Ideia central:** o projeto novo recebe uma **cópia** do playbook. Uma parte vira a base do projeto (vai para o Git); a outra fica só para a IA consultar (fica fora do Git).

---

## Preparar a máquina (uma vez só)

**Passo 1. Instalar as ferramentas**
- Git, Node (versão LTS), Docker, Claude Code, Gitleaks e o `gh` (linha de comando do GitHub).
- Depois de instalar o `gh`, faça login: `gh auth login`.
- ✅ **Pronto quando:** `git --version`, `node --version`, `docker --version` e `gh --version` respondem sem erro.

**Passo 2. Ter o dev-playbook na máquina**
- Clone o seu repositório do playbook numa pasta (ex.: `Desktop\dev-playbook`).
- Dentro dela, reinstale as skills: `npx skills experimental_install`.
- ✅ **Pronto quando:** a pasta `dev-playbook` existe e tem as pastas `metodo` e `estruturas`.

---

## Etapa 1: decidir

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
- Crie um repositório **vazio e privado** e traga-o para a máquina. Pelo terminal:
  ```
  gh repo create meu-usuario/sistema-x --private --clone
  ```
  (Ou crie pelo site do GitHub e use `git clone`.)
- ✅ **Pronto quando:** existe uma pasta `sistema-x` vazia na sua máquina.

**Passo 5. Copiar o playbook para dentro do projeto**

Entre na pasta `sistema-x` e rode os dois comandos (troque o caminho se o seu playbook estiver em outro lugar):
```
robocopy C:\Users\<voce>\Desktop\dev-playbook\estruturas\perfil-a . /E
robocopy C:\Users\<voce>\Desktop\dev-playbook\metodo .dev-playbook\metodo /E
```

O que cada comando faz:

| Comando | Copia | Para quê | Vai para o Git? |
|---|---|---|---|
| 1º | `estruturas/perfil-a` → raiz do projeto | É a **base do sistema**: `CLAUDE.md`, configuração de CI, regras de segurança, `package.json` | **Sim** |
| 2º | `metodo` → `.dev-playbook/metodo` | É a **biblioteca de consulta** da IA: modelos, checklists, padrões | **Não** (ignorado) |

- O `/E` copia também pastas escondidas (as que começam com ponto, como `.github`).
- **Não copie** o `CLAUDE.md` nem o `README.md` da raiz do playbook: eles são regras para manter o playbook, não para construir o sistema.
- ✅ **Pronto quando:** a pasta `sistema-x` tem `CLAUDE.md`, `package.json` e a pasta `.dev-playbook`.

**Passo 6. Preencher os campos dos modelos**

Os arquivos copiados têm espaços para preencher, marcados com `<...>`:

| Arquivo | O que preencher |
|---|---|
| `README.md` | Nome do sistema e "nasceu do dev-playbook v1.0.0" |
| `CLAUDE.md` | Nome e versão; **apagar o comentário do topo** (aquele que diz MODELO) |
| `.github/CODEOWNERS` | Trocar `<responsavel>` pelo usuário do GitHub de quem aprova |
| `CHANGELOG.md` | A data de hoje na versão 0.1.0 |
| `docs/estado.md` | Criar copiando `.dev-playbook/metodo/modelos/estado-do-sistema.md`; fase atual: **Protótipo** (rota B) ou **PRD** (rota A); colar o brief em "Pendências" até o PRD existir |
| `.env` | Criar copiando o `.env.example` e trocando as senhas de exemplo |

- ✅ **Pronto quando:** uma busca por `<` nesses arquivos não encontra mais campos vazios.

**Passo 7. Conferir que a cópia de consulta não vai para o Git**
```
git status
```
- ✅ **Pronto quando:** `.dev-playbook` e `.env` **não aparecem** na lista. (Eles já estão no `.gitignore`.)

---

## Etapa 3: fundação técnica

**Por que antes dos documentos?** O projeto tem uma trava de segurança (o *hook*): a IA **não consegue fazer commit** se `npm run verificar` falhar. Sem frontend e backend criados, ele sempre falha. Então primeiro criamos o "esqueleto" técnico; depois começam os documentos.

**Passo 8. Criar o frontend e o backend vazios**
- Confira antes as versões seguras atuais em `.dev-playbook/metodo/stack/`.
- Crie as duas pastas:
  - `frontend/`: projeto Next.js
  - `backend/`: projeto NestJS (Perfil A) ou pacote simples (Perfil B)
- Cada uma precisa ter três comandos no seu `package.json`: `lint`, `tipos` e `test`.
- ✅ **Pronto quando:** as duas pastas existem e cada uma responde a `npm run lint`, `npm run tipos` e `npm run test`.

**Passo 9. Conferir versões fixas**
- `.nvmrc`: versão do Node.
- `docker-compose.yml`: versão do PostgreSQL.
- `.github/workflows/ci.yml`: versões das *actions* (trocar `@v4` e `latest` por versões exatas).
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
git commit -m "chore: estrutura inicial a partir do dev-playbook v1.0.0"
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

A IA consulta `.dev-playbook/metodo/fluxo/proximo-passo.md` e responde.

**Passo 16. Protótipo e PRD (rota B, a habitual)**

Os prompts estão prontos em `.dev-playbook/metodo/modelos/prompt-design.md`:

| # | Onde | O que fazer |
|---|---|---|
| 1 | Claude Design | Colar o **Prompt 1 (abertura)** com o brief e os perfis; aprovar a lista de telas e responder às perguntas |
| 2 | Claude Design | Ajustar o protótipo à vontade; ao fim de **cada rodada**, colar o **Prompt 2** (anotar decisões) |
| 3 | Claude Design | Protótipo pronto: colar o **Prompt 3 (fechamento)**, que gera **PRD + inventário + desvios** |
| 4 | Você | Revisar à mão **problema, hipótese e métricas** do PRD (o protótipo não sabe o "porquê") |
| 5 | Claude Code | Rodar `/grill-me` sobre o PRD e responder até não sobrar ponto indefinido |
| 6 | Repositório | Salvar o PRD em `docs/prd.md` e o inventário em `handoff/`; abrir um PR |
| 7 | Quem pediu o sistema | Aprovar o PRD e os **desvios** em relação ao brief. **Gate cumprido** |

*Rota A (PRD primeiro):* escreva o PRD com `.dev-playbook/metodo/modelos/prd.md`, rode `/grill-me`, aprove; depois use os mesmos 3 prompts, anexando o PRD no lugar do brief.

- ✅ **Pronto quando:** PRD aprovado, inventário em `handoff/` e `docs/estado.md` atualizado.

**Passo 17. Da aprovação do PRD à primeira tarefa** (cada item termina com a sua aprovação)

| # | O que | Modelo (em `.dev-playbook/metodo/`) |
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
- Conferir `.dev-playbook/metodo/fluxo/definicao-de-pronto.md`, fazer a **retro** (`.dev-playbook/metodo/modelos/retro.md`) e atualizar `docs/estado.md`.

**Passo 20. Antes de lançar a primeira versão**
- Seguir `.dev-playbook/metodo/fluxo/versoes-e-releases.md` e fazer a auditoria de segurança.

---

## Sempre

- **Aprendeu algo útil para todos os sistemas?** Leve ao dev-playbook **original** (nunca à cópia em `.dev-playbook`), com uma entrada no `CHANGELOG.md`.
- **A cada trimestre:** `metodo/checklists/manutencao-do-playbook.md`.
- **Playbook mudou e quer a versão nova no sistema?** Apague a pasta `.dev-playbook` do sistema e copie de novo (Passo 5, segundo comando).

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

---

## Alternativa avançada (sem cópia)

Em vez de copiar o método para `.dev-playbook/`, é possível deixar o playbook numa pasta ao lado e liberá-lo só para leitura no `.claude/settings.local.json` do sistema (`permissions.additionalDirectories` + bloqueio de edição). Exige caminho absoluto em cada máquina e um teste do bloqueio. Use só se a cópia virar problema.
