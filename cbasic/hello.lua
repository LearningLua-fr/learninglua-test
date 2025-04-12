local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if not string.match(user_code, "#include%s*<stdio.h>") then
        print("Test Failed 1/4: Missing #include <stdio.h>")
        passed = false
    else
        print("Test Passed 1/4: Includes stdio.h")
    end

    if not string.match(user_code, "printf%s*%(") then
        print("Test Failed 2/4: printf not used")
        passed = false
    else
        print("Test Passed 2/4: printf used")
    end

    if string.match(user_code, "puts%s*%(") then
        print("Test Failed 3/4: puts is used (forbidden)")
        passed = false
    else
        print("Test Passed 3/4: puts not used")
    end

    if user_output == expected_output_user then
        print("Test Passed 4/4: Output matches expected")
    else
        print("Test Failed 4/4: Output incorrect")
        passed = false
    end

    if passed then
        print("All tests passed!")
    else
        print("Some tests failed.")
    end
end

run_test(user_code, user_output, expected_output_user)
