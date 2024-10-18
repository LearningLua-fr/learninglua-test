function run_test(user_code, user_output, expected_output)
    if user_output == expected_output then
        print("Test Passed!")
    else
        print("Test Failed!")
        print("User Code: \n" .. user_code)
        print("Expected Output: " .. expected_output)
        print("User Output: " .. user_output)
    end
end

-- Simule l'exécution du code utilisateur et retourne un résultat fictif pour les tests
function execute_user_code(user_code)
    -- Cette fonction devrait exécuter réellement le code Lua
    -- Pour l'exemple, nous retournons un résultat attendu simulé
    return [[
Name: Max
Age: 25
Job: Developer
Name: Jenna
Age: 30
Job: Designer
]]
end

-- Code soumis par l'utilisateur (exemple)
local user_code = [[
    local person = {
        {name = "Max", age = 25, job = "Developer"},
        {name = "Jenna", age = 30, job = "Designer"}
    }

    for i = 1, #person do
        print("Name: " .. person[i].name)
        print("Age: " .. person[i].age)
        print("Job: " .. person[i].job)
    end
]]

-- Résultat attendu
local expected_output = [[
Name: Max
Age: 25
Job: Developer
Name: Jenna
Age: 30
Job: Designer
]]

-- Simuler l'exécution du code utilisateur
local user_output = execute_user_code(user_code)

-- Effectuer plusieurs tests

-- Test 1 : Vérifier si le tableau a été correctement itéré
local partial_output_test1 = "Name: Max\nAge: 25\nJob: Developer\n"
run_test(user_code, user_output:sub(1, #partial_output_test1), partial_output_test1)

-- Test 2 : Vérifier si la seconde personne est correctement affichée
local partial_output_test2 = "Name: Jenna\nAge: 30\nJob: Designer\n"
run_test(user_code, user_output:sub(-#partial_output_test2), partial_output_test2)

-- Test 3 : Vérifier l'output complet
run_test(user_code, user_output, expected_output)
