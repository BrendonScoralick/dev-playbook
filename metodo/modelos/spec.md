# Spec <NNN>: <funcionalidade>

Arquivo: `specs/<NNN>-<funcionalidade>/spec.md` · Plano: `tarefas.md` na mesma pasta
Status: rascunho | em revisão | aprovada · PRD: <link>

## Objetivo
<Uma frase: o que esta funcionalidade entrega.>

## Critérios de aceite (EARS)
Formato: **QUANDO** <evento>, **O SISTEMA DEVE** <resposta>. Todo critério vira teste. Inclua critérios **negativos**.

| ID | Critério | Tipo | Teste |
|---|---|---|---|
| CA-01 | QUANDO ..., O SISTEMA DEVE ... | sucesso | |
| CA-02 | QUANDO ..., O SISTEMA DEVE recusar ... e não alterar nada | negativo | |
| CA-03 | QUANDO um perfil sem permissão ..., O SISTEMA DEVE responder 403 | permissão | |

## Contrato da API
Padrões em `.dev-playbook/metodo/padroes/contratos-de-api.md` (erros em RFC 9457, listas paginadas, datas UTC).

### `<MÉTODO> /<rota>`
- **Perfil exigido:** <perfil / módulo / nível>
- **Entrada:**
```json
{ }
```
- **Respostas:**

| Status | Quando | Corpo |
|---|---|---|
| 201 | Sucesso | `{ "id": "...", "numero": 0 }` |
| 400 | Entrada inválida | Problem Details com `erros[]` |
| 403 | Perfil sem permissão | Problem Details, `codigo: "SEM_PERMISSAO"` |
| 409 | Regra recusada | Problem Details, `codigo: "<CODIGO>"` |

- **Mudança de contrato?** não / compatível / **incompatível** (se incompatível: frontend no mesmo PR)

## Regras de negócio envolvidas
- <R-xx do sistema>

## Permissões (matriz perfil × recurso × ação)
| Perfil | Recurso | Ação | Permitido? |
|---|---|---|---|

## Itens dos checklists que se aplicam
- Segurança: <S-xx>
- Integridade e estabilidade: <I-xx, E-xx>

## Testes de abuso
- <o que um atacante ou usuário mal-intencionado tentaria>

## Fora do escopo desta Spec
- <item>

## Decisões em aberto
- <pergunta> → <quem decide>
