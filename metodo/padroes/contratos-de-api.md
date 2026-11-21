# Contratos de API (padrão)

O **contrato** é o acordo entre frontend e backend: rota, entrada, saída, erros e permissão. Ele é decidido **na Spec, antes do código**, e mudar o contrato é uma decisão registrada, nunca um efeito colateral.

## Onde o contrato vive

| Camada | Papel |
|---|---|
| Seção "Contrato" da Spec (`specs/<NNN>/spec.md`) | **Fonte da decisão**, aprovada no gate da Spec |
| Schema Zod de entrada (`<módulo>/schemas/`) | Implementa a entrada |
| DTO de saída (`<módulo>/dto/`) | Implementa a saída, sem campos internos (S-15) |
| OpenAPI (Swagger) gerado a partir do código | Documentação navegável da API (pesquisar a integração com Zod antes de implementar) |
| Testes de integração (Supertest) | Conferem status **e formato** da resposta |

## Formatos padrão

**Erros: Problem Details (RFC 9457)**, com `Content-Type: application/problem+json`:

```json
{
  "type": "https://<sistema>/erros/saldo-insuficiente",
  "title": "Saldo insuficiente",
  "status": 409,
  "detail": "Disponível: 3 unidades; solicitado: 5.",
  "codigo": "SALDO_INSUFICIENTE"
}
```
- `codigo` é um campo extra estável que o frontend usa para decidir a mensagem; `detail` é para pessoas.
- Erros de validação acrescentam `erros: [{ campo, mensagem }]`.
- Nunca rastro de pilha, nome de tabela ou detalhe interno (S-16).

**Status HTTP usados**

| Situação | Status |
|---|---|
| Criado | 201 (corpo com `id` e, se houver, `numero`) |
| Lido / atualizado | 200 |
| Sem corpo | 204 |
| Entrada inválida | 400 (ou 422, escolher um por sistema e manter) |
| Sem sessão | 401 |
| Sem permissão | 403 |
| Não encontrado (ou recurso alheio, se o sistema decidir esconder) | 404 |
| Regra de negócio recusada (saldo, duplicidade, estado) | 409 |
| Limite de requisições | 429 |

**Listas e paginação**
```json
{ "itens": [ ... ], "total": 120, "pagina": 1, "tamanho": 20 }
```
- `tamanho` com limite máximo (S-18). Listas muito grandes podem usar cursor (`{ itens, proximoCursor }`), decidido na Spec.

**Outros**
- Datas em ISO 8601 com fuso (UTC): `2026-11-19T14:30:00Z`.
- Identificadores: `id` UUID; número exibido separado (`numero`).
- Nomes de campos em camelCase, no idioma escolhido para o sistema (um só).
- Dinheiro, se houver: inteiro em centavos ou decimal como texto, nunca ponto flutuante.
- Caminho e query sem dado pessoal, de saúde ou token: o endereço vai para o histórico do navegador e para os registros dos servidores (S-34). Buscas com filtros pessoais (ex.: CPF) usam uma rota de busca com os filtros no corpo, decidida na Spec.

## Mudança de contrato

| Tipo | Exemplos | Regra |
|---|---|---|
| **Compatível** | Novo campo opcional na saída; novo endpoint | Pode entrar com a Spec atualizada |
| **Incompatível (quebra)** | Remover ou renomear campo; mudar tipo, significado ou status; tornar obrigatório um campo de entrada | Exige Spec nova ou revisada no gate, frontend ajustado **no mesmo PR** e registro no CHANGELOG do sistema |

Versionamento de URL (`/v1`) só quando houver clientes externos (ver `metodo/stack/radar.md`).

## Interface de módulo (dentro do backend)

- Cada service expõe poucos métodos públicos; o resto é interno.
- Outros módulos chamam só esses métodos, nunca o banco de outro módulo diretamente.
- Testar pela interface pública (o que o método promete), não pelos detalhes internos.
