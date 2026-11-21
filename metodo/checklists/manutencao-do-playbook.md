# Checklist: manutenção do dev-playbook

**Quando:** a cada trimestre e antes de iniciar um sistema novo.
**Como:** manualmente, pedindo à IA "atualize o dev-playbook seguindo `metodo/checklists/manutencao-do-playbook.md`". Depois que o processo estiver confiável, pode virar uma rotina agendada (skill `schedule`) que **abre um PR**; nunca merge automático.

## 1. Fatos perecíveis
- [ ] Listar os fatos verificados há mais de 90 dias (ou nunca verificados) em `metodo/stack/perfil-a-corporativo.md`, `metodo/stack/perfil-b-supabase-vercel.md` e `metodo/stack/radar.md`.
- [ ] Reverificar cada um em fonte **oficial** (avisos de segurança, documentação, página de planos).
- [ ] Atualizar a data, a confiança e a fonte; marcar o que mudou.

## 2. Skills
- [ ] Para cada skill adaptada em `skills/`: comparar o commit de origem com o atual e listar as mudanças relevantes.
- [ ] Para cada skill "em avaliação": decidir com base nas retros (promover, manter ou descartar).
- [ ] Conferir avisos de segurança das origens e se alguma foi abandonada ou trocou de dono.

## 3. Radar (`metodo/stack/radar.md`)
- [ ] Algum gatilho aconteceu? Mover o item para "Pilotar".
- [ ] Algum item ficou obsoleto ou perdeu manutenção? Anotar e, se for o caso, mover para "Não usar" com o motivo.
- [ ] Ferramentas novas que surgiram entram aqui primeiro, nunca direto no padrão.

## 4. Práticas e ferramentas
- [ ] Pesquisar mudanças no Claude Code e nas ferramentas da stack que afetem o fluxo.
- [ ] Separar **fato com fonte oficial** de **relato/tendência**. Tendência só entra como "em avaliação".

## 5. Lições dos sistemas
- [ ] Ler as retros dos sistemas desde a última manutenção.
- [ ] Levar ao playbook só as lições que valem para todos.

## 6. Entrega
- [ ] Tudo num **PR** no dev-playbook, com o diff, o motivo de cada mudança e as fontes.
- [ ] Entrada no `CHANGELOG.md` e nova versão (tag) após o merge.
- [ ] Você lê e aprova; a IA não aprova o próprio PR.
