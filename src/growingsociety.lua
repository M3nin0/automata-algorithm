StateEnum = {};
StateEnum.empty = "empty"
StateEnum.complete = "complete"

local GrowingSociety = Model{
    quantity = 10,
    dim = 100,
    finalTime = 120,
    init = function(model)
        -- Criando agente
        model.agent = Agent{
            execute = function(self)
                local cell = self:emptyNeighbor()

                if cell and Random{p = 0.3}:sample() then
                    local child = self:reproduce()
                    child:move(cell)
                end

                cell = self:emptyNeighbor()
                if cell then
                   self:move(cell)
                end
        end
        }
        -- Criando sociente (Conjunto de agentes)
        model.soc = Society{
            instance = model.agent,
            quantity = model.quantity
        }
        model.cell = Cell{
            state = function(self)
                if self:isEmpty() then
                    return StateEnum.empty
                else
                    return StateEnum.complete
                end
            end
        }
        model.cs = CellularSpace{
            xdim = model.dim,
            instance = model.cell
        }
        model.cs:createNeighborhood()

        -- Criando ambiente para vincular espaço e comportamento (Dos agentes)
        model.env = Environment{
            model.cs,
            model.soc
        }

        -- Por padrão será um agente por celula
        model.env:createPlacement()

        -- Visualização dos resultados
        model.map = Map{
            target = model.cs,
            select = "state",
            value = {"full", "empty"},
            color = {"red", "blue"}
        }

        model.chart = Chart{
            target = model.soc
        }
        model.timer = Timer{
            Event{action = model.soc},
            Event{action = model.map},
            Event{action = model.chart}
        }
    end
}

GrowingSociety:run()

