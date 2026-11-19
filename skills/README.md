# Skills do plugin dev-playbook

Esta pasta contém as **skills do plugin** `dev-playbook` (o repositório inteiro é o plugin: ver `.claude-plugin/`). Cada subpasta com `SKILL.md` vira uma skill chamada `/dev-playbook:<nome>`. Os arquivos do plugin ficam acessíveis às skills por `${CLAUDE_PLUGIN_ROOT}`.

Skills de terceiros adaptadas entram aqui **depois do piloto** (ver `metodo/stack/perfil-a-corporativo.md`, seção "Skills do Claude Code").

## Skills prontas

| Skill | O que faz | Situação |
|---|---|---|
| `/dev-playbook:novo-sistema` | Entrevista (brief, perfil, rota, restrições), copia a estrutura do perfil, preenche modelos, cria `docs/estado.md` e o ADR 0001, entrega o próximo passo e o Prompt 1 do Claude Design preenchido | Script testado (perfis A e B) e plugin instalado em teste; ainda não usada num sistema real |
| `/dev-playbook:metodo` | Índice do método: diz qual arquivo de `metodo/` ler em cada situação (próximo passo, PRD, Spec, testes, revisão, segurança, release) | Nova |

**Instalação:** veja "Instalar o plugin" no `README.md` da raiz. Ao mudar uma skill: `claude plugin validate .` na raiz, nova versão em `.claude-plugin/plugin.json`, commit, tag e push; depois `claude plugin update dev-playbook@dev-playbook`.

## Regra para skill adaptada (fork)

1. Só adaptar uma skill que **provou valor no piloto**.
2. Confirmar a **licença** da origem (tabela abaixo) antes de copiar.
3. Cada skill adaptada começa com um cabeçalho, logo abaixo do frontmatter:

```markdown
<!--
Origem: <owner/repo>/<caminho>  ·  Commit: <hash>  ·  Copiado em: <aaaa-mm-dd>
Licença: <licença>  ·  Autor original: <nome>
Mudanças: <o que foi adaptado ao dev-playbook e por quê>
-->
```

4. Manter o texto da licença original junto da skill quando a licença exigir (MIT exige manter o aviso de copyright).
5. Toda adaptação e atualização entra por **PR** no playbook e gera entrada no `CHANGELOG.md`. Nunca atualizar automaticamente.

## Licenças das origens (verificado em 2026-11-19)

| Origem | Licença | O que isso exige ao adaptar |
|---|---|---|
| mattpocock/skills | MIT | Manter o aviso de copyright e a licença |
| vercel-labs/agent-skills | MIT (declarado no README) | Manter o aviso de copyright e a licença |
| cloudflare/security-audit-skill | MIT | Manter o aviso de copyright e a licença |
| trailofbits/skills | CC BY-SA 4.0 | Atribuição **e** a adaptação deve ser distribuída sob a mesma licença (ShareAlike). Prefira usar a original em vez de adaptar |

Isto é um resumo prático, não aconselhamento jurídico.

## Skills próprias planejadas
- `spec-ears`: escreve e confere critérios EARS, incluindo negativos.
- `revisao-ia`: aplica `metodo/checklists/revisao-codigo-ia.md` ao diff.
- `atualizar-playbook`: executa `metodo/checklists/manutencao-do-playbook.md`.
- `proximo-passo`: lê `docs/estado.md`, as Issues e os arquivos do sistema e responde a fase atual e o próximo passo (hoje coberto pela skill `metodo`).

Criar com a skill `skill-creator`, testando antes de adotar.
