---
name: metodo
description: Método de trabalho do dev-playbook para sistemas criados com ele. Use ao decidir o próximo passo do ciclo; escrever ou revisar brief, protótipo, PRD, Spec (EARS e contrato da API), threat model, ADR, tarefas, relatório de tarefa, retro ou estado do sistema; escrever testes; revisar código gerado por IA; tratar autenticação, permissões, dados pessoais, exportações, concorrência ou estabilidade; escolher stack, perfil A ou B, bibliotecas, skills ou MCPs; preparar um release.
---

# Método do dev-playbook

Os arquivos do método estão em `${CLAUDE_PLUGIN_ROOT}/metodo/`. **Leia só o arquivo que a situação pede**, no momento em que pede. São somente leitura: nunca os altere a partir de um sistema; melhorias vão para o repositório do dev-playbook.

Quando um arquivo do método citar `metodo/...`, o caminho completo é `${CLAUDE_PLUGIN_ROOT}/metodo/...`.

## Qual arquivo ler

| Situação | Arquivo |
|---|---|
| Início de sessão: qual é o próximo passo? (junto com `docs/estado.md` e as Issues) | `metodo/fluxo/proximo-passo.md` |
| Entender o ciclo, as fases, os gates e as duas rotas (protótipo primeiro ou PRD primeiro) | `metodo/fluxo/ciclo.md` |
| Começar um sistema novo (prefira a skill `/dev-playbook:novo-sistema`) | `metodo/fluxo/iniciar-sistema.md` |
| Protótipo no Claude Design (brief, Prompt 1, 2 e 3) | `metodo/modelos/prompt-design.md` |
| Escrever ou revisar o PRD | `metodo/modelos/prd.md` |
| Escrever ou revisar uma Spec | `metodo/modelos/spec.md` e `metodo/padroes/contratos-de-api.md` |
| Planejar tarefas | `metodo/modelos/tarefas.md` |
| Threat model | `metodo/modelos/threat-model.md` e `metodo/checklists/seguranca.md` |
| Registrar uma decisão grande | `metodo/modelos/adr.md` |
| Atualizar `docs/estado.md` | `metodo/modelos/estado-do-sistema.md` |
| Escrever testes | `metodo/padroes/estrategia-de-testes.md` |
| Fim de uma tarefa | `metodo/modelos/relatorio-de-tarefa.md` e `metodo/fluxo/definicao-de-pronto.md` |
| Revisar código gerado pela IA | `metodo/checklists/revisao-codigo-ia.md` |
| Autenticação, permissões, dados pessoais, exportação, MCP | `metodo/checklists/seguranca.md` |
| Concorrência, idempotência, desempenho, estabilidade | `metodo/checklists/integridade-estabilidade-desempenho.md` |
| Pastas, módulos, onde fica cada coisa | `metodo/padroes/arquitetura-de-pastas.md` |
| Stack e bibliotecas: Perfil A (NestJS) | `metodo/stack/perfil-a-corporativo.md` |
| Stack e bibliotecas: Perfil B (Supabase + Vercel) | `metodo/stack/perfil-b-supabase-vercel.md` |
| Ferramenta nova, ou uma que não está no padrão | `metodo/stack/radar.md` |
| Fim de uma Spec | `metodo/modelos/retro.md` |
| Preparar um release | `metodo/fluxo/versoes-e-releases.md` |
| Sessão longa, custo ou contexto | `metodo/fluxo/economia-de-contexto.md` |
| Início de sistema: perguntas e preparação | `metodo/checklists/inicio-de-sistema.md` |

## Regras
- Fatos perecíveis (versões, planos, recursos de ferramentas) nos arquivos têm data de verificação: confira na fonte oficial antes de usar.
- Se um arquivo não existir, diga que não encontrou; não suponha o conteúdo.
