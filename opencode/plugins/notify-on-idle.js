const fallbackMessage = "opencode finished";

const latestQuestionBySession = new Map();
const notifiedMessageBySession = new Map();

function appleScriptString(value) {
  return String(value).replaceAll("\\", "\\\\").replaceAll('"', '\\"');
}

function questionFromParts(parts) {
  const text = parts
    .filter((part) => part.type === "text")
    .map((part) => part.text)
    .join("\n")
    .trim();

  return text || fallbackMessage;
}

export const NotifyOnIdle = async ({ $ }) => {
  return {
    "chat.message": async (input, output) => {
      latestQuestionBySession.set(input.sessionID, {
        id: output.message.id,
        text: questionFromParts(output.parts),
      });
    },

    event: async ({ event }) => {
      if (event.type !== "session.idle") return;

      const sessionID = event.properties.sessionID;
      const question = latestQuestionBySession.get(sessionID);
      if (!question) return;
      if (notifiedMessageBySession.get(sessionID) === question.id) return;

      notifiedMessageBySession.set(sessionID, question.id);

      const body = appleScriptString(question.text);
      await $`osascript -e ${`display notification "${body}" with title "opencode"`}`;
    },
  };
};
