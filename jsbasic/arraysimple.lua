-- Vérifie si la variable 'Week' est utilisée (case-insensitive)
local function contains_array_declaration(code)
    return string.match(code, "[Ww]eek%s*=%s*%[") ~= nil
end

-- Vérifie si le 5e élément du tableau est affiché (Week[4] en JS, si on commence à 0)
local function contains_correct_console_log(code)
    return string.match(code, "console%.log%s*%(%s*[Ww]eek%s*%[%s*4%s*%]%s*%)") ~= nil
end

-- Nettoie les espaces et les sauts de ligne
local function normalize_string(str)
    local normalized = string.gsub(str, "%s+", " ")
    normalized = string.gsub(normalized, "^%s*(.-)%s*$", "%1")
    return normalized
end

-- Compare sortie utilisateur et résultat attendu
local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

-- Lance les tests
local function run_test(user_code, user_output, expected_output_user)
    local success = true

    -- Test 1 : La sortie affichée est correcte
    if final_is_equal(user_output, expected_output_user) then
        print("Test Passed 1/3: Output matches expected value.")
    else
        print("Test Failed 1/3: Output is incorrect.")
        success = false
    end

    -- Test 2 : L'utilisateur a bien créé un tableau nommé Week
    if contains_array_declaration(user_code) then
        print("Test Passed 2/3: Array 'Week' declared correctly.")
    else
        print("Test Failed 2/3: Array 'Week' not declared.")
        success = false
    end

    -- Test 3 : Vérifie que l'utilisateur imprime Week[4]
    if contains_correct_console_log(user_code) then
        print("Test Passed 3/3: Correct element accessed with console.log.")
    else
        print("Test Failed 3/3: Wrong or missing console.log statement.")
        success = false
    end

    -- Résumé final
    if success then
        print("All tests passed.")
    else
        print("Some tests failed. Please review your code and output.")
    end
end

run_test(user_code, user_output, expected_output_user)
