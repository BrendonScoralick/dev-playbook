# Radar de ferramentas e práticas

Ferramentas e práticas **consolidadas que não usamos agora**, guardadas para o momento certo. Nada aqui foi descartado: cada item tem o **gatilho** que indica quando vale trazê-lo.
Revisado a cada manutenção trimestral (`metodo/checklists/manutencao-do-playbook.md`). Ao adotar um item, mova-o para `perfil-a-corporativo.md`, registre um ADR no sistema e uma entrada no `CHANGELOG.md`.

Situações: **Pilotar** (próximo a testar) · **Guardado** (usar quando o gatilho acontecer) · **Não verificado** (só citado; pesquisar antes).
Levantamento inicial em 2026-11-19.

## Frameworks de fluxo com IA

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| GitHub Spec Kit | Spec, plano e tarefas via comandos `/speckit.*`; constituição | Quando quiser automatizar a geração dos artefatos do ciclo | **Pilotar** (um de cada vez) |
| Superpowers (Jesse Vincent) | Brainstorm → plano → execução em lotes com parada para revisão | Quando quiser automatizar a condução das fases mantendo a revisão por tarefa | **Pilotar** (um de cada vez) |
| Ponytail | Regras contra excesso de engenharia; marca atalhos com `ponytail:` | Se o código gerado vier inchado demais na fase Green | Guardado (testar numa fatia) |
| BMAD-Method | Agentes com papéis de time (analista, arquiteto, dev) | Ao trabalhar em equipe com papéis distintos | Guardado |
| GSD (Get Shit Done) | Execução em ondas por dependência, contexto isolado | Quando dominar a revisão e precisar de velocidade em tarefas independentes | Guardado |
| Fluxo completo do Matt Pocock: `to-spec`, `to-tickets`, `implement`, `implement-spec`, `wayfinder`, `triage`, `pr`, `retro` | Fluxo concorrente ao nosso, com convenções próprias | Se decidir trocar o passo a passo manual por esse fluxo (escolher qual convenção vence) | Guardado |
| Kiro (Amazon) | IDE com fluxo spec-driven embutido | Se a equipe adotar essa IDE | Guardado (não verificado) |

## Repositórios-modelo (starters) do Perfil B

Para **consulta**, não para iniciar sistemas a partir deles (ver `perfil-b-supabase-vercel.md`).

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| NextBase Starter (comunitário, MIT) | Next.js 16 + Supabase em monorepo Turborepo, com Vitest, Playwright e Changesets | Dúvida de organização de monorepo no Perfil B | Guardado (consulta) |
| next-forge (modelo listado na Vercel) | Monorepo Turborepo completo para Next.js (usa Neon e Clerk, não Supabase) | Dúvida de organização de monorepo em geral | Guardado (consulta) |
| Turborepo Launchpad, nexpo | Starters comunitários (Next.js 14; Next.js + app móvel) | Só se houver app móvel (nexpo) | Guardado (desatualizado ou fora do escopo) |

