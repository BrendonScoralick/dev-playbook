# dev-playbook

Método pessoal de desenvolvimento de software assistido por IA, do PRD à operação. Todo sistema novo **nasce daqui** e **devolve para cá** o que aprendeu.

Versão do modelo: veja [CHANGELOG.md](CHANGELOG.md).

```
dev-playbook/
├── README.md               este índice
├── CLAUDE.md               regras para a IA ao trabalhar NESTE repositório
├── CHANGELOG.md            versões do modelo
├── skills-lock.json        versões exatas das skills de terceiros
├── metodo/                 TODO o conteúdo do método (documentos .md)
│   ├── fluxo/              como trabalhar
│   │   ├── iniciar-sistema.md       passo a passo para criar um sistema novo
│   │   ├── ciclo.md                 fases, gates, modo rápido, perfil leve
│   │   ├── proximo-passo.md         tabela "se… então o próximo passo é…"
│   │   ├── definicao-de-pronto.md   quando tarefa, Spec e release estão prontas
│   │   ├── versoes-e-releases.md    versão semântica, CHANGELOG do sistema, release
│   │   ├── economia-de-contexto.md  tokens: o que gasta, práticas, onde usar /clear
│   │   └── fluxo-e-glossario.html   fluxograma, comandos do Git e glossário
│   ├── padroes/            regras de engenharia para os dois perfis
│   │   ├── arquitetura-de-pastas.md · contratos-de-api.md · estrategia-de-testes.md
│   ├── stack/              escolhas de tecnologia
│   │   ├── perfil-a-corporativo.md      Perfil A: NestJS + PostgreSQL + Prisma
│   │   ├── perfil-b-supabase-vercel.md  Perfil B: Next.js + Supabase + Vercel
│   │   └── radar.md                     ferramentas guardadas, cada uma com seu gatilho
│   ├── checklists/         inicio-de-sistema · seguranca (S-xx) · integridade-estabilidade-desempenho
│   │                       revisao-codigo-ia · manutencao-do-playbook
│   ├── modelos/            prd · spec · tarefas · relatorio-de-tarefa · estado-do-sistema
│   │                       threat-model · adr · retro · prompt-design
│   └── mentoria/           agente-mentor.md
├── estruturas/             arquivos copiados para o repositório de cada sistema
│   └── perfil-a/           (perfil-b/ entra no primeiro projeto do Perfil B)
├── skills/                 skills próprias e adaptadas; embrião do plugin (v1.1)
└── .claude/                settings.json do playbook; skills instaladas (fora do Git)
```

## Ao clonar este repositório

As skills de terceiros não são versionadas (`.claude/skills/` está no `.gitignore`). Reinstale as versões exatas registradas no `skills-lock.json`:

```
npx skills experimental_install
```

Se o comando acima falhar (ele é experimental), instale uma por uma a partir da origem oficial:

| Skill | Origem | Instalação |
|---|---|---|
| `grill-me` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills add https://github.com/mattpocock/skills --skill grill-me` |
| `grill-with-docs` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills add https://github.com/mattpocock/skills --skill grill-with-docs` |
| `find-skills` | [vercel-labs/skills](https://github.com/vercel-labs/skills) | `npx skills add https://github.com/vercel-labs/skills --skill find-skills` |
| `skill-creator` | [anthropics/skills](https://github.com/anthropics/skills) | `npx skills add https://github.com/anthropics/skills --skill skill-creator` |

Antes de instalar, leia o `SKILL.md` de cada uma: skills rodam com todas as permissões do agente. Skills em avaliação e guardadas estão em `metodo/stack/perfil-a-corporativo.md`, `metodo/stack/perfil-b-supabase-vercel.md` e `metodo/stack/radar.md`.

## Como criar um sistema novo

**Passo a passo completo:** [`metodo/fluxo/iniciar-sistema.md`](metodo/fluxo/iniciar-sistema.md). Resumo:

1. Decidir o perfil (A ou B) e a rota (B, protótipo primeiro, é a habitual); escrever o brief.
2. Criar o repositório do sistema (separado deste).
3. Copiar `estruturas/<perfil>/` para a raiz do sistema e `metodo/` para `.dev-playbook/metodo/` (fora do Git).
4. Preencher os modelos (README com **"nasceu do dev-playbook vX.Y.Z"**, `CLAUDE.md`, `docs/estado.md`) e montar a fundação técnica.
5. Trabalhar no ciclo de `metodo/fluxo/ciclo.md`, guiado por `metodo/fluxo/proximo-passo.md`.
6. Ao aprender algo útil para todos os sistemas, trazer a lição de volta para cá e registrar no `CHANGELOG.md`.

## Regras do playbook

- **Nada de material de empresa ou de cliente** aqui: documentos originais, protótipos, nomes, dados. Só o que é genérico.
- **Fatos perecíveis** (versões, planos, recursos de ferramentas) sempre com a data de verificação e a fonte.
- Cada sistema pode **sobrescrever** um padrão, registrando o motivo num ADR.
