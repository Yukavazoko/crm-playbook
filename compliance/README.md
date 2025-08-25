# Compliance & LGPD — CRM B2B SaaS

Governança de dados aplicada ao CRM: **consentimento, bases legais, minimização, retenção, direitos do titular** e **acordos com fornecedores**.

---

## 📌 Problema
- Falta de padronização entre Marketing, Vendas, Produto e CS gera **risco legal** (opt-in/opt-out, bases legais, retenção).  
- Disparos sem validação de consentimento → **multas** e perda de reputação.  
- Falta de trilha de auditoria (quem acessou, quando e por quê).

---

## ✅ Solução
- **Contrato de Dados**: fontes, bases legais por canal, políticas de retenção e descarte.  
- **Gestão de Consentimento** (CMP) integrada ao CRM (opt-in, preferências por canal/tema, logs).  
- **Minimização**: coletar apenas o necessário para a jornada/fluxo.  
- **DPA** com fornecedores (RD/HubSpot, e-mail, WhatsApp, BI) e controle de acessos.  
- **Auditoria**: registro de disparos, acessos e incidentes.

👉 Checklist operacional: [`lgpd_checklist.md`](lgpd_checklist.md)

---

## 📊 KPIs de Governança
- % de leads com **consentimento válido** por canal  
- **Tempo de atendimento** a solicitações do titular (acesso/retificação/exclusão)  
- **Taxa de opt-out** por canal e por régua  
- **Incidentes** reportados e tempo de resolução  
- Cobertura de **DPA** com fornecedores críticos (≥ 95%)

---

## 🔧 Ferramentas / Implementação

**HubSpot**
- **Subscription Types** + **Communication Preferences** por canal/tema  
- Propriedades: `hs_email_optin`, `whatsapp_optin`, `consent_timestamp`, `consent_source`  
- Workflows: bloquear envios se `optin=false` / registrar log de consentimento  
- Relatórios: taxa de opt-out, opt-in por canal, SLA de titular

**RD Station**
- Campos customizados: `email_optin`, `whatsapp_optin`, `consent_timestamp`, `consent_source`  
- **Segmentações** com condição `optin=true` antes de disparos  
- **Landing Pages/Formulários** com caixas de consentimento e política  
- Auditoria básica de disparos e exportação sob requisição do titular
