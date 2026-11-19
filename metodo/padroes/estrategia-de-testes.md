# Estratégia de testes (padrão)

Todo critério da Spec vira pelo menos um teste. Os testes são escritos **antes** do código (Red) e nunca alterados para passar.

## O que testar em cada camada

| Camada | Tipo | Ferramenta | O que cobre | Quantidade |
|---|---|---|---|---|
| Service (regra de negócio) | Unitário | Jest (Perfil A) / Vitest (Perfil B) | Regras, casos de borda, recusas | **Muitos** |
| Rota da API + banco real | Integração | Supertest (A) / testes de rota (B) | Contrato (status **e formato**), permissão (403), transação, concorrência | Um conjunto por endpoint |
| Políticas de RLS (Perfil B) | Banco | ferramenta de teste de RLS (verificar, ex.: pgTAP) | Usuário A não lê nem altera dado de B | Uma por tabela e operação |
| Componentes e telas | Unitário de interface | Vitest + Testing Library | Estados (carregando, vazio, erro, sem permissão), validação de formulário | Os estados do inventário |
| Fluxo completo | E2E | Playwright | Só os **fluxos principais** e 1–2 abusos | **Poucos** |

## Testes obrigatórios por tipo de regra
- **Permissão:** cada ação protegida tem um teste com perfil sem permissão (403) e um de IDOR (recurso de outro usuário).
- **Contador/saldo crítico:** teste de concorrência (dois pedidos simultâneos) e de atomicidade.
- **Exportação:** teste com texto iniciado por `=`, `+`, `-` ou `@`.
- **Entrada:** valores-limite (zero, negativo, muito grande, vazio, caracteres especiais).

## Convenções
- **Nome do teste = o critério**, em português: `"recusa a saída quando o saldo é insuficiente (CA-02)"`.
- Estrutura **Dado / Quando / Então** (Arrange / Act / Assert).
- **Dados fictícios** criados por funções de fábrica nos próprios testes; nunca dados reais. O seed é só para desenvolvimento.
- Banco de teste **separado** do de desenvolvimento, limpo entre testes.
- Teste não depende da ordem de execução nem do relógio real (fixar data quando importar).
- Um teste quebrando pelo motivo errado (conexão, configuração) é corrigido antes de qualquer código.

## O que não fazer
- Testar detalhes internos em vez do que a interface promete.
- Perseguir porcentagem de cobertura como meta; a meta é **todo critério com teste**.
- Mockar o banco nos testes de integração (o objetivo deles é justamente o banco real).
