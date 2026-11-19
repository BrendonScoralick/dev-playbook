# Skills próprias e adaptadas

Pasta para skills do dev-playbook e **embrião do plugin** planejado para a v1.1 (ver `CHANGELOG.md`): em vez de copiar conteúdo para cada sistema, as skills serão instaladas como plugin do Claude Code.

Ainda vazia: as skills entram aqui **depois do piloto** (ver `metodo/stack/perfil-a-corporativo.md`, seção "Skills do Claude Code").

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
- `novo-sistema`: monta o repositório de um sistema a partir de `estruturas/<perfil>/`.
- `spec-ears`: escreve e confere critérios EARS, incluindo negativos.
- `revisao-ia`: aplica `metodo/checklists/revisao-codigo-ia.md` ao diff.
- `atualizar-playbook`: executa `metodo/checklists/manutencao-do-playbook.md`.
- `proximo-passo`: lê `docs/estado.md`, as Issues e os arquivos do sistema e responde a fase atual e o próximo passo (`metodo/fluxo/proximo-passo.md`).

Criar com a skill `skill-creator`, testando antes de adotar.
