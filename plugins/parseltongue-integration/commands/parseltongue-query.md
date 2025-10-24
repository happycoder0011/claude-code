---
description: Direct queries to Parseltongue for code analysis, context generation, and graph-based reasoning
argument-hint: Query type (e.g., 'generate-context EntityName', 'query what-implements Trait')
---

# Parseltongue Query Command

This command allows direct interaction with the Parseltongue CLI tool for graph-based code analysis. Use it to generate context, query implementations, or assess change impacts.

## Supported Queries

- **Generate Context**: `generate-context <entity> [--format json]` - Create human-readable or JSON context for an entity.
- **Query Implementations**: `query what-implements <trait> [--format json]` - Find trait implementations.
- **Blast Radius**: `query blast-radius <entity>` - Assess impact of changes.
- **Debug Graph**: `debug --graph` or `debug --dot` - Visualize the graph.

## Usage

1. Ingest the codebase if not already done: Run `parseltongue ingest <path>` in your terminal.
2. Execute the query: Provide the query as arguments (e.g., "generate-context Person --format json").
3. Review output: The command will run Parseltongue and display results, formatted for LLM use if specified.

## Integration Notes

- This command can be invoked by other agents when the `integrations: ["parseltongue"]` attribute is set.
- Fallback: If Parseltongue is not available, log an error and skip.

## Examples

- Generate JSON context: `generate-context UserStruct --format json`
- Query blast radius: `query blast-radius UserStruct`
