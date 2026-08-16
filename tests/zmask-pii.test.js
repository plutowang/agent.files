// tests/zmask-pii.test.js
import { describe, expect, test, mock, beforeEach } from "bun:test"
import fs from "node:fs"

// Mock node:child_process BEFORE importing the plugin.
// The fake is LINE-FAITHFUL: each non-empty input line becomes "[MASKED]"
// (preserving a trailing \r), mirroring zmask's 1-line-in → 1-line-out contract.
const calls = []
let behavior = "ok" // "ok" | "enotfound" | "exit1" | "empty" | "misalign"

mock.module("node:child_process", () => ({
  spawnSync: (bin, args, opts) => {
    calls.push({ bin, args, opts })
    if (behavior === "enotfound")
      return {
        error: { message: "spawn zmask ENOENT" },
        status: null,
        stdout: "",
      }
    if (behavior === "exit1") return { error: undefined, status: 1, stdout: "" }
    if (behavior === "empty") return { error: undefined, status: 0, stdout: "" }
    const stdout =
      typeof opts.input === "string"
        ? opts.input
            .split("\n")
            .map((line) =>
              line.length === 0
                ? ""
                : "[MASKED]" + (line.endsWith("\r") ? "\r" : ""),
            )
            .join("\n")
        : ""
    if (behavior === "misalign") {
      // Drop the last line — breaks the line-faithful contract.
      const segments = stdout.split("\n")
      segments.pop()
      return { error: undefined, status: 0, stdout: segments.join("\n") }
    }
    return { error: undefined, status: 0, stdout }
  },
}))

const pluginModule = await import("../opencode/plugins/zmask-pii.js")

function textPart(text) {
  return { id: "p1", type: "text", text, synthetic: false }
}

async function transformOnce(messages, options) {
  const hooks = await pluginModule.default(undefined, options)
  const output = { messages }
  await hooks["experimental.chat.messages.transform"]({}, output)
  return output
}

async function systemOnce(system) {
  const hooks = await pluginModule.default(undefined, undefined)
  const output = { system }
  await hooks["experimental.chat.system.transform"]({}, output)
  return output
}

