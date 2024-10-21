function contains_function_declaration(code)
    return string.match(code, "function%s+double%s*%(%s*n%s*%)") ~= nil
end

function contains_correct_return_statement(code)
    return string.match(code, "return%s+n%s*%*%s*2") ~= nil
end

function contains_print_call(code)
    return string.match(code, "print%s*%(%s*double%s*%(%s*%d+%s*%)%s*%)") ~= nil
end

function contains_no_triple(code)
    return string.match(code, "return%s+n%s*%*%s*3") == nil
end

function run_test(user_code)
    if contains_function_declaration(user_code) then
        print("Test Passed 1/3: Function 'double' is correctly defined")
    else
        print("Test Failed 1/3: Function 'double' is missing or incorrect")
    end

    if contains_correct_return_statement(user_code) and contains_no_triple(user_code) then
        print("Test Passed 2/3: Return statement is correct and does not triple")
    else
        print("Test Failed 2/3: Return statement is incorrect or triples the value")
    end

    if contains_print_call(user_code) then
        print("Test Passed 3/3: Function 'double' is correctly printed")
    else
        print("Test Failed 3/3: Function 'double' is not printed or print statement is incorrect")
    end

    if contains_function_declaration(user_code) and contains_correct_return_statement(user_code) and contains_print_call(user_code) and contains_no_triple(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code)
