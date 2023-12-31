chatgames.register_game("Unscramble", chatgames.answer_func)
chatgames.register_game("Write Out Words", chatgames.answer_func)
-- Scramble function
-- Scramble function
local function scramble(str)
    local words = {}
    for word in str:gmatch("%S+") do
        -- Convert each word to title case
        word = word:sub(1,1):upper() .. word:sub(2):lower()

        -- Convert the word into a table of characters
        local chars = {}
        for char in word:gmatch(".") do
            table.insert(chars, char)
        end

        -- Scramble the characters in the word with fewer swaps
        local swap_times = math.floor(#chars / 2) -- Limiting the number of swaps
        for _ = 1, swap_times do
            local i = math.random(#chars)
            local j = math.random(#chars)
            chars[i], chars[j] = chars[j], chars[i]
        end

        -- Reassemble the word and add it to the list
        words[#words + 1] = table.concat(chars)
    end

    -- Return the scrambled sentence
    return table.concat(words, " ")
end

-- Generate questions from registered items
for item_name, item_def in pairs(minetest.registered_items) do
    -- Use the description field as the human-readable name
    local human_readable_name = item_name

    if human_readable_name and human_readable_name ~= "" then
        -- Remove everything before and including the colon, and replace underscores with spaces
        human_readable_name = human_readable_name:gsub(".*:", ""):gsub("_", " ")

        -- Register question for "Write Out Words" game
        chatgames.register_question("Write Out Words", "Write out the words '" .. human_readable_name .. "'", human_readable_name, false)
        
        -- Scramble the human-readable name
        local scrambled_name = scramble(human_readable_name)

        -- Register the question for "Unscramble" game
        chatgames.register_question("Unscramble", "Unscramble the text '" .. scrambled_name .. "'", human_readable_name, false)
    end
end