describe("zmask-pii plugin", () => {
  beforeEach(() => {
    calls.length = 0
    behavior = "ok"
    delete process.env.ZMASK_PATH
    pluginModule.default._resetForTests()
  })

  test("masks a text part in place", async () => {
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("alpha@example.com")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe("[MASKED]")
  })

  test("leaves non-text parts untouched", async () => {
    const reasoning = {
      id: "r1",
      type: "reasoning",
      text: "thinking alpha@example.com",
      metadata: {},
    }
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("beta@example.com"), reasoning],
      },
    ])
    expect(out.messages[0].parts[1]).toBe(reasoning)
    expect(out.messages[0].parts[1].text).toBe("thinking alpha@example.com")
    expect(calls.length).toBe(1)
  })

  test("batch: 3 unique parts in one call spawn zmask exactly once", async () => {
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [
          textPart("gamma@example.com"),
          textPart("delta@example.com"),
          textPart("epsilon@example.com"),
        ],
      },
    ])
    expect(calls.length).toBe(1)
    expect(out.messages[0].parts.map((p) => p.text)).toEqual([
      "[MASKED]",
      "[MASKED]",
      "[MASKED]",
    ])
  })

  test("round-trip: multi-line and CRLF strings are byte-exact", async () => {
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("a\nb\r\nc\n")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe(
      "[MASKED]\n[MASKED]\r\n[MASKED]\n",
    )
  })

  test("masks tool part state output and input strings", async () => {
    const arr = ["zeta@example.com", "sub@example.com"]
    const tool = {
      id: "t1",
      type: "tool",
      callID: "c1",
      tool: "read",
      state: {
        status: "completed",
        input: {
          filePath: "zeta2@example.com",
          nested: { deep: "10.0.0.1" },
          arr,
          count: 42,
          ok: true,
        },
        output: "file contains eta@example.com",
        title: "",
        metadata: {},
        time: { start: 1 },
      },
    }
    const out = await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [tool] },
    ])
    expect(out.messages[0].parts[0]).toBe(tool)
    expect(tool.state.output).toBe("[MASKED]")
    expect(tool.state.input.filePath).toBe("[MASKED]")
    expect(tool.state.input.nested.deep).toBe("[MASKED]")
    expect(tool.state.input.count).toBe(42)
    expect(tool.state.input.ok).toBe(true)
    // Array identity preserved (in-place mutation) with masked elements.
    expect(tool.state.input.arr).toBe(arr)
    expect(tool.state.input.arr).toEqual(["[MASKED]", "[MASKED]"])
  })

  test("masks tool state title", async () => {
    const tool = {
      id: "t2",
      type: "tool",
      callID: "c2",
      tool: "bash",
      state: {
        status: "completed",
        input: {},
        output: "ok",
        title: "curl http://192.168.1.1",
      },
    }
    await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [tool] },
    ])
    expect(tool.state.title).toBe("[MASKED]")
  })

  test("masks non-string tool output recursively", async () => {
    const outObj = { data: ["a@b.com", { deep: "10.0.0.1" }], count: 1 }
    const tool = {
      id: "t3",
      type: "tool",
      callID: "c3",
      tool: "json-tool",
      state: {
        status: "completed",
        input: {},
        output: outObj,
        title: "json-tool",
      },
    }
    const out = await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [tool] },
    ])
    expect(tool.state.output).toBe(outObj)
    expect(outObj.data[0]).toBe("[MASKED]")
    expect(outObj.data[1].deep).toBe("[MASKED]")
    expect(outObj.count).toBe(1)
    expect(tool.state.title).toBe("[MASKED]")
  })

  test("masks system array strings in place", async () => {
    const out = await systemOnce(["instructions with theta@example.com", 123])
    expect(out.system[0]).toBe("[MASKED]")
    expect(out.system[1]).toBe(123)
  })

  test("fail-open on ENOENT preserves original text", async () => {
    behavior = "enotfound"
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("iota@example.com")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe("iota@example.com")
  })

  test("fail-open on exit 1: batch falls back per-string, originals preserved", async () => {
    behavior = "exit1"
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("kappa@example.com"), textPart("lambda@example.com")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe("kappa@example.com")
    expect(out.messages[0].parts[1].text).toBe("lambda@example.com")
  })

  test("fail-open on empty stdout (exit 0): originals preserved", async () => {
    behavior = "empty"
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("rho@example.com")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe("rho@example.com")
  })

  test("line-mismatch: batch falls back per-string, originals preserved", async () => {
    behavior = "misalign"
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("sigma@example.com"), textPart("tau@example.com")],
      },
    ])
    expect(out.messages[0].parts[0].text).toBe("sigma@example.com")
    expect(out.messages[0].parts[1].text).toBe("tau@example.com")
  })

  test("disabled after binary failure: subsequent calls spawn nothing and pass through", async () => {
    behavior = "enotfound"
    await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("upsilon@example.com")],
      },
    ])
    const spawnsAfterFailure = calls.length
    expect(spawnsAfterFailure).toBeGreaterThan(0)

    behavior = "ok"
    const out = await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("phi@example.com")],
      },
    ])
    expect(calls.length).toBe(spawnsAfterFailure)
    expect(out.messages[0].parts[0].text).toBe("phi@example.com")
  })

  test("cache: same text in a second call spawns nothing new", async () => {
    await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("mu@example.com")],
      },
    ])
    expect(calls.length).toBe(1)
    await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("mu@example.com")],
      },
    ])
    expect(calls.length).toBe(1)
  })

  test("cache evicts beyond 500 entries", async () => {
    const first = "first-unique@example.com"
    await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [textPart(first)] },
    ])
    const batch = []
    for (let i = 0; i < 500; i++) {
      batch.push({
        info: { role: "user", agent: "build" },
        parts: [textPart(`fill-${i}@example.com`)],
      })
    }
    await transformOnce(batch)
    await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [textPart(first)] },
    ])
    expect(calls.length).toBe(3)
  })

  test("empty text parts do not spawn", async () => {
    await transformOnce([
      { info: { role: "user", agent: "build" }, parts: [textPart("")] },
    ])
    expect(calls.length).toBe(0)
  })

  test("zmask invoked with no flags, 64MB maxBuffer, 10s timeout", async () => {
    await transformOnce([
      {
        info: { role: "user", agent: "build" },
        parts: [textPart("nu@example.com")],
      },
    ])
    expect(calls.at(-1).args).toEqual([])
    expect(calls.at(-1).opts.maxBuffer).toBe(64 * 1024 * 1024)
    expect(calls.at(-1).opts.timeout).toBe(10000)
  })

  test("no-op on malformed output", async () => {
    const hooks = await pluginModule.default(undefined, { path: "/fake/zmask" })
    await hooks["experimental.chat.messages.transform"]({}, {})
    await hooks["experimental.chat.messages.transform"]({}, { messages: [] })
    await hooks["experimental.chat.system.transform"]({}, {})
    expect(calls.length).toBe(0)
  })

  test("binary resolution: option overrides bundled default", async () => {
    await transformOnce(
      [
        {
          info: { role: "user", agent: "build" },
          parts: [textPart("xi@example.com")],
        },
      ],
      { path: "/opt/zmask" },
    )
    expect(calls.at(-1).bin).toBe("/opt/zmask")

    await transformOnce(
      [
        {
          info: { role: "user", agent: "build" },
          parts: [textPart("pi@example.com")],
        },
      ],
      undefined,
    )
    expect(
      calls
        .at(-1)
        .bin.endsWith(`opencode/bin/zmask-${process.platform}-${process.arch}`),
    ).toBe(true)
  })

  const bundledBinary = () =>
    new URL(
      `../opencode/bin/zmask-${process.platform}-${process.arch}`,
      import.meta.url,
    ).pathname

  // zmask is vendored per platform+arch. The integration test only runs when
  // the variant exists, is executable, and its format matches the current
  // platform (ELF on Linux, Mach-O on macOS).
  function binaryRunnable(path) {
    try {
      fs.accessSync(path, fs.constants.X_OK)
    } catch {
      return false
    }
    const fd = fs.openSync(path, "r")
    const header = Buffer.alloc(4)
    fs.readSync(fd, header, 0, 4, 0)
    fs.closeSync(fd)
    const magic = header.readUInt32LE(0)
    const isMachO = magic === 0xfeedfacf || magic === 0xfeedface
    const isElf =
      header[0] === 0x7f &&
      header[1] === 0x45 &&
      header[2] === 0x4c &&
      header[3] === 0x46
    if (process.platform === "darwin") return isMachO
    if (process.platform === "linux") return isElf
    return false
  }

  test.skipIf(!binaryRunnable(bundledBinary()))(
    "integration: bundled binary masks email and IP",
    () => {
      const result = Bun.spawnSync([bundledBinary()], {
        stdin: Buffer.from("Contact john@example.com or 192.168.1.1"),
      })
      expect(result.exitCode).toBe(0)
      const stdout = result.stdout.toString()
      expect(stdout).toContain("[EMAIL_REDACTED]")
      expect(stdout).toContain("[IP_REDACTED]")
    },
  )
})
