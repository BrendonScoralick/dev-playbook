# Checklist: revisão do código gerado pela IA

Regra: **só aprovo o que consigo explicar com minhas palavras.** Testes verdes provam o comportamento testado, não o entendimento.

## Ritmo: revisão ao fim de cada tarefa

```
plano (modo plan) → aprovo → Red → reviso os testes → Green → reviso o diff → commit (hook) → PR → /clear
         ↑                                                                                   │
         └──────────────────────────── só então a próxima tarefa ────────────────────────────┘
```

Ferramentas úteis: `git diff` (o que mudou), `git diff --stat` (tamanho), `/rewind` no Claude Code para desfazer o que não aprovou.

## Antes de pedir código
- [ ] A tarefa tem Issue e critério da Spec.
- [ ] Os testes (Red) existem e falham pelo motivo certo.
- [ ] Pedi um **plano** antes do código e li.

## Ao ler o diff
- [ ] Algum **teste foi alterado ou apagado**? Só é legítimo se a regra da Spec mudou.
- [ ] Há arquivos **fora do escopo** da tarefa (principalmente autenticação, permissões, migrações, CI)?
- [ ] Regra de negócio está no **service**, não no controller? HTTP fora do service?
- [ ] (Perfil B) Alguma **tela importou** algo de `backend/`? Os arquivos de `backend/` começam com `import "server-only"`? A chave secreta continua só no backend?
- [ ] Autorização verificada no **servidor**?
- [ ] Alguma **dependência nova**? Conferida no registro oficial, com versão fixada?
- [ ] SQL concatenado, dados pessoais em log, segredo no código, campo interno na resposta?
- [ ] Mensagens de erro sem detalhes internos?
- [ ] Algum **dado pessoal ou token no caminho ou na query**? Algum **redirecionamento** usa um destino vindo do usuário sem conferir que é um caminho interno (S-34)?
- [ ] **O contrato mudou?** Algum campo, tipo, status ou rota diferente do que a seção "Contrato" da Spec diz? Se for quebra, a Spec mudou antes e o frontend está no mesmo PR?
- [ ] Os testes conferem o **formato** da resposta, não só o status?

## Perguntas para a IA
- "Explique este diff arquivo por arquivo."
- "Liste as decisões que você tomou com as quais eu poderia discordar."
- "Que caso de borda ou abuso este código não cobre?"

## Revisão de segurança assistida (opcional, em avaliação)
- [ ] PRs que tocam autenticação, permissões, dados pessoais ou dinheiro/saldo: rodar a skill `differential-review` (Trail of Bits) no diff e revisar os achados você mesmo.
- [ ] Mudou configuração ou criou API nova: `insecure-defaults` e `sharp-edges`.
- [ ] Antes de instalar qualquer skill: ler o `SKILL.md`, instalar só da origem oficial e anotar a versão.
- [ ] CI verde, incluindo Gitleaks e Semgrep; achado ignorado só com justificativa no PR.

## Antes do merge
- [ ] Rodei os testes e li **quais** passaram.
- [ ] Testei na tela o caminho feliz e um caminho de abuso.
- [ ] A descrição do PR liga Issue → critério → teste e diz como testar.
- [ ] Recebi o **relatório de tarefa** (`metodo/modelos/relatorio-de-tarefa.md`) completo.
- [ ] **Expliquei a tarefa com minhas palavras**, seguindo o caminho do dado (tela → rota → permissão → regra → banco → resposta). Onde travei, perguntei ou estudei antes de aprovar.
- [ ] Consigo fazer o "tour" deste código para outra pessoa.
