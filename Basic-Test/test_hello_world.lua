function contains_print_statement(code)
    -- Vérifie si le code utilisateur contient un appel à print
    return string.match(code, "print%(") ~= nil
end

function final_is_not_equal(user_output, expected_output_user)
    -- Vérifie si la sortie utilisateur correspond à la sortie attendue
    if user_output == expected_output_user then
        return true
    else
        return false
    end
end

function run_test(user_code, user_output, expected_output_user)
    -- Test 1: Vérifie si la sortie utilisateur correspond à la sortie attendue
    if final_is_not_equal(user_output, expected_output_user) then
        print("Test Passed 1/2")
    else
        print("Test Failed 1/2: Output is not equal to expected output")
        print(user_output)
        print(expected_output_user)
    end

    -- Test 2: Vérifie si le code utilisateur contient au moins un `print`
    if contains_print_statement(user_code) then
        print("Test Passed 2/2")
    else
        print("Test Failed 2/2: No print statement found in the code")
    end
end

-- Appel de la fonction run_test avec les variables user_code, user_output et expected_output_user
run_test(user_code, user_output, expected_output_user)
