function contains_table_declaration(code)
    return string.match(code, "local%s+myTable%s*=%s*{10%s*,%s*20%s*,%s*30%s*,%s*40%s*,%s*50%s*}") ~= nil
end

function contains_first_element_print(code)
    return string.match(code, "print%s*%(%s*myTable%[1%]%s*%)") ~= nil
end

function contains_last_element_print(code)
    return string.match(code, "print%s*%(%s*myTable%[%s*#myTable%s*%]%s*%)") ~= nil
end

function run_test(user_code)
    if contains_table_declaration(user_code) then
        print("Test Passed 1/3: Table 'myTable' is correctly defined")
    else
        print("Test Failed 1/3: Table 'myTable' is missing or incorrect")
    end

    if contains_first_element_print(user_code) then
        print("Test Passed 2/3: First element is correctly printed")
    else
        print("Test Failed 2/3: First element is missing or incorrect")
    end

    if contains_last_element_print(user_code) then
        print("Test Passed 3/3: Last element is correctly printed")
    else
        print("Test Failed 3/3: Last element is missing or incorrect")
    end

    if contains_table_declaration(user_code) and contains_first_element_print(user_code) and contains_last_element_print(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code)
