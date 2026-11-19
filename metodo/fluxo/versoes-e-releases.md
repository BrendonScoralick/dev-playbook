# Versões e releases dos sistemas

## Versão semântica: `MAIOR.MENOR.CORREÇÃO`
| Muda… | Quando | Exemplo |
|---|---|---|
| CORREÇÃO (`1.2.3` → `1.2.4`) | Só correções, sem mudança de comportamento esperado | Saldo exibido errado corrigido |
| MENOR (`1.2.3` → `1.3.0`) | Funcionalidade nova compatível | Novo relatório |
| MAIOR (`1.2.3` → `2.0.0`) | Mudança incompatível (contrato quebrado, dado migrado sem volta) | Rota antiga removida |
Antes da primeira entrega estável, usar `0.x.y`.

## Durante o desenvolvimento
- Cada Spec concluída acrescenta itens à seção **"Não lançado"** do `CHANGELOG.md` do sistema (Adicionado, Alterado, Corrigido, Segurança).
- Texto para quem usa o sistema, não para programadores.

## Checklist de release
- [ ] CI verde na `main`; nenhum PR pendente que deveria entrar.
- [ ] Antes do primeiro release: auditoria de segurança (S-31).
- [ ] Migrações testadas com volume e com caminho de volta; **backup feito e restaurável**.
- [ ] `CHANGELOG.md`: "Não lançado" vira a nova versão com data.
- [ ] Tag no Git (`git tag v1.3.0`) e release no GitHub com as notas do CHANGELOG.
- [ ] Deploy; conferir o health check e um fluxo principal em produção.
- [ ] Plano de volta: qual versão restaurar e como, se algo der errado.
- [ ] `docs/estado.md` atualizado.

## Freelance
- Cada entrega ao cliente corresponde a uma versão com notas do CHANGELOG em linguagem simples.
- Combinar no contrato o que conta como correção (sem custo) e o que é funcionalidade nova.
