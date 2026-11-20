---
name: novo-sistema
description: Cria um sistema novo a partir do dev-playbook. Entrevista o usuário (brief, perfil A ou B, rota de protótipo ou PRD, responsável, restrições), copia a estrutura do perfil, preenche os modelos, cria docs/estado.md e o ADR 0001 e entrega o próximo passo. Use quando o usuário pedir para iniciar, criar ou começar um sistema, projeto ou repositório novo com o dev-playbook.
---

# /dev-playbook:novo-sistema

Automatiza o início de um sistema conforme `${CLAUDE_PLUGIN_ROOT}/metodo/fluxo/iniciar-sistema.md` (Etapas 1 e 2 e preparação da Etapa 4). Responda sempre em português do Brasil.

Os arquivos do plugin estão em `${CLAUDE_PLUGIN_ROOT}`: estruturas em `${CLAUDE_PLUGIN_ROOT}/estruturas/`, método em `${CLAUDE_PLUGIN_ROOT}/metodo/`, script em `${CLAUDE_PLUGIN_ROOT}/skills/novo-sistema/scripts/novo-sistema.ps1`.

**Gates:** pare e espere a confirmação do usuário nos pontos marcados com **[GATE]**. Nunca faça commit, push, criação de repositório no GitHub ou instalação de dependências sem pedido explícito.

## 0. Conferências
1. A pasta atual deve ser a pasta **do sistema novo**, vazia (pode ter só `.git`). Se não estiver vazia, pare e pergunte qual pasta usar.
2. O script do passo 2 é **PowerShell para Windows** (usa `robocopy`). Em macOS ou Linux, faça a cópia e o preenchimento à mão seguindo `${CLAUDE_PLUGIN_ROOT}/metodo/fluxo/iniciar-sistema.md` (passos 5 a 7) e avise o usuário.
3. Confira se as skills `/grill-me` e `/grill-with-docs` estão disponíveis (o método as usa nos gates do PRD e da Spec). Se não estiverem, informe o comando de instalação do passo 2 de `iniciar-sistema.md`; não instale sem pedido.

## 1. Entrevista (uma pergunta por vez)
Faça as perguntas uma de cada vez, no estilo de interrogatório: se a resposta for vaga, pergunte de novo até ficar clara. Não responda no lugar do usuário; ofereça opções só quando houver escolha fechada.

1. **Nome** do sistema.
2. **Brief** (5 linhas): problema, público, objetivo, como medir (um número), fora do escopo.
3. **Perfil**, explicando os critérios:
   - **A, corporativo** (NestJS + PostgreSQL): sistema de organização, regras de negócio complexas, equipe, exigências de infraestrutura da empresa.
   - **B, enxuto** (Next.js + Supabase + Vercel): pessoal, freelance ou MVP; time de uma pessoa; hospedagem simples. Lembre: Vercel Hobby é só uso não comercial (cliente pago exige plano Pro).
4. **Rota**: **B, protótipo primeiro** (habitual: descobrir desenhando) ou **A, PRD primeiro** (problema e regras já definidos por um documento).
5. **Responsável** pela aprovação (usuário do GitHub) e se a `main` poderá ser protegida.
6. **Restrições**: prazo, uso de IA permitido (Claude Code, artifacts, MCPs), dados pessoais (LGPD), quem é o dono das contas (freelance).

**[GATE]** Mostre um resumo das respostas e as decisões (perfil e rota) com o motivo de cada uma. Só siga com "ok".

## 2. Criar a base (script)
Execute, a partir da pasta do sistema:
```
powershell -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/skills/novo-sistema/scripts/novo-sistema.ps1" -Playbook "${CLAUDE_PLUGIN_ROOT}" -Perfil <a|b> -Nome "<nome>" -Responsavel "<usuario-github>"
```
O script copia `estruturas/perfil-<a|b>/` para a raiz, preenche nome, versão do plugin, data, responsável e o repositório do playbook no `.claude/settings.json`, cria `.env` e `docs/estado.md` e roda `git init` se necessário. Se ele falhar, mostre o erro e pare.
(Uso sem o plugin: acrescente `-CopiarMetodo` para copiar o método para `.dev-playbook/metodo/`, fora do Git.)

## 3. Preencher os documentos iniciais
1. **`docs/estado.md`**: preencha rota, fase (rota B: **Protótipo**; rota A: **PRD**), o brief, as pendências levantadas na entrevista e o próximo passo. Apague as linhas de exemplo do modelo.
2. **`docs/adr/0001-perfil-e-rota.md`**: crie a partir de `${CLAUDE_PLUGIN_ROOT}/metodo/modelos/adr.md` com o contexto (brief e restrições), a decisão (perfil e rota), as alternativas descartadas e as consequências. Status: aceito.
3. Rota A: crie `docs/prd.md` a partir de `${CLAUDE_PLUGIN_ROOT}/metodo/modelos/prd.md`, só com o que a entrevista permite afirmar; o resto fica `[a confirmar]`.

## 4. Conferir
1. Rode `git status --short` e confirme que **`.env` não aparece** (nem `.dev-playbook/`, se tiver sido copiado). Se aparecer, pare: o `.gitignore` está errado.
2. Liste os arquivos ainda com campos a preencher apontados pelo script.

## 5. Entregar o próximo passo
Mostre em poucas linhas:
1. O que foi criado (árvore resumida).
2. **Fundação técnica** (`iniciar-sistema.md`, Etapa 3): criar `frontend/` e `backend/`, conferir versões seguras atuais antes de instalar, `npm run verificar` passando. Até lá, o hook do `.claude/settings.json` bloqueia commits feitos pela IA; o primeiro commit pode ser feito pelo usuário. Ofereça conduzir essa etapa com aprovação a cada passo.
3. **Rota B:** o **Prompt 1 (abertura)** de `${CLAUDE_PLUGIN_ROOT}/metodo/modelos/prompt-design.md` **já preenchido** com o nome, o brief e os perfis de usuário informados, pronto para colar no Claude Design.
4. **Rota A:** revisar o `docs/prd.md` e rodar `/grill-me`.
5. Criar o repositório remoto no GitHub (privado) e o primeiro push: só se o usuário pedir.

## Regras
- Nunca invente versões de pacotes, comandos ou recursos: consulte a documentação oficial quando precisar.
- Nunca leia nem exiba o conteúdo do `.env`.
- Nunca altere arquivos do plugin.
- Dados de exemplo sempre fictícios.