## Skills avulsas

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| Storybook | Bancada de componentes: cada componente e estado (carregando, vazio, erro, sem permissão) isolado, com dados fictícios | Primeiro sistema com telas no código; ajustes de UI depois do protótipo | **Pilotar** |
| `/design-sync` (Claude Code) | Sincroniza o design system entre o repositório e o Claude Design (segundo fontes de terceiros) | Reduzir o retrabalho entre protótipo e código; testar se cobre telas inteiras | Guardado (não verificado) |
| `caveman` (juliusbrussee) | Respostas telegráficas; variantes para commit, revisão e compressão de arquivos de memória | Custo virar problema **medido** (`/cost`) e você já dominar a revisão (respostas curtas atrapalham o aprendizado). Autor diz ~65% de saída; teste independente da JetBrains (86 tarefas, jul/2026) mediu **8,5%** | Guardado |
| Otimizadores de contexto (Token Optimizer, claude-context-optimizer, padrão "Skill Vault") | Atacam configurações, skills e memória que inflam o contexto | Muitas skills instaladas ou sessões lentas/caras; todos os números são do próprio autor | Guardado (não verificado) |
| `bashOutputMaxChars` (configuração nativa) | Limita quanto da saída de um comando volta ao agente | Logs gigantes entrando no contexto; cuidado para não cortar a saída útil dos testes | Guardado (testar no piloto) |
| `research` (mattpocock) | Investiga uma pergunta em fontes primárias e salva com citações | Pesquisas de decisão técnica (ADR) | Guardado |
| `improve-codebase-architecture` (mattpocock) | Procura oportunidades de melhorar a arquitetura | Sistema com algumas semanas de código e sinais de desorganização | Guardado |
| `to-questionnaire` (mattpocock) | Transforma uma decisão travada num questionário para a pessoa certa | Quando precisar de respostas do responsável/gestor | Guardado |
| `writing-for-agents` (mattpocock) | Como escrever skills, `CLAUDE.md` e documentos para agentes | Ao criar as skills próprias do playbook | Guardado |
| `wizard` (mattpocock) | Gera assistente interativo para passos que só humanos fazem | Configurações manuais repetidas (ex.: criar repositório) | Guardado |
| `prototype` (mattpocock) | Protótipo descartável para responder uma dúvida de design | Dúvida técnica antes da Spec | Guardado |
| `agent-browser` (Vercel) | Automação de navegador para o agente | Verificação visual de telas pelo agente, além do Playwright | Guardado |
| `frontend-design` (Anthropic) | Interfaces com visual distintivo | Projeto sem ferramenta de design | Guardado |
| `composition-patterns`, `react-view-transitions`, `writing-guidelines` (Vercel) | Padrões de composição React, animações de transição, revisão de texto | Frontend crescendo / animações / documentação longa | Guardado |
| `vercel-optimize`, `deploy-to-vercel` (Vercel) | Custo, desempenho e deploy na Vercel | Se a hospedagem for Vercel | Guardado |
| `react-native-guidelines` (Vercel) | Boas práticas de React Native | Se houver app móvel | Guardado |
| Skills Azure (`microsoft/azure-skills`) | Infraestrutura, migração e Kubernetes na Azure | Se a nuvem for Azure | Guardado |
| `understand-anything` | Gera documentação de um sistema legado | Ao assumir um sistema existente sem documentação | Guardado (não verificado) |
| "Akita memory", "elephant goldfish model" | Citados em comentários como técnicas de memória/contexto | — | Não verificado |

## MCP (conexões do agente com ferramentas e dados)

Regras obrigatórias em `metodo/checklists/seguranca.md` (S-32). Nomes exatos, versões e instalação: verificar na hora do piloto.

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| Documentação atualizada: Context7 (mais conhecido) ou Ref (focado em economia de tokens); outros: DeepWiki, Docfork | O agente consulta a documentação da versão atual das bibliotecas | Primeiro sistema com a stack padrão (reduz API inventada ou versão velha) | **Pilotar comparando dois**. Atenção: o Context7 teve falhas de *prompt injection* em 2026 (ContextCrush, fev.; CVE-2026-75130, ago.), porque a documentação vem de fontes enviadas pela comunidade. Usar só versão corrigida, restringir às bibliotecas da stack e tratar o retorno como dado (S-32). Alternativa sem MCP: o agente busca a documentação oficial da versão fixada (verificado em 2026-11-19) |
| Playwright | O agente navega pelas telas e confere estados | Testes E2E e conferência das telas do protótipo | Guardado |
| PostgreSQL | Leitura do esquema e dos dados | Depurar o modelo de dados; **só leitura, só banco local de desenvolvimento** | Guardado |
| GitHub | Issues, PRs e revisões pelo agente | Se o `gh` (linha de comando) não bastar | Guardado |
| Sentry (ou similar) | Leitura de erros de produção | Sistema no ar, com dados anonimizados | Guardado |

