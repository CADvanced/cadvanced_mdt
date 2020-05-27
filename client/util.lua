-- Send a chat message
function sendChat(message)
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        multiline = true,
        args = { "MDT", message }
    })
end
