function contains_table_declaration(code)
    return string.match(code, "local%s+myTable%s*=%s*{}") ~= nil
end

function contains_table_insert(code)
    local insert_1 = string.match(code, "table%.insert%s*%(%s*myTable%s*,%s*%d+%s*%)")
    return insert_1 ~= nil
end

function contains_for_loop(code)
    return string.match(code, "for%s+i%s*=%s*1%s*,%s*#myTable%s*do") ~= nil
end

function contains_print_call(code)
    return string.match(code, "print%s*%(%s*myTable%[i%]%s*%)") ~= nil
end

function run_test(user_code)
    if contains_table_declaration(user_code) then
        print("Test Passed 1/4: Table 'myTable' is correctly defined as empty")
    else
        print("Test Failed 1/4: Table 'myTable' is missing or not correctly defined")
    end

    if contains_table_insert(user_code) then
        print("Test Passed 2/4: Elements are inserted using 'table.insert'")
    else
        print("Test Failed 2/4: 'table.insert' is missing or incorrect")
    end

    if contains_for_loop(user_code) then
        print("Test Passed 3/4: For loop is correctly defined")
    else
        print("Test Failed 3/4: For loop is missing or incorrect")
    end

    if contains_print_call(user_code) then
        print("Test Passed 4/4: Print statement is correct")
    else
        print("Test Failed 4/4: Print statement is missing or incorrect")
    end

    if contains_table_declaration(user_code) and contains_table_insert(user_code) and contains_for_loop(user_code) and contains_print_call(user_code) then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code)
