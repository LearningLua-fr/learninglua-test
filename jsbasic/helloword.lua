
local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function normalize_string(str)
    local normalized = string.gsub(str, "%s+", " ")
    normalized = string.gsub(normalized, "^%s*(.-)%s*$", "%1")
    return normalized
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

local function run_test(user_code, user_output, expected_output_user)
    if final_is_equal(user_output, expected_output_user) then
        print("Test Passed 1/2: La sortie correspond à la sortie attendue.")
    else
        print("Test Failed 1/2: La sortie ne correspond pas à la sortie attendue.")
    end

    if contains_console_log(user_code) then
        print("Test Passed 2/2: Instruction console.log trouvée dans le code.")
    else
        print("Test Failed 2/2: Aucune instruction console.log trouvée dans le code.")
    end

    if final_is_equal(user_output, expected_output_user) and contains_console_log(user_code) then
        print("Tous les tests ont réussi.")
    else
        print("Certains tests ont échoué. Veuillez revoir votre code et votre sortie.")
    end
end

run_test(user_code, user_output, expected_output_user)

