chatgames.register_game("Write Out Random", chatgames.answer_func)

-- Generate questions from random letters and numbers 1-16 characters.
for i = 1, 100 do
    local random_string = ""
    local length = math.random(1, 16)
    for j = 1, length do
        local random_char = math.random(1, 36)
        if random_char <= 26 then
            random_string = random_string .. string.char(random_char + 96)
        else
            random_string = random_string .. tostring(random_char - 26)
        end
    end
    chatgames.register_question("Write Out Random", "Write out the text '" .. random_string .. "'", random_string, false)
end