local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if not string.match(user_code, "#include%s*<stdio.h>") then
        print("Test Failed 1/4: Missing stdio.h")
        passed = false
    else
        print("Test Passed 1/4: Includes stdio.h")
    end

    if not string.match(user_code, "int%s+[a-zA-Z_][a-zA-Z0-9_]*%s*=%s*7") or not string.match(user_code, "int%s+[a-zA-Z_][a-zA-Z0-9_]*%s*=%s*12") then
        print("Test Failed 2/4: Missing correct int values (7 and 12)")
        passed = false
    else
        print("Test Passed 2/4: Declared correct integers")
    end

    if not string.match(user_code, "printf%s*%(") then
        print("Test Failed 3/4: printf not used")
        passed = false
    else
        print("Test Passed 3/4: printf used")
    end

    if user_output == expected_output_user then
        print("Test Passed 4/4: Output is correct")
    else
        print("Test Failed 4/4: Output is incorrect")
        passed = false
    end

    if passed then
        print("All tests passed!")
    else
        print("Some tests failed.")
    end
end

run_test(user_code, user_output, "19")
