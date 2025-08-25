# LGPD — Checklist Operacional

> Guia prático para garantir conformidade nas rotas de CRM, desde aquisição até retenção.

## 1) Bases legais por canal
- E-mail marketing: **consentimento** explícito (double opt-in recomendado)
- WhatsApp/SMS: consentimento específico por canal; registro de **opt-in** e fácil **opt-out**
- Conteúdos transacionais (ex.: fatura, reset de senha): **execução de contrato** (não usar para marketing)

## 2) Consentimento & Preferências
- Campos no CRM: `email_optin` (bool), `whatsapp_optin` (bool), `consent_timestamp`, `consent_source` (LP, evento, import)
- Página de **preferências** (geral + temas): opt-out granular
- Log de auditoria para mudanças de consentimento

## 3) Minimização & Finalidade
- Coletar apenas os dados necessários para cada régua (evitar “formulário catálogo”)
- Amarrar cada propriedade a um **propósito claro** (e.g., `industry` → segmentação de conteúdo)

## 4) Retenção & Descarte
- TTL para leads inativos: **18–24 meses** → anonimizar ou excluir
- Definir política para **backup** e para **exportações** (planilhas em pastas seguras)
- Registrar descarte com data, responsável e método

## 5) Direitos do Titular
- SLA para responder a: acesso, retificação, exclusão, portabilidade
- Modelo de resposta padrão + trilha de execução (logs)

## 6) Acordos com Fornecedores (DPA)
- Assinar DPA com: HubSpot/RD, provedores de e-mail/WhatsApp, BI/Analytics, armazenamento
- Verificar sub-processadores e transferência internacional de dados

## 7) Segurança & Acesso
- Princípio do **menor privilégio** no CRM e no DW
- **2FA** obrigatório; revisão trimestral de permissões
- Registro de acesso a dados sensíveis (query logs, exportações)

## 8) Auditoria de Disparos
- Registrar **campanha, lista, responsável, canal, data/hora, volume**
- Monitorar **bounce**, **spam**, **opt-out**; bloquear réguas com alta rejeição

## 9) Incidentes & Resposta
- Playbook com severidade, comunicação e prazos legais
- Canal de reporte interno (ex.: security@empresa.com)

---

### Modelos de Campos (sugestão)

| Campo               | Tipo      | Exemplo                  |
|---------------------|-----------|--------------------------|
| email_optin         | boolean   | true/false               |
| whatsapp_optin      | boolean   | true/false               |
| consent_timestamp   | datetime  | 2025-08-25T12:34:56Z     |
| consent_source      | string    | `lp_webinar_julho`       |
| data_ttl_date       | date      | 2027-01-01               |
| dpa_signed          | boolean   | true                     |

---

**Boas práticas**  
- Coloque **opt-out** visível em todos os e-mails  
- Tenha **link de política de privacidade** atualizado nas LPs/formulários  
- **Registre tudo**: consentimentos, acessos, exportações, descarte
