---
name: system-design
version: 1.0.0
description: System and infrastructure design advisor. Architecture reviews, trade-off analysis, infra recommendations, and design patterns. Use when user says "system design", "architecture", "design this", "infra", "how should I build", "trade-offs", "scale this", "database design", "queue vs webhook", "should I use", or wants a technical design opinion on any stack component.
---

# System Design Advisor

Expert in distributed systems, AI infra, and automation architecture — applied to Anna's stack.

---

## What I Can Do

### 1. Architecture Reviews
Inspect an existing workflow, app, or system and identify:
- Single points of failure
- Missing error handling / retry logic
- Scalability bottlenecks
- Coupling issues
- Security gaps

### 2. Trade-off Analysis
Compare approaches with a structured table:
- Option A vs B vs C
- Pros, cons, complexity, cost
- Recommendation with reasoning

### 3. Design Patterns
Apply the right pattern for the job:

| Problem | Pattern |
|---|---|
| Avoid duplicate processing | Idempotency key + deduplication |
| Handle API rate limits | Token bucket / exponential backoff |
| Decouple producer from consumer | Message queue (async) |
| Fan-out to multiple consumers | Pub/sub |
| Long-running jobs | Background task + polling / webhook callback |
| Expensive repeated queries | Cache-aside + TTL |
| Partial failures in multi-step flows | Saga pattern / compensation |
| Read-heavy workload | Read replicas + CDN |
| AI context retrieval | Vector DB + hybrid search |

### 4. Infra Recommendations
Concrete recommendations for Anna's stack:
- **n8n** → workflow reliability patterns
- **Supabase** → schema design, RLS, pgvector, edge functions
- **Trigger.dev** → task retry, concurrency, scheduling
- **Vercel** → edge vs serverless, caching headers
- **OpenClaw** → agent coordination, heartbeat patterns
- **Apify** → scraping reliability, rate limits

### 5. Diagrams
Generate Mermaid or ASCII architecture diagrams on request.

---

## Core Concepts Reference

### CAP Theorem
- **C** Consistency — every read sees the latest write
- **A** Availability — every request gets a response
- **P** Partition tolerance — system survives network splits
- You can only guarantee 2. In practice: choose CP (banks) or AP (social feeds).

### Consistency Models (weakest → strongest)
Eventual → Monotonic reads → Read-your-writes → Causal → Sequential → Linearizable → Strict serializable

### Caching Strategies
| Strategy | Write path | Best for |
|---|---|---|
| Cache-aside | App writes DB, invalidates cache | General reads |
| Write-through | App writes cache + DB atomically | Always-fresh reads |
| Write-back | App writes cache only, async flush | Write-heavy |
| Read-through | Cache fills itself on miss | Transparent layer |

### Database Patterns
- **Sharding** — horizontal partition by key (user_id, tenant_id)
- **Read replicas** — offload SELECT-heavy queries
- **CQRS** — separate read models from write models
- **Event sourcing** — store events, derive state
- **Connection pooling** — PgBouncer for Postgres (critical for serverless → Supabase)

### Async Messaging
- **Queue** — one consumer per message (job processing)
- **Pub/sub** — multiple consumers (broadcast events)
- **At-least-once** — safe with idempotency keys
- **Exactly-once** — requires distributed transactions (costly)

### Resilience Patterns
- **Circuit breaker** — fail fast when downstream is down, recover after timeout
- **Retry with backoff** — jitter prevents thundering herd
- **Bulkhead** — isolate failure domains (separate thread pools)
- **Timeout** — always set; never wait forever
- **Saga** — compensating transactions for multi-service flows

### AI Infra Patterns
- **RAG** — chunk → embed → store → retrieve → generate. Chunk size matters (512-1024 tokens typical).
- **Hybrid search** — combine semantic (vector) + keyword (BM25/FTS) for better recall
- **Streaming** — stream LLM output for better UX; buffer for downstream processing
- **Prompt caching** — cache system prompts to reduce latency + cost (Anthropic supports this)
- **Agent loops** — always set maxIterations; add explicit STOP instructions; log tool calls

---

## Commands

### `/system-design` — Show this overview

### `/system-design review <thing>` — Architecture review
Describe what to review (workflow name, app, idea). I will:
1. Read relevant files if they exist
2. Identify issues
3. Produce a scored report (Reliability / Scalability / Maintainability / Security)

### `/system-design tradeoffs <decision>` — Compare approaches
e.g. "queue vs webhook for n8n triggers", "Supabase vs PlanetScale", "polling vs streaming"

### `/system-design diagram <system>` — Generate architecture diagram
Returns a Mermaid flowchart or sequence diagram.

### `/system-design pattern <problem>` — Recommend a pattern
Describe the problem; I return the best-fit pattern + implementation notes.

---

## Applied to Anna's Stack

### n8n Reliability Checklist
- [ ] Error branch on every HTTP node
- [ ] Retry node (3x, exponential backoff) before error branch
- [ ] Idempotency: check for existing record before insert
- [ ] Webhook responds 200 immediately → async processing
- [ ] Max iterations set on all agent nodes (≤ 20)
- [ ] Credentials stored as n8n credentials, never hardcoded
- [ ] Workflow has a test mode branch

### Supabase Patterns
- Use RLS for all user-facing tables
- pgvector: `ivfflat` index for cosine similarity, `lists=100` for ≤1M rows
- Edge functions for webhook receivers (instant 200 response)
- Connection string via PgBouncer (`?pgbouncer=true`) from serverless

### Trigger.dev Patterns
- Idempotency key on all tasks: `triggerAndWait(id, payload, { idempotencyKey })`
- Use `retry: { maxAttempts: 3, minTimeoutInMs: 1000 }` on HTTP tasks
- Concurrency limits per workflow to avoid hammering APIs
- Use `schedules.create` for cron-based triggers (not n8n schedule + HTTP)

---

## Voice Triggers

- "system design" → show overview
- "review [workflow/app]" → architecture review
- "should I use [X] or [Y]" → trade-off analysis
- "design [feature]" → produce architecture proposal
- "what pattern should I use for [problem]" → pattern recommendation
- "draw the architecture" → Mermaid diagram
- "is this scalable" → scalability analysis
- "what could go wrong" → failure mode analysis
