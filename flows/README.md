# Flows (Régua de Comunicação)

Este diretório contém **réguas de CRM** documentadas em dois níveis:
1. **YAML técnico** → para simulação e replicação em ferramentas como HubSpot ou RD Station.  
2. **Markdown estratégico** → visão sênior da régua (objetivo, entrada/saída, KPIs, tabela de cadência).  

---

## 📌 Follow-up inbound (pós-formulário)

**Papel:** aproveitar o calor da conversão em formulário para **validar intenção rapidamente**.  
**Entrada (híbrido):** `form_submitted = true` (e opcional `score ≥ 30`).  
**Saída:** pede demo / vai para **Conversão** / ou vai para **Nutrição inicial**.  
**KPIs:** reply rate, demo request rate, % roteado para Conversão vs Nutrição.

**Blueprint:** [`followup_inbound.yaml`](followup_inbound.yaml)

| Dia | Canal | Mensagem                                  | CTA                              | Roteamento |
|-----|-------|--------------------------------------------|----------------------------------|-----------|
| 0   | Email | Conseguiu acessar? + vídeo 2min            | Assistir vídeo                   | Mantém    |
| 2   | Email | Case do seu segmento                       | Ver como se aplica               | Mantém    |
| 4   | Email | Seguimos agora ou te deixo no radar?       | Solicitar conversa / Conteúdos   | Conversão / Nutrição |

<details>
<summary>Notas</summary>

- Curta (até 4 dias), só 3 toques.  
- Se engajar → roteia para **Conversão** ou SDR.  
- Se não → entra em **Nutrição inicial**.  
</details>

---

## 📌 Nutrição inicial (após material rico)

**Papel:** educar com **conteúdos relacionados ao tema baixado**, aumentar **lead score** e maturidade.  
**Entrada (híbrido):** `asset_downloaded = true` e (`score 20–49` **ou** `pageviews_7d ≥ 2`).  
**Saída:** vira **MQL** / pede **demo** / inativo por 21d.  
**KPIs:** score gain, MQL rate, CTR de conteúdos.

**Blueprint:** [`nutricao_inicial.yaml`](nutricao_inicial.yaml)

| Dia | Canal | Mensagem                                        | CTA                | Efeito |
|-----|-------|--------------------------------------------------|--------------------|--------|
| 3   | Email | Checklist prático do tema baixado               | Baixar checklist   | +5     |
| 7   | Email | Benchmark por segmento                          | Ver benchmark      | +8     |
| 14  | Email | Sessão ao vivo: {tema} na prática               | Inscrever-se       | +10    |
| 21  | Email | Comparativo (inclui ROI)                        | Abrir comparativo  | +7     |

<details>
<summary>Notas</summary>

- Personaliza o caminho de acordo com o **tema do material baixado**.  
- Mais longa (até 3 semanas), foco educativo.  
- Prepara para Conversão ou direto para MQL.  
</details>

---

## 📌 Conversão (quase MQL)

**Papel:** transformar leads engajados (score médio **ou** visita a páginas quentes: preços/produto) em **MQL**.  
**Entrada (híbrido):** score 40–59 **OU** visitou páginas quentes (preços/produto/compare).  
**Saída:** MQL (score ≥ corte) / **demo** / inativo 7d.  
**KPIs:** MQL conversion rate, demo request rate, SQL acceptance rate.

**Blueprint:** [`conversao_quase_mql.yaml`](conversao_quase_mql.yaml)

| Dia | Canal | Mensagem                                 | CTA                             | Efeito |
|-----|-------|-------------------------------------------|----------------------------------|--------|
| 0   | Email | Diagnóstico (3 perguntas)                 | Responder diagnóstico            | +10    |
| 2   | Email | Case forte do seu segmento                | Solicitar demonstração / Ver case| +15    |
| 5   | Email | Comparativo/ROI calculator               | Solicitar demonstração /Abrir comparativo/ROI | +15     |

<details>
<summary>Notas</summary>

- Gatilhos de fundo de funil (demo, ROI, case).  
- Curta (até 7 dias).  
- Enriquecimento: diagnóstico captura dados para ICP + aumenta score.  
</details>
