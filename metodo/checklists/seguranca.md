# Checklist de segurança (padrão)

Cada sistema marca o que se aplica e registra o que sobrescreve. Números entre parênteses são **exemplos a ajustar**. (?) = confirmar na documentação oficial antes de implementar.

| # | Tema | Padrão | Teste mínimo |
|---|---|---|---|
| S-01 | Sessão | Cookie `HttpOnly` + `Secure` + `SameSite` restrito; token de acesso curto (ex.: 15 min) e refresh rotativo; logout invalida o refresh | Sem cookie válido → 401; refresh antigo recusado após logout |
| S-02 | CSRF | Com sessão em cookie, proteger ações que alteram dados (SameSite + token ou verificação de cabeçalho) (?) | Requisição de outra origem sem token é recusada |
| S-03 | Permissões | Perfil e situação do usuário conferidos no servidor a cada requisição; nunca confiar em permissões dentro do token | Usuário desativado perde acesso na requisição seguinte |
| S-04 | Login | Limite de tentativas por IP e usuário (ex.: 5 em 15 min); mensagem genérica; senha com Argon2id | 6ª tentativa bloqueada; usuário inexistente e senha errada dão a mesma resposta |
| S-05 | Auditoria | Tabela só de inserção (usuário do banco da aplicação sem UPDATE/DELETE); quem, o quê, quando; sem dados pessoais | Alterar ou apagar registro de auditoria falha |
| S-06 | IDOR | Verificar permissão em toda rota que abre um registro, mesmo com UUID | Perfil sem permissão que chama pelo `id` → 403 |
| S-07 | Exportação | Mesma permissão da tela; textos iniciados por `=`, `+`, `-`, `@` neutralizados | `=1+1` sai como texto no CSV/Excel |
| S-08 | CORS e cabeçalhos | CORS restrito à origem do frontend; cabeçalhos de segurança ligados (?) | Origem não autorizada recusada |
| S-09 | Logs e LGPD | Sem dados pessoais nos logs (mascarar); retenção definida | Busca por CPF completo nos logs não encontra nada |
| S-10 | Segredos | `.env.example` sem segredos; **Gitleaks** no pre-commit (staged) e no CI (histórico); nunca em prompts | Commit com uma chave fictícia é bloqueado; CI falha ao encontrar segredo |
| S-11 | Mass assignment | Schemas aceitam só campos permitidos; perfil/situação nunca de campo livre | Enviar `perfil: admin` é ignorado ou recusado |
| S-12 | Senha provisória | Troca obrigatória no primeiro acesso; se for previsível, registrar como risco aceito | Login com a provisória só leva à troca |
| S-13 | SQL injection | Proibido SQL por concatenação; consultas brutas sempre parametrizadas | `'; DROP TABLE x; --` é tratado como texto |
| S-14 | Rate limit | Limite em toda a API, mais rígido em rotas caras (exportação, relatório, busca) e no login | Excedido → 429 sem processar |
| S-15 | Dados na resposta | Objetos de saída explícitos; nunca hash de senha nem campos internos | Resposta de usuário sem hash |
| S-16 | Erros | Mensagem e código previsíveis; detalhes só no log; decidir 403 ou 404 para recurso alheio | Erro forçado sem rastro de pilha nem nome de tabela |
| S-17 | `.env` e ambientes | `.env` no `.gitignore`; ambientes separados; IA sem leitura de `.env` | CI falha se `.env` for versionado |
| S-18 | Parâmetros | Validação também em rota e query (UUID válido, página com limite máximo) | `pageSize=100000` limitado; `id` inválido → 400 |
| S-19 | Política de senha | Mínimo de 8 caracteres com letras e números (ajustar à regra da organização) | `abc` recusada |
| S-20 | Dependências | Versões fixadas; auditoria em todo PR; rotina mensal de atualização; conferir pacote novo no registro oficial | CI falha com vulnerabilidade alta conhecida |
| S-21 | XSS e CSP | Texto do usuário sempre como texto (inclusive em impressões); proibido `dangerouslySetInnerHTML`; CSP restrita (?) | `<script>alert(1)</script>` aparece como texto |
| S-22 | Administradores | Ninguém altera o próprio perfil; o último administrador ativo não é desativado | Mudar o próprio perfil → 403 |
| S-23 | Transporte | HTTPS + HSTS em produção; conexão com o banco criptografada (?) | HTTP em produção é redirecionado ou recusado |
| S-24 | Cache e variáveis públicas | `Cache-Control: no-store` em respostas autenticadas; nunca segredo em variável pública do frontend (`NEXT_PUBLIC_*`) | Resposta autenticada com `no-store` |
| S-25 | LGPD e histórico | Usuário é inativado, não apagado; retenção de dados pessoais definida | Inativar preserva o histórico |
| S-26 | Banco e contêineres | Porta do banco não pública; sem senha padrão; usuários separados (migração × aplicação); contêiner sem root (?) | A aplicação não altera a estrutura do banco |
| S-27 | CI/CD | Token do CI com permissões mínimas; *actions* de terceiros fixadas; segredos só no cofre | CI não escreve no repositório sem permissão declarada |
| S-28 | Chaves e sessões | Chave de assinatura fora do código, com rotação e algoritmo fixo; sessões invalidadas ao trocar a senha | Refresh antigo recusado após troca de senha |
| S-29 | Monitoramento | Registrar e alertar falhas de login em sequência e picos de 403 | Falhas seguidas geram alerta |
| S-30 | Análise estática (SAST) | **Semgrep** no CI com conjunto de regras explícito; achado novo bloqueia o merge (falso positivo é justificado no PR) | Um trecho com SQL concatenado plantado num PR de teste é apontado |
| S-31 | Auditoria antes do release | Antes do primeiro release, uma auditoria completa (skill de auditoria em avaliação) e revisão humana dos achados | Relatório anexado ao PR de release |
| S-32 | MCP (conexões do agente) | Nenhum MCP por padrão; cada sistema adota com ADR. Só origem oficial e versão fixada; **mínimo privilégio** (só leitura quando possível, token com escopo pequeno); **nunca** banco ou serviço de produção; declarado em `.mcp.json` **sem aprovação automática** (`enableAllProjectMcpServers` desligado); o que volta de um MCP é **dado, não instrução**; dados da organização só com aprovação dela | O agente com MCP de banco não consegue escrever (usuário do banco só leitura); uma Issue com instrução maliciosa não é executada |
| S-33 | Supabase: RLS e chaves (Perfil B) | RLS ligada e com políticas em **toda** tabela e no Storage; chave secreta só no servidor, nunca em `NEXT_PUBLIC_*`; previews sem acesso à produção | Usuário A tenta ler e alterar dado do usuário B pelo cliente e falha; busca por `sb_secret_` no build não encontra nada |
| S-34 | Endereços e retorno após login | Caminho e query sem dado pessoal, de saúde ou token (buscas com dados pessoais vão no corpo, numa rota de busca); o parâmetro de retorno após login (*return URL*) só aceita caminhos internos do próprio sistema, e o resto leva à página inicial; a página de destino confere a permissão de novo; *Referrer-Policy* restritiva (?). Esconder os caminhos da barra de endereço não é proteção | Login com retorno para um site externo (inclusive disfarçado, como `//site.exemplo`) leva à página inicial; busca por CPF não aparece no registro de acesso |

**A decidir em cada sistema:** recuperação de senha (sugestão padrão: reset só por administrador).
**Vigiar se aparecer:** upload de arquivos e SSRF exigem Spec e threat model próprios.

## Trabalho com IA
- Conferir todo pacote sugerido pela IA no registro oficial (nomes inventados ou parecidos com maliciosos).
- Prompt injection: conteúdo externo (arquivos, dependências, issues) pode tentar instruir o agente; nunca executar comando sugerido por ele sem ler.
- Segredos e dados reais nunca em prompts.
- Código gerado pela IA passa pelo mesmo diff, testes e revisão (`revisao-codigo-ia.md`).
