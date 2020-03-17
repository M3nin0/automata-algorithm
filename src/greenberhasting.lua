--[[
    Estados: resting (Descansando)
             excited (Exitado)
             recovery (Recuperação)
--]]

local GreenberHastingModel = Model{
    dim = 70, -- 50x50
    probability = 1,
    finalTime = 7,
    discreteT = 0,
    execute = function(model)
        model.map:save("imagens/greenberhastingmodel_t" .. model.discreteT .. ".png")
        model.discreteT = model.discreteT + 1
    end,
    init = function(self)
        self.cell = Cell{
            -- Define o estado da celula de forma aleatória
            -- (Considerando a probabilidade para cada estado inserida acima)
            state = Random{resting = self.probability / 3, excited = self.probability / 3, recovery = self.probability / 3},

            execute = function(actualCell)
                local neighborIsExcited = 0

                -- Verificando se alguma celula vizinha está exitada
                forEachNeighbor(actualCell, function(neighborCell)
                    if neighborCell.past.state == "excited" then
                        neighborIsExcited = 1
                    end
                end)

                if actualCell.past.state == "resting" then
                    if neighborIsExcited == 1 then
                        actualCell.state = "excited"
                    end
                elseif actualCell.past.state == "excited" then
                    actualCell.state = "recovery"
                elseif actualCell.past.state == "recovery" then
                    actualCell.state = "resting"
                end
            end
        }
        self.cs = CellularSpace{
            xdim = self.dim,
            instance = self.cell
        }
        self.cs:createNeighborhood{wrap = true}

        self.map = Map{
            target = self.cs,
            select = "state",
            value = {"resting", "excited", "recovery"},
            color = {"gray", "green", "yellow"}
        }

        self.timer = Timer{
            Event{action = self},
            Event{action = self.cs}, -- Sincroniza o CellularSpace
            Event{action = self.map} -- Atualiza o mapa de exibição
        }
    end
}

GreenberHastingModel:run()
