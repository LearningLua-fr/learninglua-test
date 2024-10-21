function contains_print_statement(code)
    return string.match(user_code, "print%(") ~= nil
end

function final_is_not_equal(code, user_output, expected_output_user)
    if user_output == expected_output_user then
        return true
    else
        return false
    end
end

function run_test(code)
    if final_is_not_equal(user_code, user_output, expected_output_user) then
    print("Test Passed 1/2")
    else
        print("Test Failed! 2 //Output is not equal to expected output"..user_output.." "..expected_output_user)
    end

    if contains_print_statement(user_code) then
        print("Test Passed 2/2")
    else
        print("Test Failed! 2 //No print on code")
    end
end

run_test(user_code, user_output, expected_output_user)
