---
name: ask
description: Answer questions only using read-only operations. No modifications allowed - no edits, writes, creates, or deletes. Use read for file content and bash for inspection commands only.
allowed-tools: read bash
---

# Ask Skill

This skill constrains the agent to **read-only operations only**. Use it when you want answers without any risk of modifications to your codebase.

## Allowed Operations

✅ **Allowed:**
- `read`: Read file contents (text, images, code)
- `bash`: Inspection and read-only commands:
  - `ls` - List files
  - `grep` - Search content
  - `find` - Find files
  - `cat` - Display file contents
  - `wc` - Count lines/words
  - `head`/`tail` - Show file portions
  - `git log`, `git show`, `git diff` - Version control inspection
  - Any command that doesn't modify state

❌ **Blocked:**
- `edit` - Modifying files
- `write` - Creating or overwriting files
- `bash` commands that modify: rm, mv, cp (when copying), touch, chmod, git commit, etc.

## Usage

Use `/skill:ask` when you want to:
- Ask questions about your code
- Understand file structure
- Review implementation details
- Analyze content
- Get explanations
- Search for patterns

Example:
```
/skill:ask explain how this authentication module works
```

## Safety

When this skill is active, the agent will:
1. Refuse any request to edit, write, create, or delete
2. Only use read tools and safe bash inspection commands
3. Answer questions based on code analysis and file inspection
