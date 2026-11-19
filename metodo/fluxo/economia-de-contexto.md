# Economia de contexto (tokens)

Contexto demais custa mais **e** piora a qualidade: o agente perde o foco e esquece regras. Regra de ouro: **dar ao agente só o que a tarefa precisa, quando precisa.**

## O que mais gasta (em ordem)
1. **Retrabalho:** código sem plano, refeito várias vezes.
2. **Conversas longas** acumulando tarefas antigas, saídas e tentativas erradas.
3. **Contexto fixo inchado:** `CLAUDE.md` longo, skills e MCPs instalados sem uso.
4. **Saídas enormes:** logs completos, testes com milhares de linhas, arquivos inteiros sem necessidade.

## Práticas

| Prática | Como |
|---|---|
| Uma tarefa por sessão | Ao revisar e aprovar a tarefa: `/clear`. Para continuar a mesma tarefa numa conversa longa: `/compact` |
| Plano antes do código | Modo plan; plano aprovado evita refazer |
| Contexto apontado | "Leia `specs/<NNN>/spec.md` e `tarefas.md`; faça a T2", em vez de "entenda o projeto" |
| `CLAUDE.md` curto | Só regras essenciais; detalhes em arquivos lidos quando necessário |
| Poucas skills e MCPs | Instalar só os adotados (`metodo/stack/perfil-a-corporativo.md`); o resto fica no `radar.md` |
| Subagentes para explorar | Buscas amplas num subagente, que devolve só o resumo |
| Modelo e esforço por tarefa | Mais leve para tarefas mecânicas; o mais forte para Spec, plano e revisão |
| Saídas filtradas | "Rode os testes e mostre só as falhas"; não colar logs inteiros |
| Passagem entre sessões | Resumo curto (ex.: skill `handoff`, no radar) em vez de reler tudo |
| Cache de prompt | Não editar o `CLAUDE.md` no meio da sessão: o começo estável da conversa é reaproveitado |
| Medir | `/cost` mostra o gasto da sessão |

## Onde o `/clear` entra no ritmo

```
plano → aprovo → Red → reviso testes → Green → reviso diff → commit → PR → /clear → próxima tarefa
```
- **Não** limpar entre o Red e o Green da mesma tarefa: o agente precisa lembrar dos testes que escreveu e do plano.
- **Sim** limpar depois da tarefa aprovada: a próxima começa lendo a Spec e o `tarefas.md`, que são a memória oficial.

## Ferramentas de economia: lição
Skills de "economia de tokens" prometem de 40% a 96%, quase sempre com benchmark do próprio autor. Exemplo: o `caveman` anuncia ~65% menos tokens de saída; um teste independente da JetBrains (86 tarefas, jul/2026) mediu **8,5%**, porque em programação a maior parte do texto é código e chamadas de ferramenta, que ele não mexe. **Benchmark do autor não é evidência.** A economia que mais pesa vem das práticas acima (retrabalho e contexto). Ferramentas de economia ficam no `metodo/stack/radar.md`.

## Não economizar no essencial
Cortar a Spec, os critérios ou o contrato para "poupar" gera código errado, ou seja, retrabalho. Preços e limites de plano mudam: consultar a fonte oficial quando importar.
