import { describe, expect, test } from "bun:test"
import DesignRemindersPlugin from "../opencode/plugins/design-reminders.js"

const hooks = await DesignRemindersPlugin()
const transform = hooks["experimental.chat.messages.transform"]

function userMessage(agent) {
  return {
    info: { id: "msg_u", sessionID: "ses_1", role: "user", agent },
    parts: [],
  }
}

function assistantMessage(agent) {
  return {
    info: { id: "msg_a", sessionID: "ses_1", role: "assistant", agent },
    parts: [],
  }
}

async function run(messages) {
  const output = { messages }
  await transform({}, output)
  return output
}

describe("design-reminders plugin", () => {
  test("appends DESIGN reminder when active agent is design", async () => {
    const out = await run([userMessage("design")])
    const parts = out.messages[0].parts
    expect(parts).toHaveLength(1)
    expect(parts[0].synthetic).toBe(true)
    expect(parts[0].type).toBe("text")
    expect(parts[0].text).toContain("CRITICAL OPERATIONAL MODE: DESIGN")
    expect(parts[0].text).toContain(
      "Prefer the `explore` subagent to scan files.",
    )
    expect(parts[0].id.startsWith("prt_")).toBe(true)
    expect(parts[0].messageID).toBe("msg_u")
    expect(parts[0].sessionID).toBe("ses_1")
  })

  test("appends BUILD reminder when build follows design history", async () => {
    const out = await run([assistantMessage("design"), userMessage("build")])
    const parts = out.messages[1].parts
    expect(parts).toHaveLength(1)
    expect(parts[0].synthetic).toBe(true)
    expect(parts[0].text).toContain("CRITICAL OPERATIONAL MODE: BUILD")
  })

  test("appends no reminder in a build-only session", async () => {
    const out = await run([assistantMessage("build"), userMessage("build")])
    expect(out.messages[1].parts).toHaveLength(0)
  })

  test("appends DEBUG reminder when debug follows design history", async () => {
    const out = await run([assistantMessage("design"), userMessage("debug")])
    const parts = out.messages[1].parts
    expect(parts).toHaveLength(1)
    expect(parts[0].synthetic).toBe(true)
    expect(parts[0].text).toContain("CRITICAL OPERATIONAL MODE: DEBUG")
  })

  test("appends no reminder in a debug-only session", async () => {
    const out = await run([assistantMessage("debug"), userMessage("debug")])
    expect(out.messages[1].parts).toHaveLength(0)
  })

  test("appends no reminder for other agents", async () => {
    const out = await run([userMessage("explore")])
    expect(out.messages[0].parts).toHaveLength(0)
  })

  test("no-ops safely on empty or malformed input", async () => {
    await expect(transform({}, {})).resolves.toBeUndefined()
    const out = await run([])
    expect(out.messages).toHaveLength(0)
    const noUser = await run([assistantMessage("build")])
    expect(noUser.messages[0].parts).toHaveLength(0)
  })
})
