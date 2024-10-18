-- Utilisation de Busted comme framework de test
describe("Hello World Test", function()
    
    it("should print 'Hello, World!'", function()
        -- Capture la sortie du programme utilisateur
        local output = io.popen("lua hello_world.lua"):read("*a")

        -- Comparer avec la sortie attendue
        assert.are.equal("Hello, World!\n", output)
    end)

end)
