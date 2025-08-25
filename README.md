# CRM Playbook (B2B SaaS) — Portfólio da Yuka Kavazoko

[![Last Update](https://img.shields.io/badge/last_update-Aug_2025-blue?style=flat-square)](#)
[![Made with ❤ CRM](https://img.shields.io/badge/made%20with-%E2%9D%A4%20CRM-red?style=flat-square)](#)
[![LGPD Aware](https://img.shields.io/badge/LGPD-aware-green?style=flat-square)](#)
[![Scope](https://img.shields.io/badge/scope-B2B%20SaaS-informational?style=flat-square)](#)
[![Stack](https://img.shields.io/badge/stack-RD%20Station%20%7C%20HubSpot%20%7C%20SQL-lightgrey?style=flat-square)](#)

**Playbook de CRM B2B com foco em execução.**  

Aqui você encontra **visão macro**, **réguas (YAML)**, **segmentações (SQL)**, **contrato de eventos**, **dashboards** e **cases** anonimizados — o que uso para desenhar, medir e iterar jornadas de **aquisição, ativação, engajamento, retenção e expansão**.

> **Escopo**: B2B SaaS. Adaptações para B2C são possíveis e serão sinalizadas quando relevantes.  
> **Stack de exemplo**: RD Station / HubSpot + Pipedrive/CRM, BigQuery/Postgres, ferramentas de disparo por e-mail/WhatsApp/SMS.

---

## Sumário
1. [Visão Macro da Jornada](#visão-macro-da-jornada)  
2. [Como Navegar](#como-navegar)  
3. [Etapas e Estratégias](#etapas-e-estratégias)  
4. [Métricas & Dados](#métricas--dados)  
5. [Fluxos (réguas)](#fluxos-réguas)  
6. [SQL (segmentações & risco)](#sql-segmentações--risco)  
7. [Contrato de Eventos](#contrato-de-eventos)  
8. [Dashboards & KPIs](#dashboards--kpis)  
9. [LGPD & Governança](#lgpd--governança)  
10. [Cases (anonimizados)](#cases-anonimizados)  
11. [Como Usar / Reproduzir](#como-usar--reproduzir)  
12. [Estrutura do Repositório](#estrutura-do-repositório)  
13. [Licença](#licenca)  

---

## Visão Macro da Jornada
Diagrama de alto nível ligando **Aquisição → Pré-vendas (SDR/BDR) → Ativação (Onboarding) → Engajamento → Retenção → Expansão** com loops de **recuperação** ao longo do caminho.

<p align="center">
  <img src="https://raw.githubusercontent.com/Yukavazoko/assets-diagramas/main/Fluxogramas.png" alt="Fluxograma CRM B2B" width="90%" />
</p>

<p align="center">
  <i>Figura 1 — Jornada de CRM B2B com fluxos de aquisição, pré-venda, ativação, engajamento, retenção, expansão e estratégias de recuperação.</i>
</p>

> **Dica**: MQL reciclado/recuperado pode voltar para SDR com régua específica. SQL perdido por timing volta para nutrição segmentada.

---

## Como Navegar
- Comece pelos **princípios por etapa** em [`/strategies`](strategies/README.md).  
- Aplique uma régua inicial em [`/flows`](flows/ativacao_onboarding.yaml).  
- Teste segmentações em [`/sql`](sql/propensao_churn.sql).  
- Garanta tracking com [`/events_schema`](events_schema/tracking_events.json).  
- Valide KPIs em [`/dashboards`](dashboards/crm_funnel_kpis.md).  
- Consulte conformidade em [`/compliance`](compliance/lgpd_checklist.md).  
- Veja resultados e aprendizados em [`/cases`](cases/case_01_onboarding_b2b.md).  

---

## Etapas e Estratégias
- **[Aquisição](strategies/aquisicao.md)**: UTM, lead scoring, oferta por ICP.  
- **[Pré-vendas (SDR/BDR)](strategies/pre-vendas.md)**: critérios de MQL→SQL, no-show, playbook de ligação.  
- **[Ativação](strategies/ativacao.md)**: time-to-value, marcos, onboarding 30 dias.  
- **[Engajamento](strategies/engajamento.md)**: cadência, papéis (decisor x operador), adoção de features.  
- **[Retenção](strategies/retencao.md)**: sinais de risco, ofertas de resgate, playbooks proativos.  
- **[Expansão](strategies/expansao.md)**: gatilhos de upsell/cross-sell, NRR.  

---

## Métricas & Dados
- **Funil**: Leads → MQL → SQL → Closed Won → Ativado.  
- **KPIs por etapa** e definições: veja [`/dashboards/crm_funnel_kpis.md`](dashboards/crm_funnel_kpis.md).  
- **Contrato de dados** (eventos & propriedades): [`/events_schema`](events_schema/tracking_events.json).  

---

## Fluxos (réguas)
- **Onboarding 30 dias (B2B)** → [`flows/ativacao_onboarding.yaml`](flows/ativacao_onboarding.yaml)  
- **Reengajamento MQL reciclado** → [`flows/reengajamento_mql.yaml`](flows/reengajamento_mql.yaml)  
- **Prevenção de churn (exemplo)** → (em breve)  

---

## SQL (segmentações & risco)
- **Propensão a churn (queda de uso)** → [`sql/propensao_churn.sql`](sql/propensao_churn.sql)  
- **LTV por conta (exemplo)** → (em breve)  
- **Lead scoring básico (exemplo)** → (em breve)  

---

## Contrato de Eventos
Esquema mínimo de tracking para jornada B2B SaaS (signup, integração, uso de feature-chave, consentimentos).  
→ [`events_schema/tracking_events.json`](events_schema/tracking_events.json)  

---

## Dashboards & KPIs
Definições de métricas, fórmulas, e print de painéis (mock).  
→ [`dashboards/crm_funnel_kpis.md`](dashboards/crm_funnel_kpis.md)  

---

## LGPD & Governança
Checklist de práticas essenciais (consentimento, opt-out, retenção, minimização, DPA).  
→ [`compliance/lgpd_checklist.md`](compliance/lgpd_checklist.md)  

---

## Cases (anonimizados)
- **Case 01 — Onboarding reduziu TTV** → [`cases/case_01_onboarding_b2b.md`](cases/case_01_onboarding_b2b.md)  
- Case 02 — Reengajamento MQL → (em breve)  

---

## Como Usar / Reproduzir
1. Leia a visão macro e a estratégia por etapa em `/strategies`.  
2. Aplique a régua de **Ativação** em `/flows/ativacao_onboarding.yaml`.  
3. Rode as queries em `/sql` (ajuste nomes de tabelas/esquema).  
4. Garanta o tracking com o contrato de `/events_schema`.  
5. Meça KPIs com o guia em `/dashboards`.  
6. Documente aprendizados em `/cases`.  

---
<a id="licenca"></a>
## Licença
Este conteúdo é disponibilizado para fins educacionais e de portfólio. Consulte a licença do repositório.

## Estrutura do Repositório
```text
crm-playbook/
├─ README.md
├─ strategies/
│  ├─ README.md
│  ├─ aquisicao.md
│  ├─ pre-vendas.md
│  ├─ ativacao.md
│  ├─ engajamento.md
│  ├─ retencao.md
│  └─ expansao.md
├─ flows/
│  ├─ ativacao_onboarding.yaml
│  └─ reengajamento_mql.yaml
├─ sql/
│  └─ propensao_churn.sql
├─ events_schema/
│  └─ tracking_events.json
├─ dashboards/
│  └─ crm_funnel_kpis.md
├─ compliance/
│  └─ lgpd_checklist.md
└─ cases/
   └─ case_01_onboarding_b2b.md

