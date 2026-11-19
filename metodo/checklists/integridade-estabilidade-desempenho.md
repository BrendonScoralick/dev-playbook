# Checklist: integridade, estabilidade e desempenho (padrão)

Números entre parênteses são **exemplos a ajustar**. (?) = confirmar na documentação oficial.

## Integridade
| # | Tema | Padrão | Teste mínimo |
|---|---|---|---|
| I-01 | Clique duplo / reenvio | Chave de idempotência gerada na confirmação, com restrição de unicidade no servidor; botão desativado após o clique | Mesmo pedido duas vezes → um registro, mesmo resultado |
| I-02 | Contadores críticos (saldo, vagas, limites) | Tabela atualizada com `UPDATE` condicional atômico na mesma transação ("diminuir só se houver"); vários registros em **ordem fixa** | Com 1 disponível, dois pedidos simultâneos → exatamente um aceito |
| I-03 | Atomicidade | Operações compostas gravam tudo ou nada | Falha no meio não deixa efeito parcial |
| I-04 | Identificadores | `id` UUID para banco e URLs; número exibido por sequência do banco (pode ter buracos) | Criações simultâneas nunca repetem o número |
| I-05 | Fuso horário | Datas em UTC; exibição e agrupamentos no fuso local | Registro às 23h30 locais entra no dia e mês corretos |
| I-06 | Conciliação | Se há tabela derivada (ex.: saldo), rotina e teste que a comparam com o histórico | Após operações variadas, 100% dos pares batem |

## Estabilidade
| # | Tema | Padrão | Teste mínimo |
|---|---|---|---|
| E-01 | Rede de segurança no banco | Restrições (`CHECK`, `UNIQUE`, chaves estrangeiras) além da validação no código | Gravar valor inválido direto no banco é recusado |
| E-02 | Deadlock | Ordem fixa + nova tentativa (até 2) | Duas operações cruzadas simultâneas terminam sem erro final |
| E-03 | Tempo máximo | Limite por transação, consulta e requisição (ex.: 10 s) | Consulta lenta é interrompida com erro previsível |
| E-04 | Conexões | *Pool* dimensionado (?) | Sob carga, sem esgotar conexões |
| E-05 | Tamanho dos pedidos | Limite do corpo da requisição | Corpo acima do limite → 413 |
| E-06 | Desligamento limpo | Termina requisições em andamento antes de parar (?) | Reinício durante uma operação não deixa efeito parcial |
| E-07 | Saúde e logs | *Health check* (aplicação e banco); logs estruturados com id por requisição | Health indica falha quando o banco cai |
| E-08 | Frontend resiliente | Erro de API mostra estado de erro com "tentar de novo" sem derrubar a tela | Simular erro mantém o menu funcionando |

## Desempenho (decidir agora, medir depois)
- Índices nas colunas de filtro e junção; paginação sempre, com limite máximo; cursor em listas muito grandes.
- Agregações no banco, nunca no frontend; sem N+1.
- Exportações com teto e geração em fluxo (?).
- Registrar consultas lentas (ex.: > 500 ms).
- Frontend: componentes pesados (gráficos) sob demanda; cache de cliente só para dados não sensíveis.
- Teste de carga simples: banco de teste com volume bem maior que o real esperado.
- Regra de ouro: não otimizar no escuro.

## Operação
- Migrações revisadas em PR, testadas com volume e reversíveis.
- Backup com **restore testado**; meta de perda aceitável e tempo de retorno.
- Seed só em desenvolvimento, com dados fictícios.
- Limites de memória e CPU nos contêineres; saber voltar a versão anterior.
- Adiados: SLOs formais, métricas avançadas, *tracing*.
