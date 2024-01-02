local function clean_human_readable_name(name)
    -- Remove colons and anything before it
    name = name:gsub(".-:", "")

    -- Replace underscores with spaces
    name = name:gsub("_", " ")

    -- Remove parentheses and anything between them, non-greedily
    name = name:gsub("%([^)]+%)", "")

    -- Remove Whitespaces and Chars which are not typeable by Player
    name = name:trim()
    name = name:gsub("\x1BE", "")
    name = name:gsub("\x1B", "")

    return name
end



chatgames.register_game("Unscramble", chatgames.answer_func)
chatgames.register_game("Write Out Words", chatgames.answer_func)
-- Scramble function
local function scramble(str)
    local words = {}
    for word in str:gmatch("%S+") do
        -- Convert the word into a table of characters, excluding non-alphabetic characters
        local chars = {}
        for char in word:gmatch("%a") do
            table.insert(chars, char)
        end

        -- Scramble the characters in the word with fewer swaps
        local swap_times = math.floor(#chars / 2)
        for _ = 1, swap_times do
            local i = math.random(#chars)
            local j = math.random(#chars)
            chars[i], chars[j] = chars[j], chars[i]
        end

        -- Reinsert non-alphabetic characters into their original positions
        local scrambled_word = ""
        local char_index = 1
        for i = 1, #word do
            if word:sub(i,i):match("%a") then
                scrambled_word = scrambled_word .. chars[char_index]
                char_index = char_index + 1
            else
                scrambled_word = scrambled_word .. word:sub(i,i)
            end
        end

        words[#words + 1] = scrambled_word
    end

    -- Return the scrambled sentence
    return table.concat(words, " ")
end


-- Generate questions from registered items
for item_name, item_def in pairs(minetest.registered_items) do
    -- Use the description field as the human-readable name
    local human_readable_name = ItemStack(item_name):get_short_description()

    if human_readable_name and human_readable_name readable name: " .. human_readable_name) then
    -- Remove colons and replace underscores w~= "" then
        minetest.log("action", "[chatgames] human-readable name: " .. human_readable_name)
        -- Remove colons and replace underscores with spaces
        human_readable_name = clean_human_readable_name(human_readable_name)
        minetest.log("action", "[chatgames] Cleaned human-readable name: " .. human_readable_name)

        -- Register question for "Write Out Words" game
        chatgames.register_question("Write Out Words", "Write out the words '" .. human_readable_name .. "'", human_readable_name, false)
        
        -- Scramble the human-readable name
        local scrambled_name = scramble(human_readable_name)

        -- Register the question for "Unscramble" game
        chatgames.register_question("Unscramble", "Unscramble the text '" .. scrambled_name .. "'", human_readable_name, false)
    end
end

