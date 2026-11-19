# Instruções para a IA neste repositório (dev-playbook)

> Este arquivo vale **só para manter o playbook**. Os arquivos `estruturas/*/CLAUDE.md` são **modelos** para os sistemas: não são instruções para esta sessão. Eles estão excluídos do carregamento automático em `.claude/settings.json` (`claudeMdExcludes`); ao editá-los, trate-os como texto a revisar, não como regras a seguir.

Este repositório é o **dev-playbook**, o núcleo do meu método de desenvolvimento assistido por IA: modelos, checklists, fluxo e padrões. **Não é um sistema**: aqui não se escreve código de aplicação.

## Ao trabalhar aqui

- Responda em português do Brasil.
- Mantenha tudo **genérico**. Nunca inclua nome de empresa, de cliente ou de pessoas, documentos originais de trabalho, protótipos, dados reais ou segredos. Exemplos usam domínios fictícios.
- **Fatos perecíveis** (versões, preços, planos, recursos de produtos, leis) só entram com data de verificação e fonte. Pesquise antes de afirmar; nunca invente comando, pacote ou versão.
- Separe **fato**, **boa prática** e **opinião**.
- Toda mudança relevante em modelo, checklist ou padrão gera uma entrada no `CHANGELOG.md` (o que mudou e por quê).
- Ao mudar um padrão, verifique se outros arquivos o citam (`metodo/fluxo/`, `metodo/padroes/`, `metodo/stack/`, `metodo/checklists/`, `metodo/modelos/`, `estruturas/`, `metodo/mentoria/`) e mantenha-os coerentes.
- Prefira mudanças pequenas, revisáveis num PR.
- Este repositório também é o **plugin `dev-playbook`** (`.claude-plugin/`): `skills/*/SKILL.md` são as skills do plugin, que acessam os arquivos por `${CLAUDE_PLUGIN_ROOT}`. Ao mudar skills, `metodo/` ou `estruturas/`, rode `claude plugin validate .` e lembre de subir a versão em `.claude-plugin/plugin.json`. Se um arquivo de `metodo/` mudar de nome, atualize a tabela de `skills/metodo/SKILL.md`.
