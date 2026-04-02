<!-- WORKAROUND: Remove this file when opencode TUI fixes invisible code block rendering -->
<!-- CLEANUP: Also remove "./instructions/output-formatting.md" from opencode.json instructions array -->

# Output Formatting — Code Block Visibility

CRITICAL: The opencode TUI does NOT render all code block languages. Using an unsupported language specifier makes the entire block **invisible** to the user.

## Visible Languages (ONLY use these)

`bash`, `json`, `yaml`, `markdown`, `typescript`, `python`, `go`, `css`, `html`, `ruby`, `rust`, `zig`, `c`, `java`, `swift`

## Invisible Languages (NEVER use these)

Plain code blocks (triple backticks with no language), `text`, `plaintext`, `log`, `diff`, `xml`, `sql`, `shell`, `sh`, `zsh`, `toml`, `ini`, `lua`, `dockerfile`, `makefile`, `graphql`, `regex`, `csv`, `properties`, `scss`, `kotlin`, `r`, `hcl`, `csharp`, `cpp`, `php`, `perl`, `terraform`, `powershell`, `batch`, and any other language not in the visible list above.

## Workarounds

- For SQL, TOML, XML, Dockerfile, or other unsupported formats: use `bash` with comments, or output as plain markdown (no code block).
- For directory trees or plain text output: use `bash` or plain markdown.
- When unsure if a language is visible: default to `bash`.
