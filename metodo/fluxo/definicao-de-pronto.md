# Definição de pronto

Uma lista só, para você e para a IA. Se algum item não estiver cumprido, a tarefa **não está pronta**.

## Tarefa pronta
- [ ] Atende os critérios (CA-xx) indicados na tarefa, cada um com teste.
- [ ] Testes escritos antes (Red) e agora verdes; nenhum teste alterado para passar.
- [ ] Contrato da API igual ao da Spec (ou mudança aprovada e frontend ajustado no mesmo PR).
- [ ] Autorização no servidor (guard ou RLS) e teste de permissão.
- [ ] Sem segredos, dados reais ou dados pessoais em código, testes ou logs.
- [ ] Estados de tela tratados (carregando, vazio, erro, sem permissão), quando houver tela.
- [ ] `npm run verificar` verde localmente; CI verde no PR.
- [ ] Relatório de tarefa entregue e explicado com minhas palavras (caminho do dado).
- [ ] Diff revisado com `metodo/checklists/revisao-codigo-ia.md`; nada fora do escopo.
- [ ] PR com `Closes #N`, aprovado e mesclado (squash).

## Spec pronta (todas as tarefas)
- [ ] Todas as Issues da Spec fechadas.
- [ ] Teste E2E do fluxo principal, se a Spec criou ou mudou um fluxo de usuário.
- [ ] `CHANGELOG.md` do sistema atualizado (seção "Não lançado").
- [ ] Retro feita (`metodo/modelos/retro.md`); `docs/estado.md` atualizado.

## Release pronta
- [ ] Ver `metodo/fluxo/versoes-e-releases.md`.
