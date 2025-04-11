-- Vérifie si la fonction 'isNumeric' est présente dans le code
local function contains_is_numeric(code)
    return string.match(code, "function%s+isNumeric%s*%(") ~= nil
end

-- Vérifie si la fonction 'isNumeric' contient exactement deux instructions 'return'
local function contains_two_returns(code)
    local return_count = 0
    for _ in string.gmatch(code, "return") do
        return_count = return_count + 1
    end
    return return_count == 2
end

-- Vérifie si le code contient exactement une instruction 'console.log'
local function contains_one_print(code)
    return string.match(code, "console.log%s*%(") ~= nil
end

-- Normalise les chaînes de caractères en éliminant les espaces superflus et les retours à la ligne
local function final_is_equal(user_output, expected_output_user)
    -- Supprime les espaces et les retours à la ligne (caractères de fin de ligne)
    local normalized_user_output = string.gsub(user_output, "%s+", "")
    local normalized_expected_output = string.gsub(expected_output_user, "%s+", "")
    return normalized_user_output == normalized_expected_output
end

-- Fonction principale pour exécuter les tests
local function run_test(user_code, user_output, expected_output_user)
    local tests_passed = true

    -- Test 1 : Vérifie la présence de la fonction 'isNumeric'
    if contains_is_numeric(user_code) then
        print("Test Passed 1/4: 'isNumeric' function is defined.")
    else
        print("Test Failed 1/4: 'isNumeric' function is not defined.")
        tests_passed = false
    end

    -- Test 2 : Vérifie qu'il y a exactement deux 'return' dans la fonction
    if contains_two_returns(user_code) then
        print("Test Passed 2/4: 'isNumeric' contains exactly two return statements.")
    else
        print("Test Failed 2/4: 'isNumeric' does not contain exactly two return statements.")
        tests_passed = false
    end

    -- Test 3 : Vérifie qu'il y a une instruction 'console.log'
    if contains_one_print(user_code) then
        print("Test Passed 3/4: 'isNumeric' contains exactly one print statement.")
    else
        print("Test Failed 3/4: 'isNumeric' does not contain exactly one print statement.")
        tests_passed = false_
