function contains_print_statement(code)
    return string.match(code, "print%(") ~= nil
end

local passed = 0
local failed = 0

function final_is_not_equal(user_output, expected_output)
    if user_output == expected_output then
        return true
    else
        return false
    end
end

function run_test(user_code, user_output, expected_output)
    -- Test 1: Vérifier si la sortie est égale à la sortie attendue
    if final_is_not_equal(user_output, expected_output) then
        print("Test Passed 1/2")
        passed = passed + 1
    else
        print("Test Failed 0/2 // Output is not equal to expected output")
        failed = failed + 1
    end

    -- Test 2: Vérifier s'il y a au moins un `print` dans le code utilisateur
    if contains_print_statement(user_code) then
        print("Test Passed 2/2")
        passed = passed + 1
    else
        print("Test Failed 1/2 // No print statement in code")
        failed = failed + 1
    end

    -- Afficher le récapitulatif des tests
    print_test_summary()
end

-- Fonction pour afficher le récapitulatif final
function print_test_summary()
    print("Test Summary: " .. passed .. " passed, " .. failed .. " failed.")
end

-- Appeler la fonction run_test avec les variables user_code, user_output, expected_output
run_test(user_code, user_output, expected_output)
