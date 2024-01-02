-- Example answer function
function chatgames.calculate_reward(time_given_in_seconds, time_left_in_seconds)
    if time_given_in_seconds <= 0 then
        return 0 -- Avoid division by zero
    end

    local time_used = time_given_in_seconds - time_left_in_seconds
    local speed_ratio = time_used / time_given_in_seconds

    -- Calculate reward, adjust the multiplier to scale the reward
    local reward = (1 - speed_ratio) * 10

    return math.floor(reward) -- Ensure the reward is a whole number
end

function chatgames.answer_func(game_name, player_name, attempt_str, time_given_in_seconds, time_used, question_id_selected)
    local question_data = chatgames.games[game_name].questions[question_id_selected]
    
    -- Trim the answer and attempt, and convert to lower case if not case sensitive
    local answer = question_data.is_case_sensitive and question_data.answer or question_data.answer:lower():match("^%s*(.-)%s*$")
    local player_attempt = question_data.is_case_sensitive and attempt_str or attempt_str:lower():match("^%s*(.-)%s*$")
    
    local player = minetest.get_player_by_name(player_name)

    if answer == player_attempt then
        local reward = chatgames.calculate_reward(time_given_in_seconds, time_given_in_seconds - time_used)
        emeraldbank.add_emeralds(player, reward)
        return true
    else
        return false
    end
end



local modpath = minetest.get_modpath("chatgames")
local src_path = modpath .. "/src/"
dofile(src_path .. "scramble_and_write_out_words.lua")
dofile(src_path .. "write_out_random.lua")