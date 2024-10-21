
function contains_print_statement(code)
    return string.match(user_code, "print%(") ~= nil
end

function run_test(code)
    if contains_print_statement(user_code) then
        print("Test Passed 1/1")
    else
        print("Test Failed! 1/1 //No print on code")
    end
end

run_test(user_code)
