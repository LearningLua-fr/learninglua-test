function contains_function_declaration(code)
    return string.match(code, "function%s+IterateFruits%s*%(%s*%)") ~= nil
end

function contains_ipairs_loop(code)
    return string.match(code, "for%s+[%w_]+,%s*[%w_]+%s+in%s+ipairs%(%s*[%w_]+%s*%)") ~= nil
end


function contains_fruits_array(code)
    return string.match(code, '{%s*"Apple",%s*"Banana",%s*"Orange",%s*"Strawberry",%s*"Mango"%s*}') ~= nil
end

function capture_user_output(user_function)
    local output = {}
    local original_print = print
    print = function(str) table.insert(output, str) end

    local success, err = pcall(user_function)
    if not success then
        print("Error in user function: " .. tostring(err))
    end

    print = original_print  
    return table.concat(output, "\n")
end

-- Main test function
function run_test(user_code, user_function)
    local test_passed = 0
    local total_tests = 4

    if contains_function_declaration(user_code) then
        print("Test Passed 1/4: Function 'IterateFruits' is correctly defined")
        test_passed = test_passed + 1
    else
        print("Test Failed 1/4: Function 'IterateFruits' is missing or incorrect")
    end

    if contains_fruits_array(user_code) then
        print("Test Passed 2/4: Array 'fruits' is correctly defined")
        test_passed = test_passed + 1
    else
        print("Test Failed 2/4: Array 'fruits' is missing or incorrectly defined")
    end

    if contains_ipairs_loop(user_code) then
        print("Test Passed 3/4: Loop with 'ipairs' is correctly defined")
        test_passed = test_passed + 1
    else
        print("Test Failed 3/4: Loop with 'ipairs' is missing or incorrect")
    end

    local user_output = capture_user_output(user_function)
    if user_output == expected_output then
        print("Test Passed 4/4: Function outputs expected result")
        test_passed = test_passed + 1
    else
        print(string.format("Test Failed 4/4: Expected output '%s', but got '%s'", expected_output, user_output))
    end

    -- Résumé final
    if test_passed == total_tests then
        print("All tests passed")
    else
        print(string.format("%d/%d tests passed", test_passed, total_tests))
    end
end

-- Fonction utilisateur
local function user_function()
    IterateFruits()
end

run_test(user_code, user_function)
