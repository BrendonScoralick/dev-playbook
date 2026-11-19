# Relatório de tarefa: T<n> — <título>

Entregue pela IA ao fim de **cada** tarefa, antes da revisão. Spec: `specs/<NNN>-<nome>/spec.md` · Issue: #<n>

## 1. O que foi feito
<2 linhas> · Critérios atendidos: CA-xx, CA-yy

## 2. O caminho do dado
| Passo | O que acontece | Arquivo |
|---|---|---|
| 1. Tela | <ação do usuário, validação de experiência> | `frontend/src/app/...` |
| 2. Rota | <rota/método, sessão, entrada validada (Zod)> | `.../controller.ts` ou `app/api/.../route.ts` |
| 3. Permissão | <guard ou RLS que decide se pode> | `.../guards/...` ou `supabase/migrations/...` |
| 4. Regra | <regra de negócio aplicada> | `.../<dominio>.service.ts` |
| 5. Banco | <o que é lido/gravado; transação> | `prisma/...` ou `supabase/migrations/...` |
| 6. Resposta | <status e corpo; erros possíveis> | `.../dto/...` |

## 3. Arquivos alterados
| Arquivo | Por quê |
|---|---|

## 4. Decisões
- <decisão> — alternativa descartada: <qual e por quê>

## 5. O que pode dar errado
- <casos de borda, concorrência, permissão, dados inválidos>

## 6. Como testar à mão
1. 
2. 
3. 

## 7. Por onde começar a ler
1. `<arquivo mais importante>`: <por quê>
2. `<segundo arquivo>`: <por quê>

---

**Antes de aprovar (você):** explique a tarefa com suas palavras, em 3 ou 4 frases, seguindo o caminho do dado. Onde travar é o trecho a perguntar ou estudar.
