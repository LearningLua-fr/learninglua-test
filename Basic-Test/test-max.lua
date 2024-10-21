function contains_function_declaration(code)
    return string.match(code, "function%s+max%s*%(%s*a%s*,%s*b%s*%)") ~= nil
end

function contains_correct_if_statement(code)
    return string.match(code, "if%s*a%s*>%s*b%s*then") ~= nil
end

function contains_print_call(code)
    return string.match(code, "print%s*%(%s*max%s*%(%s*%d+%s*,%s*%d+%s*%)%s*%)") ~= nil
end

function contains_correct_return_statement(code)
    return string.match(code, "return%s+a") ~= nil or string.match(code, "return%s+b") ~= nil
end

function run_test(user_code)
    if contains_function_declaration(user_code) then
        print("Test Passed 1/4: Function 'max' is correctly defined")
    else
        print("Test Failed 1/4: Function 'max' is missing or incorrect")
    end

    if contains_correct_if_statement(user_code) then
        print("Test Passed 2/4: If statement is correctly used")
    else
        print("Test Failed 2/4: If statement is missing or incorrect")
    end

    if contains_correct_return_statement(user_code) then
        print("Test Passed 3/4: Return statement is correct")
    else
        print("Test Failed 3/4: Return statement is incorrect")
    end

    if contains_print_call(user_code) then
        print("Test Passed 4/4: Function 'max' is correctly printed")
    else
        print("Test Failed 4/4: Function 'max' is not printed or print statement is incorrect")
    end

    if contains_function_declaration(user_code) and contains_correct_if_statement(user_code) and contains_correct_return_statement(user_code) and contains_print_call(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code)
