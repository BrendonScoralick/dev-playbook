# Prompts para o Claude Design (protótipo)

Este arquivo tem **3 prompts prontos para copiar** e colar no Claude Design (pelo Claude ou pelo `/design` no VS Code), na ordem em que você vai usá-los:

```
Prompt 1: ABERTURA      → começa o protótipo
Prompt 2: DURANTE       → ao fim de cada rodada de ajustes
Prompt 3: FECHAMENTO    → quando o protótipo estiver pronto (gera PRD, inventário e desvios)
```

**Qual rota você está seguindo?** (ver `metodo/fluxo/ciclo.md`)
- **Rota B, protótipo primeiro (a habitual):** use os 3 prompts. No Prompt 1, preencha o **brief**.
- **Rota A, já existe PRD:** use os 3 prompts. No Prompt 1, troque o brief por "segue o PRD em anexo" e anexe o PRD. No Prompt 3, peça só o inventário e os desvios (o PRD já existe).

Troque tudo que estiver entre `< >`.

---

## Prompt 1: ABERTURA

```
Vamos criar o protótipo navegável de uma aplicação web chamada <nome do sistema>.

BRIEF (a âncora do sistema)
- Problema: <o que dói hoje e para quem>
- Público: <quem usa>
- Objetivo: <o que deve mudar>
- Como medir: <um número que mostre que deu certo>
- Fora do escopo: <o que este sistema não faz>

PERFIS DE USUÁRIO
- <perfil>: pode <...>; não pode <...>
- <perfil>: pode <...>; não pode <...>

PRIMEIRO PASSO (não desenhe ainda)
Responda com: (1) a lista de telas, uma frase cada; (2) os estados de cada tela;
(3) as suposições que você está fazendo; (4) as perguntas que precisa que eu responda.
Espere minha aprovação antes de desenhar.

REGRAS PARA O PROTÓTIPO
- Dados sempre fictícios; nada de nome, logotipo ou dado de pessoa ou empresa real.
- Toda tela trata os estados: carregando, vazio, erro com "tentar de novo", sem permissão,
  validação de formulário, regra recusada e sucesso.
- Mostre como cada tela muda por perfil e inclua uma tela "Sem permissão".
  (Esconder botão é só experiência; a permissão real é validada no servidor.)
- Pense em componentes reutilizáveis (o código será em Next.js, React e Tailwind).
- Responsivo e acessível: rótulos, foco visível, contraste, não depender só de cor,
  gráficos com alternativa em tabela. Textos em português do Brasil.
- Não invente regras de negócio: se faltar algo, liste como suposição ou pergunta.
- Não crie nada que esteja em "Fora do escopo".
```

---

## Prompt 2: DURANTE (ao fim de cada rodada de ajustes)

```
Antes de seguirmos: anote numa lista as decisões desta rodada
(o que mudou, o que entrou, o que saiu, e por quê).
```

**Por quê:** no fechamento, o Claude Design usa essa lista para explicar o PRD e os desvios. Sem ela, os motivos das mudanças se perdem.

---

## Prompt 3: FECHAMENTO (protótipo pronto)

```
O protótipo está pronto. Com base no brief, no protótipo final e na lista de decisões, gere:

1. O PRD, neste formato: <cole aqui o conteúdo de metodo/modelos/prd.md>
   Marque [a confirmar] tudo que o protótipo não permite afirmar, principalmente
   problema, hipótese e métricas. Não invente números.

2. O inventário do protótipo: telas, estados por tela, componentes reutilizáveis,
   textos de mensagem, regras de negócio visíveis e comportamento por perfil.

3. Os desvios em relação ao brief: o que entrou, saiu ou mudou, e por quê.
```

---

## Depois do fechamento (você)

1. **Revise o PRD à mão**, principalmente problema, hipótese e métricas: o protótipo mostra telas, não o "porquê".
2. Rode `/grill-me` sobre o PRD e responda até não sobrarem pontos indefinidos.
3. Salve no repositório do sistema: o PRD em `docs/prd.md` e o inventário em `handoff/` (somente leitura).
4. Leve os **desvios** para aprovação de quem pediu o sistema. Só então o gate do PRD está cumprido.

---

## E depois que o código já existe?

| Situação | Onde ajustar |
|---|---|
| Tela nova ou redesenho grande | No **Claude Design**, com os 3 prompts |
| Ajuste em tela que já existe | **Direto no código**, numa bancada de componentes com dados fictícios (ex.: Storybook, em avaliação no `metodo/stack/radar.md`) |
| Dúvida técnica pontual ("dá para fazer assim?") | Protótipo descartável em código; nunca vira código de produção |

**Regras:**
- Ajuste **visual** (cor, espaçamento, texto): tarefa pequena e um PR.
- Ajuste que muda **regra, campo, fluxo ou permissão**: a **Spec muda antes** (e o contrato da API, se for o caso), depois o código.
- Sistemas de organizações: confirmar se o uso de artifacts é permitido; sempre dados fictícios.