## Segurança e qualidade

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| SonarQube | Qualidade e segurança com visão corporativa | Se a organização já usar | Guardado |
| Strix | Pentest com agentes de IA (teste dinâmico) | Sistema no ar, **em ambiente próprio e com autorização** | Guardado |
| DAST (teste dinâmico de segurança) | Ataca a aplicação rodando | Antes de expor o sistema à internet | Guardado |
| axe (testes de acessibilidade) | Verificação automática de acessibilidade nas telas e no E2E | Telas com exigência de acessibilidade (protótipo pede) | Guardado |
| commitlint | Força o padrão de mensagem de commit | Mensagens fora do padrão virarem problema | Guardado |
| Renovate | Atualizador de dependências mais configurável que o Dependabot | Dependabot não atender (agrupamentos, regras finas) | Guardado |
| Mutation testing | Mede se os testes pegam mudanças no código | Suíte de testes madura e regras críticas estáveis | Guardado |

## Processo e operação

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| Testes de contrato entre serviços (ex.: Pact) | Garantem que consumidor e provedor concordam com o contrato | Quando houver mais de um serviço ou consumidores externos | Guardado |
| Contrato escrito primeiro em OpenAPI (*design-first*) | O OpenAPI é escrito antes do código e gera esqueleto e tipos | Quando outro time ou cliente externo precisar do contrato antes da implementação | Guardado |
| Tipos do frontend gerados do OpenAPI | Gera os tipos TypeScript do cliente a partir da documentação da API | Quando a duplicação de tipos entre front e back incomodar (alternativa ao monorepo de schemas) | Guardado |
| Versionamento de API (`/v1`) | Mantém versões antigas para clientes que não atualizam | Quando houver clientes externos ou apps que não atualizam junto | Guardado |
| Painel de estado automático (GitHub Action) | Atualiza um painel a cada merge, sem nenhum "ok" manual | Muitos sistemas em paralelo ou equipe acompanhando o andamento | Guardado |
| Stacked PRs | PRs encadeados, um por tarefa, revisados em sequência | Quando dominar o fluxo básico de PR e quiser paralelizar a revisão | Guardado |
| Multiagentes / orquestrador | Um agente coordena outros por área | Depois de dominar Spec, testes e revisão; decisões em arquivos para manter coerência | Guardado |
| Feature flags | Ligar e desligar funcionalidades sem deploy | Releases graduais ou testes com parte dos usuários | Guardado |
| SLOs formais, métricas avançadas, *tracing* | Metas de serviço e observabilidade detalhada | Sistema em uso real | Guardado |
| Schemas Zod compartilhados (`packages/schemas`, monorepo) | Um schema para frontend e backend | Quando a duplicação de validação incomodar | Guardado (decidir em ADR) |
| **Plugin do Claude Code + marketplace no próprio dev-playbook** | Empacota as skills e o método; cada sistema declara o plugin em vez de copiar conteúdo | — | **Adotado na v1.1.0** (ver README, "Instalar o plugin"); hooks continuam por sistema |
| Repositório-modelo do GitHub (template repository) | "Usar este modelo" para criar sistemas | Quando as `estruturas/` estabilizarem | Guardado |
| Rotina agendada de manutenção (skill `schedule`) | Agente na nuvem que abre PR de atualização | Depois de algumas manutenções manuais confiáveis | Guardado |

## IA dentro do produto

| Item | O que é | Gatilho para usar | Situação |
|---|---|---|---|
| RAG | A IA consulta seus documentos antes de responder | Sistema com busca ou assistente sobre documentos | Guardado (pesquisar na hora) |
| Fine-tuning | Treinar um modelo com seus exemplos | Necessidade comprovada que prompt e RAG não resolvem | Guardado |

## Não usar (com motivo)

- `reddit-automation` e automação de redes sociais: risco de uso indevido.
- Cópias de "superpowers"/`ai-image-generation` de donos diversos: nomes parecidos, origem incerta.
- Cópia `xlsx` do npm (SheetJS): abandonada, com vulnerabilidades.
